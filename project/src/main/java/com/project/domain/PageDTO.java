package com.project.domain;

public class PageDTO {

	//첫번째페이지, 마지막페이지
	private int startpage;
	private int endpage;
		
	public int getStartpage() {
		return startpage;
	}

	public void setStartpage(int startpage) {
		this.startpage = startpage;
	}

	public int getEndpage() {
		return endpage;
	}

	public void setEndpage(int endpage) {
		this.endpage = endpage;
	}
	
	//이전 페이지, 다음 페이지(표시여부)
	private boolean prev;
	private boolean next;

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}
	
//	페이지 번호, 한 페이지 게시물 갯수
	private Criteria cri;
	
	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	//게시물 총 갯수
	private int total;
		
	//생성자(startpage, endpage 계산)
	public PageDTO (Criteria cri, int total) {
		this.cri=cri;
		this.total=total;
			
			
		//endpage 계산식, math.ceil은 무조건 올림해줌 ,무조건 10, 20, 30~ 의 수만 나오게 됨
		// 정수 = 정수/정수, 실수 = 정수/실수, 그래서 /10.0을 해줌 
		this.endpage=(int)(Math.ceil(cri.getPageNum()/10.0))*10;
			
		//startpage 계산식 무조건 1, 11, 21의 수만 나오게 됨
		this.startpage=this.endpage-9;
			
		//마지막페이지가 10,20,30~ 이 아닐 때를 위한 식
		int realend = (int)(Math.ceil(total/(double)cri.getAmount()));
			
		if(realend < endpage) {
			this.endpage=realend;
		}
			
		//다음페이지, 이전페이지 조건식
		prev = this.startpage > 1;
		next = this.endpage * cri.getAmount() < total;
			
			
		}

	@Override
	public String toString() {
		return "PageDTO [startpage=" + startpage + ", endpage=" + endpage + ", prev=" + prev + ", next=" + next
				+ ", cri=" + cri + ", total=" + total + "]";
	}
		
		
		
		
	

	
}
