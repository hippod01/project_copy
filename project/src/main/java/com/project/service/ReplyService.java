package com.project.service;

import java.util.List;

import com.project.domain.ReplyVO;

public interface ReplyService {

//	crud
	public void create(ReplyVO vo) throws Exception;
	
	public ReplyVO read(ReplyVO vo) throws Exception;
	
	public void update(ReplyVO vo) throws Exception;
	
	public void delete(ReplyVO vo) throws Exception;
	
//	댓글 전체 리스트 (페이징 전)
	public List<ReplyVO> list(int bno) throws Exception;
	
//	댓글 카운트
	public int count(ReplyVO vo) throws Exception;
	
}
