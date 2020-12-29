package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.domain.Criteria;
import com.project.domain.ProductsVO;
import com.project.domain.StoreVO;
import com.project.mapper.ProductsMapper;

@Service
public class ProductsServiceImpl implements ProductsService {

	@Autowired
	private ProductsMapper mapper;
	
//	제품 전체 불러오기
	@Override
	public List<ProductsVO> productlistall(Criteria cri) throws Exception {

		return mapper.productlistall(cri);
	}

//	제품 정보 불러오기
	@Override
	public ProductsVO productview(ProductsVO vo) throws Exception {

		return mapper.productview(vo);
	}

//	제품 등록하기
	@Override
	public void register(ProductsVO vo) throws Exception {
 
		mapper.register(vo);
	}

//	카테고리별 리스트 불러오기
	@Override
	public List<ProductsVO> productlistcate(ProductsVO vo) throws Exception {
		return mapper.productlistcate(vo);
	}

	@Override
	public void update(ProductsVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.update(vo);
	}

	@Override
	public void delete(ProductsVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.delete(vo);
		
	}

//	store 전체 목록
	
	@Override
	public List<StoreVO> storelist() throws Exception {
		// TODO Auto-generated method stub
		return mapper.storelist();
	}
	
	
	
	

}
