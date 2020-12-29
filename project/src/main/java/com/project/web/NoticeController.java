package com.project.web;

import java.security.Principal;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.domain.AttachFileDTO;
import com.project.domain.BoardVO;
import com.project.domain.Criteria;
import com.project.domain.PageDTO;
import com.project.service.BoardService;


@Controller
@RequestMapping("notice")
public class NoticeController {

	@Autowired
	private BoardService service;
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	
//	첨부파일 리스트
	@RequestMapping(value="filelist", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachFileDTO>> attachfilelist(Integer bno) throws Exception{
		logger.info("첨부파일 리스트"+bno);
		return new ResponseEntity<>(service.attachlist(bno),HttpStatus.OK) ;
	}
	
}
