package com.project.web;

import java.io.PrintWriter;
import java.security.Principal;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.domain.BoardVO;
import com.project.domain.Criteria;
import com.project.domain.MemberVO;
import com.project.domain.OrderVO;
import com.project.security.UserDetailsVO;
import com.project.service.BoardService;
import com.project.service.CartService;
import com.project.service.MemberService;
import com.project.service.ProductsService;

@Controller
@RequestMapping("member")
public class MemberController {

	@Autowired
	private MemberService service;
	@Autowired
	private CartService cartservice;
	@Autowired
	private ProductsService proservice;
	@Autowired
	private BoardService boardservice;
	@Autowired
	BCryptPasswordEncoder pwencoder;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	
//	회원정보 보기 화면
	@RequestMapping(value="info", method = RequestMethod.GET)
	public void infoget(MemberVO member,Model model, Principal principal) throws Exception {
		
		member.setUserid(principal.getName());
		model.addAttribute("meminfo",service.readmember(member));
		
		//oauth2 로그인 정보
		if(principal.getName().contains("@")) {
			member.setUserid(principal.getName());
			model.addAttribute("meminfo",member);
		}
	}
	
//	회원정보 수정 화면
	@RequestMapping(value="modify", method = RequestMethod.GET)
	public void modifyget(MemberVO member,Model model,Principal principal) throws Exception {
		member.setUserid(principal.getName());
		model.addAttribute("meminfo",service.readmember(member));
	}
	
//	회원정보 수정 처리
	@RequestMapping(value="modify", method = RequestMethod.POST)
	public String modifypost(RedirectAttributes rttr, Principal principal,MemberVO member,String useradd1, String useradd2,String curpwd) throws Exception {
		member.setUseradd(useradd1, useradd2);
		
		if(principal.getName().equals(member.getUserid())) {
		
			MemberVO dbmeminfo = service.memcheck(principal.getName());
			
			//비밀번호를 바꾸지 않으면
			if(member.getUserpw().equals("")) {
				member.setUserpw(dbmeminfo.getUserpw());
				logger.info("회원정보 수정 처리"+member);
				service.updatemember(member);
				return "redirect:/member/info";
			} else {
				
				//비밀번호를 바꿀 때
				//현재 비밀번호와 입력한 비밀번호가 맞다면
				if(pwencoder.matches(curpwd, dbmeminfo.getUserpw())){
					member.setUserpw(pwencoder.encode(member.getUserpw()));
					service.updatemember(member);
					return "redirect:/member/info";
					
				} else {
					
				//현재 비밀번호와 입력한 비밀번호가 맞지 않으면
					rttr.addFlashAttribute("msg","현재 비밀번호가 일치 하지 않습니다.");
					return "redirect:/member/modify";
				}
			}
		} else {
			//로그인 정보 불일치
			rttr.addFlashAttribute("err","로그인 정보 불일치");
			return "redirect:/member/modify";
		}
		
	}
	
//	회원정보 삭제 처리
	@RequestMapping(value="deletemem", method = RequestMethod.POST)
	public String deletepost(MemberVO member) throws Exception {
		logger.info("회원정보 삭제 처리"+member);
		service.deletemember(member);
		return "redirect:/";
	}
	
//	아이디 중복 확인
	@RequestMapping(value="idcheck/{userid}", method = RequestMethod.GET)
	public ResponseEntity<Integer> idcheck(@PathVariable("userid") String userid) throws Exception {
		logger.info("idcheck id:"+userid);
		return new ResponseEntity<Integer>(service.idcheck(userid),HttpStatus.OK);
	}
	
	
//	주문 목록 화면
	@RequestMapping(value="orderlist", method = RequestMethod.GET)
	public void orderlistget(OrderVO vo,Principal principal,Model model, HttpSession session) throws Exception{
		if(principal != null) {
			vo.setUserid(principal.getName());
		} 
		logger.info("주문 목록 화면"+vo);
		model.addAttribute("userorderlist",cartservice.viewordersheet(vo));
		
	}
	
	
//			관리자 페이지
	
	
//	관리자 페이지 화면
	@RequestMapping(value="adminpage", method = RequestMethod.GET)
	public void adminpageget(String type,Model model,BoardVO vo,Criteria cri) throws Exception{
//		logger.info("관리자 페이지 type : "+type);
		if(type != null) {
			//회원관리
			if(type.equals("member")) {
				model.addAttribute("memberlist", service.adminmemberlist());
			//상품관리	
			} else if(type.equals("product")){
				model.addAttribute("productlist", proservice.productlistall(cri));
			//주문관리
			} else if(type.equals("order")){
				model.addAttribute("orderlist", cartservice.viewordersheet(new OrderVO()));
				
			//게시물 관리	
			} else if(type.equals("board")) {
				model.addAttribute("board", vo.getBtype());
				model.addAttribute("boardlist", boardservice.boardlist(vo,cri));
				
			}
			
		} 
	}
	
//	회원 정보 목록 화면
	@RequestMapping(value="adminmember", method = RequestMethod.GET)
	public void adminmemberlistget(Model model) throws Exception{
		logger.info("관리자 페이지 - 회원 목록");
		model.addAttribute("memberlist", service.adminmemberlist());
		
	}
	
	
	
	
	
}
