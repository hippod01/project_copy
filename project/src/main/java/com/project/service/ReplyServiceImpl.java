package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.domain.ReplyVO;
import com.project.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyMapper mapper;

	@Override
	public void create(ReplyVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.create(vo);
	}

	@Override
	public ReplyVO read(ReplyVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mapper.read(vo);
	}

	@Override
	public void update(ReplyVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.update(vo);
	}

	@Override
	public void delete(ReplyVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.delete(vo);
	}

	@Override
	public List<ReplyVO> list(int bno) throws Exception {
		// TODO Auto-generated method stub
		return mapper.list(bno);
	}

	@Override
	public int count(ReplyVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mapper.count(vo);
	}
	
	
	
	
}
