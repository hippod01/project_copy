package com.project.interceptor;

import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.CookieGenerator;

import com.project.domain.MemberVO;
import com.project.service.MemberService;


public class LoginPostInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoginPostInterceptor.class);
	@Autowired
	private MemberService service;
	
	//전
		@Override
		public boolean preHandle(HttpServletRequest request, 
				HttpServletResponse response, 
				Object handler) throws Exception{
			
			System.out.println("pre loginpost............");
			
			HttpSession session = request.getSession();
			if(session.getAttribute("login") != null) {
				logger.info("clear login data before");
				session.removeAttribute("login");
			}
			return true;
		}
		
	//후
		@Override
		public void postHandle(HttpServletRequest request, 
				HttpServletResponse response, 
				Object handler, 
				ModelAndView modelandview) throws Exception{
			System.out.println("post loginpost ............");
		
			HttpSession session = request.getSession();
//			//컨트롤러에서 보내온 MemberVO 가져오기
//			Object loginuser = modelandview.getModel().get("loginuser");
			MemberVO loginuser = (MemberVO) modelandview.getModel().get("loginuser");
			
			
			if(loginuser!=null) {
				System.out.println("new login success");
				session.setAttribute("login", loginuser);
				//System.out.println("세션정보 : "+session.getAttribute("login"));
				
				System.out.println("쿠키 사용 여부 : "+loginuser.isUsecookie());
				// 로그인 후 쿠키 사용여부 확인 (로그인 유지)
				if(loginuser.isUsecookie()) {
					//쿠키 만들고 세션 아이디를 쿠키에 담는다.
					Cookie loginCookie = new Cookie("loginCookie",session.getId());
					
					//쿠키를 찾을 경로 설정
					loginCookie.setPath("/");
					//초,분,시,일 = 7 일주일동안 쿠키 보관
					int amount = 60*60*24*7;
					loginCookie.setMaxAge(60*60*24*7);
					
					System.out.println("cookieinfo :"+loginCookie);
					//쿠키를 적용
					response.addCookie(loginCookie);
					
					Date sessionlimit = new Date(System.currentTimeMillis()+(1000*amount));

					//System.out.println(loginuser.getUserid()+session.getId()+sessionlimit);
					service.sessionidset(loginuser.getUserid(), session.getId(), sessionlimit);
					
				}
				response.sendRedirect("/db/");
				
				
			}
			
		
		}
	
	
}
