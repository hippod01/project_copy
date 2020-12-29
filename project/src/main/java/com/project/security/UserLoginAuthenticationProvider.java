package com.project.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserLoginAuthenticationProvider implements AuthenticationProvider{
	
	
	//db의 member 정보를 가져오는 클래스
	@Autowired		
	UserDetailsService userDetailsService;
	
	//패스워드 암호화 객체
	@Autowired		
	BCryptPasswordEncoder pwdEncoder;		
	
	
	//실제 인증을 구현하는 로직 Authentication에는 사용자가 입력한 id/패스워드를 담고 있음
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		// TODO Auto-generated method stub
		
		//사용자가 입력한 정보
		String userid = authentication.getName();
		String userpw = (String)authentication.getCredentials();
		
		//db에서 가져온 정보
		UserDetailsVO userdetail = (UserDetailsVO)userDetailsService.loadUserByUsername(userid);
		
		//인증 진행
		
	
		
		
		return null;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		// TODO Auto-generated method stub
		return false;
	}

	
	
	
}
