package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.domain.CartVO;
import com.project.domain.OrderDetailVO;
import com.project.domain.OrderVO;
import com.project.domain.ProductsVO;
import com.project.mapper.CartMapper;

@Service
public class CartServiceImpl implements CartService {

	@Autowired
	private CartMapper mapper;
	
//	카트 담기
	@Transactional
	@Override
	public void addcart(CartVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.addcart(vo);
		mapper.cleancart();
	}

//	카트 보기
	@Override
	public List<CartVO> viewcart(CartVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mapper.viewcart(vo);
	}
	
//	카트 보기(비회원)
	@Override
	public CartVO productinfo(String pno) throws Exception {
		// TODO Auto-generated method stub
		return mapper.productinfo(pno);
	}
	

//	카트에 담겨있는 제품인지 확인
	@Override
	public int checkcart(CartVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mapper.checkcart(vo);
	}

//	카트 제품 삭제하기
	@Override
	public void deletecart(CartVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.deletecart(vo);
	}

//	카트 업데이트
	@Override
	public void updatecart(CartVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.updatecart(vo);
	}

//	주문하기 - 1. Ordersheet
	@Override
	public void placeanorder(OrderVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.placeanorder(vo);
		
	}

//	주문하기 - 2. orderdetail
	@Override
	public void orderdetail(OrderVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.orderdetail(vo);
	}

//	주문 후 카트 삭제하기
	@Override
	public void ordercartdelete(OrderVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.ordercartdelete(vo);
	}

//	주문목록 불러오기
	@Override
	public List<OrderVO> viewordersheet(OrderVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mapper.viewordersheet(vo);
	}

//	주문상세 정보
	@Override
	public List<OrderVO> vieworderdetail(OrderVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mapper.vieworderdetail(vo);
	}

//	관리자) 전체주문목록 불러오기
	@Override
	public List<OrderVO> adminvieworderlist() throws Exception {
		// TODO Auto-generated method stub
		return mapper.adminvieworderlist();
	}

	

}
