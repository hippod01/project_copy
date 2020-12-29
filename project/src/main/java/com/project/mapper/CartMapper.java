package com.project.mapper;

import java.util.List;

import com.project.domain.CartVO;
import com.project.domain.OrderDetailVO;
import com.project.domain.OrderVO;
import com.project.domain.ProductsVO;

public interface CartMapper {

//	카트담기
	public void addcart(CartVO vo) throws Exception;
	
//	비회원 카트 청소
	public void cleancart() throws Exception;
	
//	카트 보기
	public List<CartVO> viewcart(CartVO vo) throws Exception;
	
//	카트 보기(비회원)
	public CartVO productinfo(String pno) throws Exception;
	
	
//	카트에 담겨있는 제품인지 확인
	public int checkcart(CartVO vo) throws Exception;
	
//	카트 삭제
	public void deletecart(CartVO vo) throws Exception;
	
//	카트 업데이트
	public void updatecart(CartVO vo) throws Exception;
	
//	주문하기 처리
	public void placeanorder(OrderVO vo) throws Exception;
	
//	주문상세 - 주문할 때 같이
	public void orderdetail(OrderVO vo) throws Exception;
	
//	주문 후 카트 삭제
	public void ordercartdelete(OrderVO vo) throws Exception;
	
//	주문목록 불러오기
	public List<OrderVO> viewordersheet(OrderVO vo) throws Exception;
	
//	주문 상세 정보 가져오기
	public List<OrderVO> vieworderdetail(OrderVO vo) throws Exception;
	
//	관리자) 전체주문목록 불러오기
	public List<OrderVO> adminvieworderlist() throws Exception;
	
}
