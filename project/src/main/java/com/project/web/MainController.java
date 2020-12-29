package com.project.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.service.ProductsService;



@Controller
public class MainController {
	
	
	@Autowired
	private ProductsService service;
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	
//	about 화면 보기
	@RequestMapping(value="about", method = RequestMethod.GET)
	public void aboutget() throws Exception{
		
	}
	
// accessdenined 페이지
	@RequestMapping(value="accessdenined", method = RequestMethod.GET)
	public void accessdeninedget(Authentication auth,Model model) throws Exception{
		logger.info("access denined : "+auth);
		model.addAttribute("msg", "권한이 없는 페이지 입니다.");
	}
	
//	store 화면
	@RequestMapping(value="store", method = RequestMethod.GET)
	public void storeget(Model model) throws Exception{
		model.addAttribute("storelist", service.storelist());
	}
	

}
