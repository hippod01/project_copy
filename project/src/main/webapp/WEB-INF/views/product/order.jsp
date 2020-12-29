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
<script src="../resources/js/order.js" type="text/javascript"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

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

	<h3 id="cart">ORDER</h3>
	
	
	<c:if test="${!empty cartlist}">
		
		<c:forEach items="${cartlist}" var="clist" >
		<table class="carttable issettable">
			<tr>
				<td rowspan ="2"><a href="/db/product/view?pno=${clist.pno}"><img style="width : 72px; height : 102px;" src="../resources/image/product/${clist.pimgname }" alt="" /></a></td>
				<td rowspan="1">${clist.pname}</td>
				<td ><!-- 카운팅 위 --></td>
				<td ><!-- 가격 위--></td>
			</tr>
			<tr>
				<td ><!-- 제목 밑 --></td>
				<td>
					<!-- 상품 갯수 -->
					<div id="spandiv">
						<span class="spanbox cntnum${clist.cartno }">${clist.cartstock}</span>
					</div>
					<!-- 상품 가격 -->
				<td id="pricetd"><fmt:formatNumber value="${clist.pprice*clist.cartstock}" pattern="₩ ###,###,###" /></td>
			</tr>
		</table>
		</c:forEach>
		
		<table id="pricetable" class="carttable">
			<tr>
				<td rowspan="3" style="width : 50%"></td>
				<td>주문 금액</td>
				<td id="productprice" style="width : 25%">₩ 0 </td>
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
				<td id ="totalprice" style="width : 25%">₩ 0</td>
				
			</tr>
		</table>
		
		<!-- 배송지 설정 -->
		
		<form action="order" id="form_id" method="post" onsubmit='return checkform()'>
		<h4 class="title">배송지 정보</h4>
		
		<table id="usershipinfo" class="carttable">
			<!-- 현재 페이지 아이디 -->
			<c:if test="${empty userinfo.userid}">
				<input type="hidden" name="userid" value="${userid}"  />
			</c:if>
			
			<c:if test="${!empty userinfo.userid}">
				<input type="hidden" name="userid" value="${userinfo.userid}"  />
			</c:if>
			
			
			<!-- 총금액 -->
			<input type="hidden" id="totalpriceinput" name="totalprice" />
			
			<tr>
				<td>받는 사람</td>
				<td><input type="text" id="oname" name="oname" placeholder="받는 사람" value="${userinfo.username }"/></td>
			</tr>
			
			<tr>
				<td>주소</td>
				<td id="addarea">
					<!-- <div id="postcode"> -->
					<input type="text" id="postcode" name="opostcode" value="${userinfo.userpc}"readonly="readonly" placeholder="우편번호"/>
					<input type="button" id="pcsearch" value="주소찾기" onclick="addsearch()"/><br>
					<!-- </div> -->
					<input type="text" id="address" name="oadd1" placeholder="주소" readonly="readonly" value="${userinfo.useradd}"/><br>
					<input type="text" id="extraadd" name="oadd2" placeholder="상세주소" />
				</td>
			</tr>
			
			
			<tr>
				<td>연락처</td>
				<td><input type="text" id="ocont" name="ocont" placeholder="000-0000-0000" value="${userinfo.usercont }"/></td>
			</tr>
			
		
		</table>
		
		
			<div id="submitarea">
				<input type="button" value="뒤로가기" onclick="history.back()"/>
				<input type="submit" id="orderbtn" value="주문하기"/>
			
			</div>
		</form>
		
		
	
			
	
	</c:if>
	
	
</div>

</section>

<!-- footer -->
<jsp:include page="../footer.jsp"></jsp:include>



</body>
</html>