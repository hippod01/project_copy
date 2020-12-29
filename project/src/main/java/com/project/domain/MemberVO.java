package com.project.domain;

import java.util.List;

public class MemberVO {
	
	private String userid;
	private String userpw;
	private String username;
	private String useremail;
	private String usercont;
	private String useradd;
	private String useradd1;
	private String useradd2;
	
	private String regdate;
	private boolean usecookie;
	private String sessionkey;
	private String sessionlimit;
	private String userpc;
	private String userauth;
	
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpw() {
		return userpw;
	}
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUseremail() {
		return useremail;
	}
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	public String getUsercont() {
		return usercont;
	}
	public void setUsercont(String usercont) {
		this.usercont = usercont;
	}
	public String getUseradd() {
		return useradd;
	}
	public void setUseradd(String useradd1, String useradd2) {
		this.useradd1 = useradd1;
		this.useradd2 = useradd2;
		this.useradd = useradd1+useradd2;
	}
	
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	
	
	public boolean isUsecookie() {
		return usecookie;
	}
	public void setUsecookie(boolean usecookie) {
		this.usecookie = usecookie;
	}
	
	
	
	
	public String getSessionkey() {
		return sessionkey;
	}
	public void setSessionkey(String sessionkey) {
		this.sessionkey = sessionkey;
	}
	public String getSessionlimit() {
		return sessionlimit;
	}
	public void setSessionlimit(String sessionlimit) {
		this.sessionlimit = sessionlimit;
	}
	
	
	
	public String getUserpc() {
		return userpc;
	}
	public void setUserpc(String userpc) {
		this.userpc = userpc;
	}
	public void setUseradd(String useradd) {
		this.useradd = useradd;
	}
	
	
	public String getUserauth() {
		return userauth;
	}
	public void setUserauth(String userauth) {
		this.userauth = userauth;
	}
	
	
	public String getUseradd1() {
		return useradd1;
	}
	public void setUseradd1(String useradd1) {
		this.useradd1 = useradd1;
	}
	public String getUseradd2() {
		return useradd2;
	}
	public void setUseradd2(String useradd2) {
		this.useradd2 = useradd2;
	}
	
	@Override
	public String toString() {
		return "MemberVO [userid=" + userid + ", userpw=" + userpw + ", username=" + username + ", useremail="
				+ useremail + ", usercont=" + usercont + ", useradd=" + useradd + ", useradd1=" + useradd1
				+ ", useradd2=" + useradd2 + ", regdate=" + regdate + ", usecookie=" + usecookie + ", sessionkey="
				+ sessionkey + ", sessionlimit=" + sessionlimit + ", userpc=" + userpc + ", userauth=" + userauth + "]";
	}
	
	

	
	
	
	
	
	
	
	
	
	
	

	
}
