package com.project.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.domain.ReplyVO;
import com.project.service.ReplyService;

@RestController
@RequestMapping("reply")
public class ReplyController {

	@Autowired
	private ReplyService service;
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
//	게시글 전체 댓글 조회 (rest)
	@RequestMapping(value="all/{bno}", method=RequestMethod.GET)
	public List<ReplyVO> replylistrest(@PathVariable("bno") int bno) throws Exception{
		return service.list(bno);
	}
	
	
//	댓글 등록 처리
	@RequestMapping(value="write", method=RequestMethod.POST)
	public void writereply(ReplyVO vo) throws Exception{
		service.create(vo);
	}
	
//	댓글 수정 처리
	@RequestMapping(value="update", method=RequestMethod.POST)
	public void updatereply(ReplyVO vo) throws Exception{
		service.update(vo);
	}
	
	
//	댓글 삭제 처리
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public void deletereply(ReplyVO vo) throws Exception{
		service.delete(vo);
	}
	
//	댓글 카운트
	@RequestMapping(value="count", method=RequestMethod.GET)
	public int countreply(ReplyVO vo) throws Exception{
		return service.count(vo);
	}
	
	
	
}