package com.project.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.domain.AttachFileDTO;
import com.project.domain.BoardVO;
import com.project.domain.Criteria;
import com.project.domain.OrderVO;
import com.project.mapper.AttachfileMapper;
import com.project.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper mapper;
	@Autowired
	private AttachfileMapper filemapper;
	
//	글쓰기
	@Override
	@Transactional
	public void boardcreate(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.boardcreate(vo);
		if(vo.getAttachlist() != null) {
			vo.getAttachlist().forEach(attach->{
				attach.setBno(vo.getBno());
				try {
					filemapper.insertattach(attach);
				} catch (Exception e) {
					e.printStackTrace();
				}
			});
		}
		
	}
	

//	글보기
	@Override
	@Transactional
	public BoardVO boardread(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.updateviewcnt(vo);
		return mapper.boardread(vo);
	}
	
	
//	글수정
	@Override
	@Transactional
	public void boardupdate(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.boardupdate(vo);
		if(vo.getAttachlist() != null) {
			vo.getAttachlist().forEach(attach->{
				attach.setBno(vo.getBno());
				try {
					filemapper.insertattach(attach);
				} catch (Exception e) {
					e.printStackTrace();
				}
			});
		}
	}

//	글삭제
	@Override
	public void boarddelete(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.boarddelete(vo);
	}

//	페이징 전
	@Override
	public List<BoardVO> boardlist(BoardVO vo,Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		HashMap<Object,Object> hashmap = new HashMap<>();
		hashmap.put("btype",vo.getBtype());
		hashmap.put("searchType", cri.getSearchType());
		hashmap.put("keyword", cri.getKeyword());
		return mapper.boardlist(hashmap);
	}

	@Override
	public List<BoardVO> boardlistpno(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		
		return mapper.boardlistpno(vo);
	}
	
//	페이징 후(검색)
	@Override
	public List<BoardVO> boardlistpage(String btype, Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		HashMap<String,Object> hashmap = new HashMap<>();
		hashmap.put("btype",btype);
		hashmap.put("pageNum", cri.getPageNum());
		hashmap.put("amount", cri.getAmount());
		hashmap.put("searchType", cri.getSearchType());
		hashmap.put("keyword", cri.getKeyword());
		return mapper.boardlistpage(hashmap);

	}

//	전체 게시물 수 카운트
	@Override
	public int totalcount(String btype, Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		HashMap<String,Object> hashmap = new HashMap<>();
		hashmap.put("btype",btype);
		hashmap.put("pageNum", cri.getPageNum());
		hashmap.put("amount", cri.getAmount());
		hashmap.put("searchType", cri.getSearchType());
		hashmap.put("keyword", cri.getKeyword());
		return mapper.totalcount(hashmap);
	}

//	첨부파일 리스트 
	@Override
	public List<AttachFileDTO> attachlist(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return mapper.attachlist(bno);
	}

//	첨부파일 삭제
	@Override
	public void deleteattach(String uuid) throws Exception {
		// TODO Auto-generated method stub
		filemapper.deleteattach(uuid);
	}

	@Override
	public void updateviewcnt(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		
	}

//	구매목록 가져오기
	@Override
	public List<OrderVO> selectorderlist(OrderVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mapper.selectorderlist(vo);
	}

//	리뷰 체크 업데이트
	@Override
	public void reviewchkupdate(OrderVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.reviewchkupdate(vo);
	}



//	글보기(pno)
//	@Override
//	public List<BoardVO> boardreadpno(BoardVO vo) throws Exception {
//		// TODO Auto-generated method stub
//		return mapper.boardreadpno(vo);
//	}



	

}
