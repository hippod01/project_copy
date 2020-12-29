package com.project.domain;

public class OrderVO {

	private String orderno;
	private String userid;
	private String oname;
	private String opostcode;
	private String oadd1;
	private String oadd2;
	private String ocont;
	private int totalprice;
	private String orderdate;
	
//	주문 상세 정보에 필요한 컬럼 추가
	private int detailno;
	private int pno;
	private int cartstock;
	private String pname;
	private String pimgname;
	private int pprice;
	
	private String reviewchk;
	
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getOname() {
		return oname;
	}
	public void setOname(String oname) {
		this.oname = oname;
	}
	
	
	
	public String getOpostcode() {
		return opostcode;
	}
	public void setOpostcode(String opostcode) {
		this.opostcode = opostcode;
	}
	public String getOadd1() {
		return oadd1;
	}
	public void setOadd1(String oadd1) {
		this.oadd1 = oadd1;
	}
	public String getOadd2() {
		return oadd2;
	}
	public void setOadd2(String oadd2) {
		this.oadd2 = oadd2;
	}



	
	public String getOcont() {
		return ocont;
	}
	public void setOcont(String ocont) {
		this.ocont = ocont;
	}
	public int getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}
	public String getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}
	
	
	
	
	public int getDetailno() {
		return detailno;
	}
	public void setDetailno(int detailno) {
		this.detailno = detailno;
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
	
	public String getReviewchk() {
		return reviewchk;
	}
	public void setReviewchk(String reviewchk) {
		this.reviewchk = reviewchk;
	}
	@Override
	public String toString() {
		return "OrderVO [orderno=" + orderno + ", userid=" + userid + ", oname=" + oname + ", opostcode=" + opostcode
				+ ", oadd1=" + oadd1 + ", oadd2=" + oadd2 + ", ocont=" + ocont + ", totalprice=" + totalprice
				+ ", orderdate=" + orderdate + ", detailno=" + detailno + ", pno=" + pno + ", cartstock=" + cartstock
				+ ", pname=" + pname + ", pimgname=" + pimgname + ", pprice=" + pprice + ", reviewchk=" + reviewchk
				+ "]";
	}
	
	

	
	
	
	
	
	
	
	
}
