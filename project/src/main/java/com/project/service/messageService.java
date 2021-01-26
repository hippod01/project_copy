package com.project.service;

import java.util.List;

import com.project.domain.MessageVO;


public interface messageService {
	
//	메세지 작성
	public void writeMsg(MessageVO msg) throws Exception;

//	안 읽은 메세지 수
	public int countUnreadMsg(String receive_id) throws Exception;
	
//	메세지 조회
	public MessageVO readMsg(MessageVO msg) throws Exception;
	
//	메세지 리스트
	public List<MessageVO> msgListget(String receive_id) throws Exception;
	
//	메세지 읽음 처리
	public void updateMsg(int message_no) throws Exception;
	
}
