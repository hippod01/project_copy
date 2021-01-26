package com.project.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.domain.AttachFileDTO;
import com.project.service.BoardService;
import com.project.service.awsS3service;



@Controller
public class awsS3uploadController {

	//보여주는 이미지 url
	private String url ="https://magazineb-ckeditor-upload.s3.ap-northeast-2.amazonaws.com/";
	private static final Logger logger = LoggerFactory.getLogger(awsS3uploadController.class);
	
	@Autowired
	private awsS3service awsS3Service;
	
	//ckeditor 드래그 업로드
	@RequestMapping(value = "image/drag", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Object dragFileUpload(@RequestParam("upload") MultipartFile dragfile) {
		String foldername = "ckeditor";
        HashMap<String, Object> map = new HashMap<>();
        try {
        	awsS3Service.upload(dragfile,foldername);
            map.put("uploaded", 1);
            map.put("url", url+foldername+"/"+dragfile.getOriginalFilename());
            map.put("fileName", dragfile.getOriginalFilename());

            return map;
        } catch (Exception e) {
            map.put("uploaded", 0);
            map.put("error", "{'message': '" + e.getMessage() + "'}");
            return map;
        }     
    }    
    
	//ckeditor 업로드
	@RequestMapping(value = "image",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
    public Object handleFileUpload(@RequestParam("upload") MultipartFile uploadfile) throws Exception {

		HashMap<String, Object> map = new HashMap<>();
		String foldername = "ckeditor";
		
		try {
			awsS3Service.upload(uploadfile,foldername);
			map.put("uploaded", 1);
            map.put("url", url+foldername+"/"+uploadfile.getOriginalFilename());
            map.put("fileName", uploadfile.getOriginalFilename());

            return map;
	        
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
		
    }
	
//	input file type upload
    @RequestMapping(value = "upload", method = RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<AttachFileDTO>> execWrite(MultipartFile boardFile, HttpServletResponse response) throws Exception {

    	String foldername = "upload";
    	List<AttachFileDTO> dtolist = new ArrayList();
    	
    	try {
    		dtolist = awsS3Service.upload(boardFile, foldername);	
		} catch (Exception e) {
				e.printStackTrace();
		} 
    	return new ResponseEntity<List<AttachFileDTO>>(dtolist, HttpStatus.OK); 
    }
    
    
//  file delete
	@RequestMapping(value="awsFileDelete", method=RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String filename, String filetype, String fileuuid){
		try {
			String folderName = "upload";
			logger.info(""+folderName+"/"+fileuuid+"_"+filename);
			awsS3Service.fileDelete(folderName,fileuuid+"_"+filename);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}    
    
//  filedownload
	@RequestMapping(value="awsFileDownload", method=RequestMethod.GET)
	public ResponseEntity<byte[]> downloadFile(String filename, String fileuuid) throws IOException{
		String folderName = "upload";
		try {
//			logger.info(""+folderName+"/"+fileuuid+"_"+filename);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return awsS3Service.fileDownload(folderName,fileuuid+"_"+filename);
	}    
	
	
}
