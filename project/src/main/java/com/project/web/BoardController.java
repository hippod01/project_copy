package com.project.web;


import java.security.Principal;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.project.domain.BoardVO;
import com.project.domain.Criteria;
import com.project.domain.OrderVO;
import com.project.domain.PageDTO;
import com.project.domain.ProductsVO;
import com.project.service.BoardService;
import com.project.service.ProductsService;

@Controller
public class BoardController {

	@Autowired
	private BoardService service;
	@Autowired
	private ProductsService pservice;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	
//	전체 리스트 불러오기 (문의 리뷰) Pno 있을 때
	@RequestMapping(value="board", method=RequestMethod.GET)
	public void alllistget(Criteria cri, BoardVO vo, Model model,Principal principal) throws Exception{
		
		model.addAttribute("btype", vo.getBtype());
		model.addAttribute("boardlist", service.boardlistpage(vo.getBtype(),cri));
		model.addAttribute("page", new PageDTO(cri, service.totalcount(vo.getBtype(),cri)));
		
		if(principal != null) {
			model.addAttribute("loginuser", principal.getName());
		}
		
	}
	
//	글쓰기 화면
	@RequestMapping(value="board/write", method=RequestMethod.GET)
	public void boardwrite(BoardVO vo, Model model, Principal principal) throws Exception{
		
		ProductsVO pvo = new ProductsVO();
		vo.setWriter(principal.getName());
		pvo.setPno(vo.getPno());
		
		if(vo.getPno() == 0) {
//			logger.info("pno 없음");
			model.addAttribute("boardvo", vo);
		} else {
//			logger.info("pno 있음");
			model.addAttribute("boardvo", vo);
			model.addAttribute("productvo", pservice.productview(pvo));
		}
		
	}
	
	
//	글쓰기 처리
	@RequestMapping(value="board/write", method=RequestMethod.POST)
	public String boardwritepost(BoardVO vo,OrderVO order,Principal principal) throws Exception{
		
		vo.setWriter(principal.getName());
		
		if(vo.getBtype().equals("review")) {
			service.reviewchkupdate(order);
		}
		if(vo.getBtype().equals("notice")) {
			vo.setContent(vo.getContent().replace("\r\n", "<br>"));
		}
		service.boardcreate(vo);
		return "redirect:/board?btype="+vo.getBtype();
		
	}
	
	
//	게시글 보기
	@RequestMapping(value="board/read", method = RequestMethod.GET)
	public void readget(BoardVO vo,Model model,Principal principal) throws Exception{
		
		model.addAttribute("boardvo", service.boardread(vo));
		 
		if(principal != null) {
			model.addAttribute("loginuser", principal.getName());
		}
		
	}
	
//	게시글 수정화면 (pno)
	@RequestMapping(value="board/modify", method = RequestMethod.GET)
	public void modifyget(BoardVO vo,Model model,Principal principal) throws Exception{
		BoardVO board = service.boardread(vo);
		if(vo.getBtype().equals("notice")) {
			board.setContent(board.getContent().replace("<br>", "\r\n"));
		}
		model.addAttribute("boardvo", board);
		if(principal != null) {
			model.addAttribute("loginuser", principal.getName());
		}
		
		
	}
	
//	게시글 수정처리 
	@RequestMapping(value="board/modify", method = RequestMethod.POST)
	public String modifypost(BoardVO vo) throws Exception{
		logger.info("수정 처리"+vo);
		if(vo.getBtype().equals("notice")) {
			vo.setContent(vo.getContent().replace("\r\n", "<br>"));
		}
		service.boardupdate(vo);
		return "redirect:/board/read?bno="+vo.getBno()+"&btype="+vo.getBtype();
		
	}
	
//	게시글 삭제처리
	@RequestMapping(value="board/delete", method = RequestMethod.POST)
	public String deletepost(BoardVO vo,Model model) throws Exception{
		
		service.boarddelete(vo);
		return "redirect:/board?btype="+vo.getBtype();
	}
	
	
	
//	리스트 불러오기 (product/view 페이지) - 리뷰
	@RequestMapping(value="review/all/{pno}", method=RequestMethod.GET)
	public ResponseEntity<List<BoardVO>> reviewlistget(@PathVariable("pno") int pno) throws Exception{
		
		BoardVO vo = new BoardVO();
		vo.setPno(pno);
		vo.setBtype("review");
		return new ResponseEntity<>(service.boardlistpno(vo), HttpStatus.OK);
	}
	
//	리스트 불러오기 (product/view 페이지) - 문의
	@RequestMapping(value="qaboard/all/{pno}", method=RequestMethod.GET)
	public ResponseEntity<List<BoardVO>> qandalistget(@PathVariable("pno") int pno) throws Exception{
		
		BoardVO vo = new BoardVO();
		vo.setPno(pno);
		vo.setBtype("qanda");
		return new ResponseEntity<>(service.boardlistpno(vo), HttpStatus.OK);
	}
	
//	주문목록 가져오기 
	@RequestMapping(value="board/orderlist", method=RequestMethod.GET)
	public ResponseEntity<List<OrderVO>> orderlistget(OrderVO vo,Principal principal) throws Exception{
		vo.setUserid(principal.getName());
		return new ResponseEntity<>(service.selectorderlist(vo), HttpStatus.OK);
	}
	
	
}
