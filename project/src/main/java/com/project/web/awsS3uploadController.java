package com.project.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.service.awsS3service;



@Controller
public class awsS3uploadController {

	//보여주는 이미지 url
	private String url ="https://magazineb-ckeditor-upload.s3.ap-northeast-2.amazonaws.com/upload/";
	private static final Logger logger = LoggerFactory.getLogger(awsS3uploadController.class);
	
	@Autowired
	private awsS3service awsS3Service;
	
	//ckeditor 드래그 업로드
	@RequestMapping(value = "/image/drag", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Object dragFileUpload(@RequestParam("upload") MultipartFile dragfile) {
		
        HashMap<String, Object> map = new HashMap<>();
        try {
        	awsS3Service.upload(dragfile);
        	logger.info(""+awsS3Service.upload(dragfile));
            map.put("uploaded", 1);
            map.put("url", url+dragfile.getOriginalFilename());
            map.put("fileName", dragfile.getOriginalFilename());

            return map;
        } catch (Exception e) {
            map.put("uploaded", 0);
            map.put("error", "{'message': '" + e.getMessage() + "'}");
            return map;
        }     
    }    
    
	//ckeditor 업로드
	@RequestMapping(value = "/image",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
    public Object handleFileUpload(@RequestParam("upload") MultipartFile uploadfile) throws Exception {

		HashMap<String, Object> map = new HashMap<>();

		try {
			awsS3Service.upload(uploadfile);
			map.put("uploaded", 1);
            map.put("url", url+uploadfile.getOriginalFilename());
            map.put("fileName", uploadfile.getOriginalFilename());

            return map;
	        
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
		
    }
	
    @RequestMapping(value = "/upload", method = RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public void execWrite(MultipartFile file, HttpServletResponse response) throws IOException {
    	PrintWriter printWriter = null;
    	response.setContentType("text/html; charset=UTF-8");
    	
    	try {
    		awsS3Service.upload(file);
    		printWriter = response.getWriter();
    		
            printWriter.println("<script>"
            		+ "alert('업로드 성공');"
            		+ "location.href='/db/'"
                    + "</script>");
            printWriter.flush();   
    		
		} catch (Exception e) {
			    printWriter = response.getWriter();
	            printWriter.println("<script>"
	                    + "alert('amazon s3 : 업로드에 실패하였습니다.');"
	                    + "</script>");
	            printWriter.flush();       
		} finally {
             if (printWriter != null) {
                 printWriter.close();
             }
            
        }
    	 
    }
	
	
}
