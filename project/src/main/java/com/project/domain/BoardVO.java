package com.project.domain;

import java.util.List;

public class BoardVO {

	private String btype;
	private int bno;
	private String title;
	private String content;
	private String writer;
	private String regdate;
	private String updatedate;
	private int viewcnt;
	private int pno;
	
//	첨부파일
	private List<AttachFileDTO> attachlist;
	
//	첨부파일
	private List<AttachFileDTO> deletelist;
	
//	리뷰, 문의 게시판 전체 보기 상품 정보 추가
	private String pname;
	private String pimgname;
	
	
	public String getBtype() {
		return btype;
	}
	public void setBtype(String btype) {
		this.btype = btype;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	
	
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	//	첨부파일 관련
	public List<AttachFileDTO> getAttachlist() {
		return attachlist;
	}
	public void setAttachlist(List<AttachFileDTO> attachlist) {
		this.attachlist = attachlist;
	}
	
	
	
	public List<AttachFileDTO> getDeletelist() {
		return deletelist;
	}
	public void setDeletelist(List<AttachFileDTO> deletelist) {
		this.deletelist = deletelist;
	}
	//리뷰, 문의 게시판 관련
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPimgname() {
		return pimgname;
	}
	public void setPimgname(String pimgname) {
		this.pimgname = pimgname;
	}
	
	@Override
	public String toString() {
		return "BoardVO [btype=" + btype + ", bno=" + bno + ", title=" + title + ", content=" + content + ", writer="
				+ writer + ", regdate=" + regdate + ", updatedate=" + updatedate + ", viewcnt=" + viewcnt + ", pno="
				+ pno + ", attachlist=" + attachlist + ", deletelist=" + deletelist + ", pname=" + pname + ", pimgname="
				+ pimgname + "]";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
