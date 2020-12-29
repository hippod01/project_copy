package com.project.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.project.domain.MemberVO;
import com.project.mapper.MemberMapper;

@Service
public class userLoginService implements UserDetailsService{

	@Autowired
	private MemberMapper mapper;
	
	
	@Override
	public UserDetails loadUserByUsername(String userid) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		
		//리턴해야할 객체
		UserDetailsVO user = new UserDetailsVO();
		
		//db 사용자 정보 select 결과
		MemberVO selectuser = null;
		
		try {
			selectuser = mapper.memcheck(userid);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(selectuser == null) {
			//유저가 조회되지 않으면 예외 던져준다.
			throw new UsernameNotFoundException(userid);
			
		} else {
			user.setUsername(selectuser.getUserid());
			user.setPassword(selectuser.getUserpw());
			user.setAuthority(selectuser.getUserauth());
			user.setAuthorities(user.getAuthority());
			System.out.println("로그인 정보 :"+user);
		}
		
		
		return user;
	}

	
}
