package com.project.web;


import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.BoardVO;
import com.project.domain.CartVO;
import com.project.domain.Criteria;
import com.project.domain.MemberVO;
import com.project.domain.OrderVO;
import com.project.domain.ProductsVO;
import com.project.service.BoardService;
import com.project.service.CartService;
import com.project.service.MemberService;
import com.project.service.ProductsService;


@Controller
@RequestMapping("product")
public class ProductController {

	@Autowired
	private ProductsService service;
	@Autowired
	private CartService cartservice;
	@Autowired
	private BoardService boardservice;
	@Autowired
	private MemberService memservice;
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	
	
//	제품 전체 불러오기 화면
	@RequestMapping(value="viewall", method = RequestMethod.GET)
	public void productlistall(Model model, Integer pcno, ProductsVO vo, Criteria cri) throws Exception{
		if(pcno != null) {
			vo.setPcno(pcno);
			model.addAttribute("productlist", service.productlistcate(vo));
			
		} else {
			if(cri.getKeyword() != null) {
				logger.info("검색 키워드 : "+cri.getKeyword());
				model.addAttribute("productlist", service.productlistall(cri));
			}
			model.addAttribute("productlist", service.productlistall(cri));
		}
	}
	
	
//	제품보기 화면
	@RequestMapping(value="view", method = RequestMethod.GET)
	public void productall(ProductsVO vo, Model model, BoardVO board, Principal principal) throws Exception{
		
		//제품 정보
		model.addAttribute("product", service.productview(vo));
		
		//후기 게시판 불러오기
		BoardVO review = new BoardVO();
		review.setBtype("review");
		review.setPno(board.getPno());
		model.addAttribute("reviewlist", boardservice.boardlistpno(review));
		
		//문의 게시판 불러오기
		BoardVO qaboard = new BoardVO();
		qaboard.setBtype("qanda");
		qaboard.setPno(board.getPno());
		model.addAttribute("qandalist", boardservice.boardlistpno(qaboard));
		
		//로그인된 사용자 정보
		if (principal != null) {
			model.addAttribute("loginuserid", principal.getName());
		}
		
		
	}
	
	
//	제품 등록 화면
	@RequestMapping(value="register", method = RequestMethod.GET)
	public void productregister() throws Exception{
		
	}
	
//	제품 등록 처리
	@RequestMapping(value="register", method = RequestMethod.POST)
	public String productregisterpost(ProductsVO vo) throws Exception{
		service.register(vo);
		return "redirect:/product/viewall";
	}
	
	
//	제품 수정 화면
	@RequestMapping(value="modify", method = RequestMethod.GET)
	public void productmodifyget(ProductsVO vo,Model model) throws Exception{
		model.addAttribute("product", service.productview(vo));
	}
	
//	제품 수정 처리
	@RequestMapping(value="modify", method = RequestMethod.POST)
	public String productmodifypost(ProductsVO vo) throws Exception{
		service.update(vo);
		return "redirect:/product/view?pno="+vo.getPno();
	}
	
//	제품 삭제 처리
	@RequestMapping(value="delete", method = RequestMethod.POST)
	public String productdeletepost(ProductsVO vo) throws Exception{
		service.delete(vo);
		return "redirect:/product/viewall";
	}
	
	
	
//	--- 장바구니 관련
	
	
//	카트 보기 화면
	
