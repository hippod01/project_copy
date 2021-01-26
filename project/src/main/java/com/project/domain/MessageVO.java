package com.project.domain;

public class MessageVO {
	
	int message_no;
	String send_id;
	String receive_id;
	String send_date;
	String content;
	String msg_check;
	
	public int getMessage_no() {
		return message_no;
	}
	public void setMessage_no(int message_no) {
		this.message_no = message_no;
	}
	public String getSend_id() {
		return send_id;
	}
	public void setSend_id(String send_id) {
		this.send_id = send_id;
	}
	
	public String getReceive_id() {
		return receive_id;
	}
	public void setReceive_id(String receive_id) {
		this.receive_id = receive_id;
	}
	public String getSend_date() {
		return send_date;
	}
	public void setSend_date(String send_date) {
		this.send_date = send_date;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getMsg_check() {
		return msg_check;
	}
	public void setMsg_check(String msg_check) {
		this.msg_check = msg_check;
	}
	
	@Override
	public String toString() {
		return "MessageVO [message_no=" + message_no + ", send_id=" + send_id + ", receive_id=" + receive_id
				+ ", send_date=" + send_date + ", content=" + content + ", msg_check=" + msg_check + "]";
	}
	
	
	    
	  
	 
	
	
}
