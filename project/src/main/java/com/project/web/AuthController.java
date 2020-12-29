package com.project.web;


import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.security.oauth2.client.token.AccessTokenRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.ResponseBody;



import com.project.domain.EmailDTO;
import com.project.domain.MemberVO;
//import com.project.oauth2.GlobalProperties;
import com.project.service.EmailService;
import com.project.service.MemberService;



@Controller
public class AuthController {

	@Autowired
	private MemberService service;
	@Autowired
	private BCryptPasswordEncoder pwdEncoder;
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private EmailService emailService;

	private static final Logger logger = LoggerFactory.getLogger(AuthController.class);
	
	
		//회원가입 화면 
		@RequestMapping(value="register", method = RequestMethod.GET)
		public void registerget() throws Exception {
			logger.info("회원가입 화면");
			
		}
		
		//회원가입 처리 (기본 권한 ROLE_MEMBER)
		@RequestMapping(value="register", method = RequestMethod.POST)
		public String registerpost(MemberVO member, String useradd1, String useradd2) throws Exception{
			member.setUseradd(useradd1, useradd2);
			logger.info("회원가입 처리"+member);
			
			//비밀번호 암호화 처리
			member.setUserpw(pwdEncoder.encode(member.getUserpw()));
			
			service.createmember(member);
			return "redirect:/";
		}
		
		
		//로그인 화면 
		@RequestMapping(value="Customlogin", method = RequestMethod.GET)
		public void loginget(HttpSession session, Model model) throws Exception {
			logger.info("로그인 화면");		
			
			
		}
		
		
		//비밀번호 찾기 회원 인증
		@ResponseBody
		@RequestMapping(value="checkuser", method = RequestMethod.POST)
		public int checkuseremail(MemberVO vo) throws Exception{
			logger.info("이메일 체크 확인 "+vo);
			int result = service.checkmememail(vo);
			//1	: 이메일 확인 됨, 0 : 이메일 없거나 회원아님	
			return result;
		}
		
		
		//비밀번호 찾기 메일 보내기 처리
		@RequestMapping(value="sendemail.do", method = RequestMethod.POST)
	    public void sendemaildo(@ModelAttribute EmailDTO dto, Model model,MemberVO member) {
			dto.setSubject("비밀번호 재설정");
			dto.setSenderName("매거진B");
			logger.info(""+member);
					
	        try {
	            //임시 비밀번호 설정
	            BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder(10);
	            
	    		String temppw="";
	    		for(int i = 1; i <= 6; i ++) {
	    			temppw += (int)(Math.random() * 10);
	    		}
	    		dto.setMessage("임시 비밀번호 : "+temppw);
	    		
	    		//난수 비밀번호 데이터 베이스 설정
	    		String encodetemppw = pwdEncoder.encode(temppw);
	    		member.setUserpw(encodetemppw);
	    		service.temppwset(member);
	    		
	    		//임시 비밀번호 메세지 보내기
	    		emailService.sendMail(dto);
	            logger.info("메세지 보내기 성공"+dto);
	            
	        } catch (Exception e) {
	        	logger.info("메세지 보내기 실패");
	            e.printStackTrace();
	           
	        }
	    }
		
//		oauth2
//		@RequestMapping(value="/login/{social}")
//	    public String loginSocial(@PathVariable String social) {

//			String url = "/";
//			String scope = "";
//			String response_type = "";
//			String client_id = "";
//			String redirect_uri = "";
//
//			if (social.equals("google")) {
//		        scope = GlobalProperties.getProperty("oauth2.scope");
//		        response_type = "code";
//		        client_id = GlobalProperties.getProperty("oauth2.clientId");
//		        redirect_uri = GlobalProperties.getProperty("oauth2.filterCallbackPath");
//		        url = GlobalProperties.getProperty("oauth2.userAuthorizationUri") + "?scope=" + scope
//				                                                                  + "&response_type=" + response_type
//				                                                                  + "&client_id=" + client_id
//				                                                                  + "&redirect_uri=" + redirect_uri;  
//			}
//
//			logger.info(""+url);
//			return "redirect:" + url;
//			}


		
}
