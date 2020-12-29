package com.project.web;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.token.DefaultUserAuthenticationConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.project.domain.BoardVO;
import com.project.domain.Criteria;
import com.project.oauth2.GoogleTokenServices;
import com.project.service.BoardService;
import com.project.service.ProductsService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private ProductsService pservice;
	@Autowired
	private BoardService bservice;
	
	DefaultUserAuthenticationConverter dc;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, Criteria cri,java.security.Principal principal, HttpServletRequest request, Authentication auth) throws Exception{
//		logger.info("Welcome home! The client locale is {}.", locale);
//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
//		String formattedDate = dateFormat.format(date);
//		model.addAttribute("serverTime", formattedDate );

		model.addAttribute("plist", pservice.productlistall(cri));
		BoardVO vo = new BoardVO();
		vo.setBtype("notice");
		model.addAttribute("nlist", bservice.boardlist(vo, cri));
		
		if(principal != null) {
			
			logger.info("principal :"+principal.getName());
			logger.info("Authentication :"+auth);
		}
		
		return "index";
	}
	
	
	
	
}
