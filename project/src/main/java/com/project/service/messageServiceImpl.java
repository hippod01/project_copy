package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.domain.MessageVO;
import com.project.mapper.messageMapper;

@Service
public class messageServiceImpl implements messageService {
	
	@Autowired
	private messageMapper mapper;

	@Override
	public int countUnreadMsg(String receive_id) throws Exception {
		// TODO Auto-generated method stub
		return mapper.countUnreadMsg(receive_id);
	}

	@Override
	public MessageVO readMsg(MessageVO msg) throws Exception {
		// TODO Auto-generated method stub
		return mapper.readMsg(msg);
	}

	@Override
	public List<MessageVO> msgListget(String receive_id) throws Exception {
		// TODO Auto-generated method stub
		return mapper.msgListget(receive_id);
	}

	@Override
	public void updateMsg(int message_no) throws Exception {
		mapper.updateMsg(message_no);
		
	}

	@Override
	public void writeMsg(MessageVO msg) throws Exception {
		// TODO Auto-generated method stub
		mapper.writeMsg(msg);
	}

}
