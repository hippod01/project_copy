package com.project.domain;

public class CartVO {

	private int cartno;
	private String userid;
	private int pno;
	private int cartstock;
	private String adddate;
	
//	카트 보기에 사용될 productVO 조인된 속성 추가
	private int num;
	private String pname;
	private int pprice;
	private String pimgname;
	
	
	public int getCartno() {
		return cartno;
	}
	public void setCartno(int cartno) {
		this.cartno = cartno;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	public int getCartstock() {
		return cartstock;
	}
	public void setCartstock(int cartstock) {
		this.cartstock = cartstock;
	}
	public String getAdddate() {
		return adddate;
	}
	public void setAdddate(String adddate) {
		this.adddate = adddate;
	}
	
//	카트 보기에 사용될 productVO 조인된 속성 추가	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getPprice() {
		return pprice;
	}
	public void setPprice(int pprice) {
		this.pprice = pprice;
	}
	public String getPimgname() {
		return pimgname;
	}
	public void setPimgname(String pimgname) {
		this.pimgname = pimgname;
	}
	
	@Override
	public String toString() {
		return "CartVO [cartno=" + cartno + ", userid=" + userid + ", pno=" + pno + ", cartstock=" + cartstock
				+ ", adddate=" + adddate + ", num=" + num + ", pname=" + pname + ", pprice=" + pprice + ", pimgname="
				+ pimgname + "]";
	}
	
	
	
	
	
	
}
