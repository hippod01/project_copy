package com.project.service;

import java.util.List;

import com.project.domain.AttachFileDTO;
import com.project.domain.BoardVO;
import com.project.domain.Criteria;
import com.project.domain.OrderVO;

public interface BoardService {

	
	//	글 쓰기
	public void boardcreate(BoardVO vo) throws Exception;
	
	//	글 보기
	public BoardVO boardread(BoardVO vo) throws Exception;
	
	//	글 수정
	public void boardupdate(BoardVO vo) throws Exception;
	
	// 	글 삭제
	public void boarddelete(BoardVO vo) throws Exception;
	
	//	게시판 리스트 보기(페이징 전) btype
	public List<BoardVO> boardlist(BoardVO vo,Criteria cri) throws Exception;
	
	//	게시판 리스트 보기(페이징 전) - 제품 쪽 btype, pno
	public List<BoardVO> boardlistpno(BoardVO vo) throws Exception;
	
	
	//	게시판 리스트 보기(페이징 후)
	public List<BoardVO> boardlistpage(String btype, Criteria cri) throws Exception;
	
	//	총 게시물 수 카운트
	public int totalcount(String btype, Criteria cri) throws Exception;
	
	//	게시물 첨부파일 리스트 불러오기
	public List<AttachFileDTO> attachlist(Integer bno) throws Exception;
	
	//	조회수 카운트
	public void updateviewcnt(BoardVO vo) throws Exception;
	
	//	게시물 첨부파일 삭제 
	public void deleteattach(String uuid) throws Exception;
	
//	구매목록 가져오기
	public List<OrderVO> selectorderlist(OrderVO vo) throws Exception;
	
//	리뷰체크
	public void reviewchkupdate(OrderVO vo) throws Exception;
	
}
