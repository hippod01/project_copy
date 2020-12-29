package com.project.web;

import java.sql.Connection;
import java.sql.DriverManager;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.project.domain.Criteria;
import com.project.domain.OrderVO;

public class DBtest {
	
	@Autowired
	private BCryptPasswordEncoder pwdEncoder;
	

	private static final String driver = "com.mysql.cj.jdbc.Driver";
	private static final String url = "jdbc:mysql://127.0.0.1:3306/project?serverTimezone=Asia/Seoul";
	private static final String user = "db";
	private static final String pw = "1234";
	
	
	private static final Logger logger = LoggerFactory.getLogger(DBtest.class);
	
	@Test
	public void testConnection() throws Exception{
		
//		Class.forName(driver);
//		try(Connection con = DriverManager.getConnection(url,user,pw)){
//			System.out.println(con);
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
		
		
	}
	
//	@Test
//	public void setAuthorities() {
//		String authority="ROLE_ADMIN,ROLE_MEMBER";
//		
//		String[] auth = authority.split(","); 
//		List<String> authlist = new ArrayList<>();
//		
//		authlist = Arrays.asList(auth);
//		
//		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
//		
//		for(int i=0; i<authlist.size(); i++) {
//			authorities.add(new SimpleGrantedAuthority(authlist.get(i)));
//			System.out.println("authorities = "+authlist.get(i));
//		}
//		
//		
//	}	
	
//	@Test
//	public void test() {
//		Criteria cri = new Criteria(1,10);
//		HashMap<String,Object> hashmap = new HashMap<>();
//		String btype = "notice";
//		hashmap.put("btype",btype);
//		hashmap.put("cri", cri);
//		System.out.println("hashmap = "+hashmap);
//		
//	}
	
	
//	@Test
//	public void ordernotest() {
//		OrderVO vo = new OrderVO();
//		Date date = new Date();
//		DateFormat fmt = new SimpleDateFormat("yyyyMMdd");
//		String orderno = fmt.format(date);
//		for(int i = 1; i <= 4; i ++) {
//			orderno += (int)(Math.random() * 10);
//		}
//		
//		vo.setOrderno(orderno);
//		System.out.println("date "+orderno);
//		System.out.println("vo "+vo);
//	}
	
	
	@Test
	public void temppwtest() {
		
		BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder(10);
		String temppw="";
		
		for(int i = 1; i <= 6; i ++) {
			temppw += (int)(Math.random() * 10);
		}
		System.out.println("random 비밀번호 : "+temppw);
		
		String encodetemppw = pwdEncoder.encode(temppw);		
		System.out.println("encode 비밀번호 : "+encodetemppw);
		
		System.out.println(pwdEncoder.matches(temppw, encodetemppw));
		
		
		
		
	}
	
	
}
