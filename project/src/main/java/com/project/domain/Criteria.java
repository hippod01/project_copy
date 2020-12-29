package com.project.domain;

public class Criteria {

	//페이지 번호
	private int pageNum; 
		
	//페이지당 보여지는 게시물 수
	private int amount;
	
	//검색 항목
	private String searchType;
	private String keyword;
	
	//생성자
	public Criteria() {
		this(1, 10);
	}
		
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	//getter,setter
	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		// pageNum을 1로 초기화 하지 않았을 때(생성자 없을 때) 아래 조건 적용
		if(pageNum <= 0) {
			this.pageNum = 1;
			return;
		}
			
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		if(amount <=0 || amount >100) {
			this.amount = 10;
		}
		this.amount = amount;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + ", searchType=" + searchType + ", keyword="
				+ keyword + "]";
	}

	
	
	
	
}
