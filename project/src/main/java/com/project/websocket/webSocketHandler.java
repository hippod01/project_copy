package com.project.websocket;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


import com.project.service.messageService;

public class webSocketHandler extends TextWebSocketHandler{

	private static final Logger logger = LoggerFactory.getLogger(webSocketHandler.class);
	@Autowired
	private messageService service;

	// 클라이언트가 연결을 끊었을 때 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        super.afterConnectionClosed(session, status);
//        this.logger.info("remove session!");
	}
	
	// 클라이언트가 서버로 연결된 이후에 실행
	@Override
    public void afterConnectionEstablished(WebSocketSession session)throws Exception {
		super.afterConnectionEstablished(session);
//		this.logger.info("add session! ");
	}

	// 클라이언트가 서버로 메세지를 전송했을 때 실행
    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
    	super.handleMessage(session, message);
    	
    	String receive_id = (String) message.getPayload();
    	int UnreadMsgCount = service.countUnreadMsg(receive_id);
    	
//    	logger.info("receive_id :"+receive_id);
//		logger.info("WebSocketMessage<?> : "+message);
//  		logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
  		
  		//서버에서 클라이언트로 메세지 보냄
  		session.sendMessage(new TextMessage(""+UnreadMsgCount));

    }
    
    // 연결된 클라이언트에서 예외 발생 시 실행
    @Override
    public void handleTransportError(WebSocketSession session,Throwable exception) throws Exception {
          this.logger.error("web socket error!", exception);
    }    

	
	
}
