package com.project.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.activation.MimetypesFileTypeMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.multipart.MultipartFile;

import com.project.domain.AttachFileDTO;
import com.project.service.BoardService;


import net.coobird.thumbnailator.Thumbnailator;


@Controller
public class UploadController {

	@Autowired
	private BoardService service;
	
	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);
	
	@javax.annotation.Resource(name="uploadPath")
	private String uploadPath;

//	파일 업로드 처리 컨트롤러
	@RequestMapping(value="uploadfile", method = RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachFileDTO>> uploadfilepost(MultipartFile[] uploadfile) throws Exception{
		logger.info("파일 업로드 처리");
		
		//오늘 날짜에 업로드 파일 저장
		//uploadPath : /Users/db/Documents/javaProject/spring/upload (고정)
		//uploadFolder : /Users/db/Documents/javaProject/spring/upload/2002/00/00
		
		File uploadFolder = new File(uploadPath, getFolder());
		
		if(uploadFolder.exists() == false) {
			uploadFolder.mkdirs();
		}
		
		List<AttachFileDTO> dtolist = new ArrayList();
		
		for(MultipartFile file : uploadfile) {
			
			//uuid 설정
			String filename = file.getOriginalFilename();
			UUID uuid = UUID.randomUUID();
			filename = uuid.toString()+"_"+filename;
			
			File savefile = new File(uploadFolder,filename);
			
			//AttachFileDTO에 저장
			AttachFileDTO dto = new AttachFileDTO();
			dto.setFilename(file.getOriginalFilename());
			dto.setUploadpath(getFolder());
			dto.setUuid(uuid.toString());
			
			//이미지 파일이면 썸네일 생성
			if(checkImgfile(savefile)) {
				dto.setFiletype(true);
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadFolder,"s_"+filename));
				Thumbnailator.createThumbnail(file.getInputStream(),thumbnail,200,200);
				thumbnail.close();
			}
			
			try {
				//파일 업로드
				file.transferTo(savefile);
				dtolist.add(dto);
				
			} catch (Exception e) {
				logger.info(e.getMessage());
			}
			
		} // end for
		logger.info("파일 업로드 목록 : "+dtolist);
		return new ResponseEntity<List<AttachFileDTO>>(dtolist, HttpStatus.OK);
	}
	
	
//	이미지 파일 보이는 화면(썸네일 가져오는 화면)
//	url : http://localhost:8080/web/display?filename=2020/08/26/447c1461-4211-41cd-832f-bf1d47a45a65_bestimg1.jpg
	@RequestMapping(value="display", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayfile(String filename) throws Exception{
		File filepath = new File(uploadPath+"/"+filename);
		//logger.info("display file path : "+filepath);
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(filepath.toPath()));
			result = new ResponseEntity<byte[]> (FileCopyUtils.copyToByteArray(filepath),header,HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	
//	첨부파일 다운로드 컨트롤러 
	@RequestMapping(value="download", method = RequestMethod.GET, produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> downloadFile(String filename){
		Resource resource =  new FileSystemResource(uploadPath+"/"+filename);
		//logger.info("download resouce"+resource);
		
		String resourceName = resource.getFilename();
		HttpHeaders header = new HttpHeaders();
		
		try {
			header.add("Content-Disposition", "attachment; filename="+new String(resourceName.getBytes("UTF-8")));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
		
	}
	
	
//	첨부파일 삭제 컨트롤러
	@RequestMapping(value="deletefile", method=RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String filename, String filetype, String fileuuid){
		try {
			File file = new File(uploadPath+"/"+URLDecoder.decode(filename,"UTF-8"));
			logger.info("삭제 파일 위치 : "+file);
			//이미지 라면 썸네일 삭제
			file.delete();
		
			if(filetype.equals("image")) {
				//이미지 원본 파일 삭제
				String originalfile = file.getAbsolutePath().replace("s_", "");
				file = new File(originalfile);
				file.delete();
			}
			
			service.deleteattach(fileuuid);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	
	
	
// 파일 업로드 경로 생성 (날짜 폴더 생성)
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//오늘 날짜 저장
		Date date = new Date();
		//str = 2020-00-00
		String str = sdf.format(date);
//		System.out.println("오늘 날짜 : "+str);
		return str.replace("-", File.separator);
		
	}
	
//	이미지 파일 인지 아닌지 체크
	private boolean checkImgfile(File file){
		
		MimetypesFileTypeMap mimeTypesMap = new MimetypesFileTypeMap();
		String mimeType = mimeTypesMap.getContentType(file);
		if(mimeType.contains("image")) {
			return true;
		} else {
			return false;
		}
//		String filetype = Files.probeContentType(file.toPath());
//			filetype.startsWith("image");
//			return true;
		
			 
	}
	 

	
} // end controller

