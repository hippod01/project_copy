package com.project.mapper;

import java.util.HashMap;
import java.util.List;

import com.project.domain.Criteria;
import com.project.domain.ProductsVO;
import com.project.domain.StoreVO;

public interface ProductsMapper {

//	제품 전체 불러오기
	public List<ProductsVO> productlistall(Criteria cri) throws Exception;
	
//	카테고리별 리스트 불러오기
	public List<ProductsVO> productlistcate(ProductsVO vo) throws Exception;
	
//	제품 정보 보기
	public ProductsVO productview(ProductsVO vo) throws Exception;
	
//	제품 등록 하기
	public void register(ProductsVO vo) throws Exception;
	
//	제품 수정 하기
	public void update(ProductsVO vo) throws Exception;
	
//	제품 삭제 하기
	public void delete(ProductsVO vo) throws Exception;
	
	
//	store 전체 목록
	public List<StoreVO> storelist() throws Exception;
	
	
	
	
}