	@RequestMapping(value="cart", method=RequestMethod.GET)
	public void viewcart(CartVO vo,Principal principal,Model model, HttpServletRequest request, HttpSession session) throws Exception{
		if(principal != null) {
			vo.setUserid(principal.getName());
			model.addAttribute("userid",principal.getName());
		} else {
			vo.setUserid(session.getId());
			model.addAttribute("userid",session.getId());
		}
		model.addAttribute("cartlist", cartservice.viewcart(vo));

		
	}
	

	
//	카트 담기
	@ResponseBody
	@RequestMapping(value="addcart", method=RequestMethod.POST)
	public int addcart(CartVO vo,Principal principal, HttpSession session,HttpServletResponse response,HttpServletRequest request) throws Exception{
		
		//로그인 되어있을 때
		if(principal != null) {
			vo.setUserid(principal.getName());
			//이미 카트에 있음
			if(cartservice.checkcart(vo) == 1) {
				return 2;
			} else {
				//담기 성공
				cartservice.addcart(vo);
				return 1;
			}	
		//비회원
		} else {
			vo.setUserid(session.getId());
			//이미 카트에 있음
			if(cartservice.checkcart(vo) == 1) {
				return 2;
			} else {
				//담기 성공
				cartservice.addcart(vo);
				return 1;
			}
		}
	}
	
//	카트 삭제
	@ResponseBody
	@RequestMapping(value="deletecart", method=RequestMethod.POST)
	public int deletecart(CartVO vo, Principal principal, HttpSession session) throws Exception{
		
		//회원 
		if(principal != null) {
			vo.setUserid(principal.getName());
			cartservice.deletecart(vo);
			return 1;
		//비회원 
		} else {
			vo.setUserid(session.getId());
			cartservice.deletecart(vo);
			return 1;
		}
		
	}
	
	
//	카트 갯수 업데이트
	@ResponseBody
	@RequestMapping(value="updatecart", method=RequestMethod.POST)
	public int updatecart(CartVO vo, Principal principal, HttpSession session) throws Exception{
		
		//회원
		if(principal != null) {
			vo.setUserid(principal.getName());
			cartservice.updatecart(vo);
			return 1;
		//비회원	
		} else {
			vo.setUserid(session.getId());
			cartservice.updatecart(vo);
			return 1;
		}
		
	}
	
	
	//--- 주문하기
	
//	주문하기 버튼 클릭
	@RequestMapping(value="cart", method=RequestMethod.POST)
	public String orderpageget(CartVO vo,Principal principal,Model model, HttpSession session) throws Exception{
		
		if(principal != null) {
			if(vo.getUserid().equals((String)principal.getName())) {
				vo.setUserid(principal.getName());
				model.addAttribute("cartlist",cartservice.viewcart(vo));
				return "redirect:/product/order";
			} else {
				logger.info("카트의 userid 와 로그인 userid 다름");
				return "redirect:/product/cart";
			}
		} else {
			if(vo.getUserid().equals(session.getId())) {
				vo.setUserid(session.getId());
				model.addAttribute("cartlist",cartservice.viewcart(vo));
				return "redirect:/product/order";
			} else {
				logger.info("세션 만료");
				return "redirect:/product/cart";
			}
		}
		
		
	}
	
//	주문하기(주소 작성) 화면 
	@RequestMapping(value="order", method=RequestMethod.GET)
	public void orderpage(CartVO vo,Principal principal,Model model, HttpSession session) throws Exception{
		MemberVO member = new MemberVO();
		if(principal != null) {
			vo.setUserid(principal.getName());
			member.setUserid(principal.getName());
			model.addAttribute("userinfo", memservice.readmember(member));
		} else {
			vo.setUserid(session.getId());
			model.addAttribute("userid", session.getId());
		}
		model.addAttribute("cartlist",cartservice.viewcart(vo));
		
	}
	

	
//	주문하기 처리
	@RequestMapping(value="order", method=RequestMethod.POST)
	public String order(OrderVO vo,Principal principal, HttpSession session) throws Exception{
		
		//orderno에 오늘날짜+랜덤숫자6자리
		Date date = new Date();
		DateFormat fmt = new SimpleDateFormat("yyyyMMdd");
		String orderno = fmt.format(date)+"-";
		
		for(int i = 1; i <= 6; i ++) {
				orderno += (int)(Math.random() * 10);
		}
		
		//회원 
		if(principal != null) {
			//주문하는 아이디와 로그인 된 아이디가 같을 때 
			if(vo.getUserid().equals((String)principal.getName())){
				vo.setOrderno(orderno);
				cartservice.placeanorder(vo);
				cartservice.orderdetail(vo);
				cartservice.ordercartdelete(vo);
				return "redirect:/product/orderdetail?orderno"+vo.getOrderno();
			} else {
				logger.info("카트의 userid 와 로그인 userid 다름");
				return "redirect:/product/cart";
			}
			
		//비회원	
		} else {
			if(vo.getUserid().equals(session.getId())){
				vo.setOrderno(orderno);
				cartservice.placeanorder(vo);
				cartservice.orderdetail(vo);
				cartservice.ordercartdelete(vo);
				return "redirect:/product/orderdetail?orderno"+vo.getOrderno();
			} else {
				logger.info("세션 만료");
				return "redirect:/product/cart";
			}
			
		}
		
	}
	
//	주문상세 화면
	@RequestMapping(value="orderdetail", method=RequestMethod.GET)
	public void orderdetail(OrderVO vo, Principal principal,Model model, HttpSession session) throws Exception{
		
		List<OrderVO> volist = cartservice.vieworderdetail(vo);
		MemberVO mem = new MemberVO();
		if(volist.size() != 0) {
			mem.setUserid(volist.get(0).getUserid());			
		}
		mem = memservice.readmember(mem);

		if(mem != null) {
			model.addAttribute("loginchk", 0);
		} else {
			model.addAttribute("loginchk", 2500);
		}
		model.addAttribute("orderdetail", cartservice.vieworderdetail(vo));
		
	}
	
//	비회원 주문 조회
	@ResponseBody
	@RequestMapping(value="orderdetailchk", method=RequestMethod.GET)
	public Integer orderdetailchk(OrderVO vo, Principal principal) throws Exception{
		List<OrderVO> ordervo = cartservice.vieworderdetail(vo);
		
		if(ordervo.size() != 0) {
			return 1;
			
		} else {
			return 0;
		}
		
	}
	
	
	
	
}
