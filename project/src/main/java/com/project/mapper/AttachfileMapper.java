package com.project.mapper;

import java.util.List;

import com.project.domain.AttachFileDTO;

public interface AttachfileMapper {

//	첨부파일 insert
	public void insertattach(AttachFileDTO file) throws Exception;
	
//	첨부파일 delete
	public void deleteattach(String uuid) throws Exception;
	

	
}
