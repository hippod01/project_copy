package com.project.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.project.domain.MemberVO;
import com.project.service.MemberService;

public class loginInterceptor extends HandlerInterceptorAdapter{
	
	@Autowired
	MemberService service;
	
	private static final Logger logger = LoggerFactory.getLogger(loginInterceptor.class);
	//전
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler) throws Exception{
				
		System.out.println("pre login............");
				
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("login");
		
		//로그인 된 세션이 없는 경우
		if(obj == null) {
			//쿠키 가져오기
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			//쿠키가 존재한다면
			if(loginCookie != null) {
				//세션 아이디를 가져와서
				String sessionid = loginCookie.getValue();
				//쿠키 유효기간이 지나지 않았는지 확인 -> 유효기간 지나지 않는 사용자 정보 반환
				MemberVO member = service.sessionidget(sessionid);
				//반환된 정보로 세션 설정
				if(member != null) {
					session.setAttribute("login", member);
					response.setContentType("text/html;charset=utf-8");
					PrintWriter out = response.getWriter();
					out.println("<script>");
					
//					out.println("location.href = '/db/'");
					out.println("location.href = document.referrer");
					out.println("</script>"); 
					out.close();
					return false;
				}
				
			//쿠키가 존재하지 않는다면	
			} else{
				
				return true;
			}
			
		}
		//로그인된 세션이 있다면 false 반환
		
		return true;
	}
	
}
