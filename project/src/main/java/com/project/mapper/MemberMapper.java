package com.project.mapper;

import java.util.List;


import com.project.domain.MemberVO;

public interface MemberMapper {

//	회원가입
	public void createmember(MemberVO member) throws Exception;

//	회원정보 보기
	public MemberVO readmember(MemberVO member) throws Exception;
	
//	회원정보 업데이트
	public void updatemember(MemberVO member) throws Exception;
	
//	회원정보 삭제 
	public void deletemember(MemberVO member) throws Exception;
	
//	아이디 중복 체크
	public int idcheck(String userid) throws Exception;
	
//	로그인 정보 조회
	public MemberVO logincheck(MemberVO member) throws Exception;
	
//	쿠키사용여부 체크
	public void checkusecookie(MemberVO member) throws Exception;
		
//	security 회원 체크
	public MemberVO memcheck(String userid) throws Exception;
	
// 	security 회원 권한 가져오기
 	public List<String> authcheck(String userid) throws Exception;
	
	
	
//	비밀번호 찾기 이메일 확인
	public int checkmememail(MemberVO member) throws Exception;
	
//	비밀번호 설정
	public void temppwset(MemberVO member) throws Exception;
	
	
	
//	(관리자) 회원목록 조회
	public List<MemberVO> adminmemberlist() throws Exception;
	
}
