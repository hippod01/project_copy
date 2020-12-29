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
<!-- css -->
<link rel="stylesheet" href="../resources/css/product.css" />
<!-- js -->
<script src="../resources/js/jquery-3.5.1.js" type="text/javascript"></script>
</head>
<body>

<!-- header -->
<jsp:include page="../header.jsp"></jsp:include>

<section>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
	<div id="buttonarea" style="text-align : center"> 
		<input type="button" class="registerbtn" value="상품등록하기" onclick ="location.href ='/db/product/register'"/>
	</div>
	</sec:authorize>
	
	<h1 class="h1text">SHOP</h1>
	
		
	<h3 class="h3category">
		<a href="/db/product/viewall">ALL</a> 
		<a href="/db/product/viewall?pcno=100">MAGAZINE B</a>   
		<a href="/db/product/viewall?pcno=200">MAGAZINE F</a> 
		<!-- <a href="">OTHERS</a> -->
	</h3>
		
<div id="viewallcontainer">


		<c:forEach items="${productlist}" var="product" >
		<div class="griditem">		
			<a href="/db/product/view?pno=${product.pno }">
				<div id="product">
					<div id="imgarea">
					<img style="" src="../resources/image/product/${product.pimgname }" alt="" />
					</div>
					<c:if test="${product.pcno == 100}">
						<p class="pcno">MAGAZINE B</p>
					</c:if>
					
					<c:if test="${product.pcno == 200}">
						<p class="pcno">MAGAZINE F</p>
					</c:if>
					
					<p class="pname">${product.pname }</p>
					<p class="price">
					<fmt:formatNumber value="${product.pprice }" pattern="₩ ###,###,###" />
					</p>
				</div>
			</a>	
		</div>
		</c:forEach>
	
</div>



</section>

<!-- footer -->
<jsp:include page="../footer.jsp"></jsp:include>



</body>
</html>