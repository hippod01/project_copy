package com.project.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.domain.MemberVO;
import com.project.interceptor.LoginPostInterceptor;
import com.project.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {

	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired
	private MemberMapper mapper;
	
	@Override
	public void createmember(MemberVO member) throws Exception {
		// TODO Auto-generated method stub
		mapper.createmember(member);
	}

	@Override
	public MemberVO readmember(MemberVO member) throws Exception {
		// TODO Auto-generated method stub
		return mapper.readmember(member);
	}

	@Override
	public void updatemember(MemberVO member) throws Exception {
		// TODO Auto-generated method stub
		mapper.updatemember(member);
	}

	@Override
	public void deletemember(MemberVO member) throws Exception {
		// TODO Auto-generated method stub
		mapper.deletemember(member);
	}

//	로그인 
	@Override
	public MemberVO logincheck(MemberVO member) throws Exception {
		// TODO Auto-generated method stub
		//쿠키 사용 여부 업데이트
		mapper.checkusecookie(member);
		return mapper.logincheck(member);
	}
	
//	아이디 중복 체크
	@Override
	public int idcheck(String userid) throws Exception {
		// TODO Auto-generated method stub
		return mapper.idcheck(userid);
	}

//	(security)회원정보 불러오기
	@Override
	public MemberVO memcheck(String userid) throws Exception {
		// TODO Auto-generated method stub
		return mapper.memcheck(userid);
	}

//	비밀번호 체크 이메일 인증
	@Override
	public int checkmememail(MemberVO member) throws Exception {
		// TODO Auto-generated method stub
		return mapper.checkmememail(member);
	}

//	비밀번호 설정
	@Override
	public void temppwset(MemberVO member) throws Exception {
		// TODO Auto-generated method stub
		
		mapper.temppwset(member);
	}

	
//	(관리자) 회원목록 조회
	@Override
	public List<MemberVO> adminmemberlist() throws Exception {
		// TODO Auto-generated method stub
		return mapper.adminmemberlist();
	}



	
	

}
