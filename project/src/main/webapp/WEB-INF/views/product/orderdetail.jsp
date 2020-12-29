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
<!-- <script src="../resources/js/order.js" type="text/javascript"></script> -->
<!-- 카카오 주소찾기 api -->
<script src="../resources/js/addkakaoapi.js" type="text/javascript"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- css -->
<link rel="stylesheet" href="../resources/css/product.css" />
</head>
<body>

<!-- header -->
<jsp:include page="../header.jsp"></jsp:include>

<section>

<div id="listcontainer">

	<h3 id="cart">ORDER DETAIL</h3>
	
		
		
		<h4 class="title orderdate">${orderdetail[0].orderno } ${orderdetail[0].orderdate }</h4>
		<c:forEach items="${orderdetail}" var="olist" >
		<table class="carttable issettable">
		
			
			<tr>
				<td rowspan ="2"><img style="width : 72px; height : 102px;" src="../resources/image/product/${olist.pimgname }" alt="" /></td>
				<td rowspan="1">${olist.pname}</td>
				<td ><!-- 카운팅 위 --></td>
				<td ><!-- 가격 위--></td>
			</tr>
			<tr>
				<td ><!-- 제목 밑 --></td>
				<td>
					<!-- 상품 갯수 -->
					<div id="spandiv">
						<span class="spanbox cntnum${olist.detailno}">${olist.cartstock}</span>
					</div>
					<!-- 상품 가격 -->
				<td id="pricetd"><fmt:formatNumber value="${olist.pprice*olist.cartstock}" pattern="₩ ###,###,###" /></td>
			</tr>
			
			
		</table>
		</c:forEach>

		
		
		<table id="pricetable" class="carttable">
			<tr>
				<td rowspan="3" style="width : 50%"></td>
				<td>주문 금액</td>
				
				<td id="productprice" style="width : 25%">
					<fmt:formatNumber value="${orderdetail[0].totalprice-loginchk}" pattern="₩ ###,###,###" />	
				</td>
				
			</tr>
		
			<tr>
				<!-- <td colspan="2"></td> -->
				<td>배송비</td>
				<!-- 회원 일 때 배송비 -->
				<%-- <sec:authorize access="hasRole('ROLE_MEMBER')">
					<td id ="shipprice" style="width : 25%"> ₩ 0 <span id="freeship">무료배송(회원)</span></td>
				</sec:authorize>
				<!-- 비회원일 때 배송비(로그인X) -->
				<sec:authorize access="isAnonymous()">
					<td id ="shipprice" style="width : 25%"> ₩ 2,500 <span id="freeship">배송비(비회원)</span></td>
				</sec:authorize> --%>
				
				<c:if test="${loginchk == '0' }">
					<td id ="shipprice" style="width : 25%"> ₩ 0 <span id="freeship">무료배송(회원)</span></td>
				</c:if>
				<!-- 비회원일 때 배송비(로그인X) -->
				<c:if test="${loginchk == '2500'}">
					<td id ="shipprice" style="width : 25%"> ₩ 2,500 <span id="freeship">배송비(비회원)</span></td>
				</c:if>
				
			</tr>
			
			<tr>
				<!-- <td colspan="2"></td> -->
				<td>결제 금액</td>
				<td id ="totalprice" style="width : 25%">
					<fmt:formatNumber value="${orderdetail[0].totalprice}" pattern="₩ ###,###,###" />
				</td>
				
			</tr>
		</table>
		
		<h4 class="title">배송지 정보</h4>
		
		<!-- 배송지 설정 -->
		<table id="usershipinfo" class="carttable">
			
			<!-- 현재 페이지 아이디 -->
			<%-- <input type="hidden" name="userid" value="${userinfo.userid}"  /> --%>
			
			<!-- 총금액 -->
			<!-- <input type="hidden" id="totalpriceinput" name="totalprice" /> -->
			
			<tr>
				<td>수령인</td>
				<td>${orderdetail[0].oname}</td>
			</tr>
	
			<tr>
				<td>주소</td>
				<td>${orderdetail[0].opostcode} ${orderdetail[0].oadd1} ${orderdetail[0].oadd2}</td>
			</tr>
			
			
			
			<tr>
				<td>연락처</td>
				<td>${orderdetail[0].ocont }</td>
			</tr>
			
			
		
		</table>
		
		
		<div id="submitarea">
		<sec:authorize access="hasRole('ROLE_MEMBER')">
			<input type="button" value="목록보기" onclick="location.href = '/db/member/orderlist'"/>
		</sec:authorize>
		</div>
		
		
		
		
	
	
</div>

</section>

<!-- footer -->
<jsp:include page="../footer.jsp"></jsp:include>



</body>
</html>