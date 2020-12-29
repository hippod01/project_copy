package com.project.domain;

public class OrderDetailVO {

	
	private int detailno;
	private int orderno;
	private int pno;
	private int cartstock;
	private String userid;
	private String reviewchk;
	
	public int getDetailno() {
		return detailno;
	}
	public void setDetailno(int detailno) {
		this.detailno = detailno;
	}
	public int getOrderno() {
		return orderno;
	}
	public void setOrderno(int orderno) {
		this.orderno = orderno;
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
	
	
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	

	public String getReviewchk() {
		return reviewchk;
	}
	public void setReviewchk(String reviewchk) {
		this.reviewchk = reviewchk;
	}
	
	@Override
	public String toString() {
		return "OrderDetailVO [detailno=" + detailno + ", orderno=" + orderno + ", pno=" + pno + ", cartstock="
				+ cartstock + ", reviewchk=" + reviewchk + ", userid=" + userid + "]";
	}
	
	
	
	
	
	
}
