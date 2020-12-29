package com.project.domain;

public class ProductsVO {

//	카테고리 번호
	private int pcno;
//	제품 번호
	private int pno;
//	제품 이름
	private String pname;
//	제품 이미지 경로
	private String pimgname;
//	제품 가격
	private int pprice;
//	제품 설명
	private String pcontent;
	
	public int getPcno() {
		return pcno;
	}
	public void setPcno(int pcno) {
		this.pcno = pcno;
	}
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
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
	public int getPprice() {
		return pprice;
	}
	public void setPprice(int pprice) {
		this.pprice = pprice;
	}
	
	
	public String getPcontent() {
		return pcontent;
	}
	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}
	@Override
	public String toString() {
		return "ProductsVO [pcno=" + pcno + ", pno=" + pno + ", pname=" + pname + ", pimgname=" + pimgname + ", pprice="
				+ pprice + ", pcontent=" + pcontent + "]";
	}

	
	
	
	
	
	
	
	
}
