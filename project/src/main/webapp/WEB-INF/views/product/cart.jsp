<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- js  -->
<script src="../resources/js/jquery-3.5.1.js" type="text/javascript"></script>
<script src="../resources/js/productcart.js" type="text/javascript"></script>
<!-- css -->
<link rel="stylesheet" href="../resources/css/product.css" />
</head>
<body>

<!-- header -->
<jsp:include page="../header.jsp"></jsp:include>

<section>

<div id="listcontainer">

	<h3 id="cart">ORDER</h3>
	
	<!--카트 있을 때 -->
	<c:if test="${!empty cartlist}">
	
		<c:forEach items="${cartlist}" var="clist" >
		
		<table class="carttable issettable">
		
			<tr>
				<td rowspan ="2"><a href="/db/product/view?pno=${clist.pno}"><img style="width : 72px; height : 102px;" src="../resources/image/product/${clist.pimgname }" alt="" /></a></td>
				<td rowspan="1">${clist.pname}</td>
				<td ><!-- 카운팅 위 --></td>
				<!-- 삭제 버튼 -->
				<td ><span data-cartno='${clist.cartno}' class="fas fa-times cartdelete"></span></td>
			</tr>
			<tr>
				<td ><!-- 제목 밑 --></td>
				<td><div id="spandiv">
					<span data-cartno = "${clist.cartno }" class="spanbox cntbtn btnleft"><img style="height : 15px; width : 15px;" src="../resources/image/icon/left-arrow.png" alt="" /></span>
					<span class="spanbox cntnum${clist.cartno }">${clist.cartstock}</span>
					<span data-cartno = "${clist.cartno }" class="spanbox cntbtn btnright"><img style="height : 15px; width : 15px;"  src="../resources/image/icon/next.png" alt="" /></span></div></td>
				<td id="pricetd"><fmt:formatNumber value="${clist.pprice*clist.cartstock}" pattern="₩ ###,###,###" /></td>
			</tr>
			
			
		</table>
		

		</c:forEach>
		
		<table id="pricetable" class="carttable">
			<tr>
				<td rowspan="3" style="width : 50%"></td>
				<td>주문 금액</td>
				<td id="productprice" style="width : 25%">상품 금액</td>
			</tr>
		
			<tr>
				<td>배송비</td>
				<!-- 회원 일 때 배송비 -->
				<sec:authorize access="hasRole('ROLE_MEMBER')">
					<td id ="shipprice" style="width : 25%"> ₩ 0 <span id="freeship">무료배송(회원)</span></td>
				</sec:authorize>
				<!-- 비회원일 때 배송비(로그인X) -->
				<sec:authorize access="isAnonymous()">
					<td id ="shipprice" style="width : 25%"> ₩ 2,500 <span id="freeship">배송비(비회원)</span></td>
				</sec:authorize>
			</tr>
			
			<tr>
				<td>결제 금액</td>
				<td id ="totalprice" style="width : 25%">총 금액</td>
			</tr>
		</table>
		
		
		<form action="cart" method="post">
			<div id="submitarea">
				
				<input type="hidden" name="userid" value="${userid}" />
				<input type="button" value="쇼핑 계속하기" onclick="location.href='/db/product/viewall'"/>
				<input type="submit" value="주문하기"/>
			
			</div>
		</form>
			
		
		
	
	</c:if>
	
	<!-- 카트 없을 때 -->
	<c:if test="${empty cartlist && empty sessioncart}">
	
		<table class="carttable emptytable">
			<tr>
				<td>고객님의 장바구니가 현재 비어있습니다.</td>
			</tr>
		
		
		</table>
		
		<div id="submitarea">
			<input type="button" value="쇼핑하러 가기" onclick="location.href='/db/product/viewall'"/>
		</div>	
	</c:if>
		
	
	
</div>

</section>

<!-- footer -->
<jsp:include page="../footer.jsp"></jsp:include>



</body>
</html>