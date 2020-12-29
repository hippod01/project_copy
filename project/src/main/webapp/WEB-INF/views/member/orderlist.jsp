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
<link rel="stylesheet" href="../resources/css/default.css" />
<link rel="stylesheet" href="../resources/css/member.css" />

</head>
<body>

<!-- header -->
<jsp:include page="../header.jsp"></jsp:include>


<section>

<h3>MY PAGE</h3>
	
	<aside>
		<a href="/db/member/info">계정정보</a>
		<a href="/db/member/orderlist">주문정보</a>
		<sec:authorize access="hasRole('ROLE_ADMIN')" var="hasRoleAdmin">
		<a href="/db/member/adminpage">관리자</a>
		</sec:authorize>
	</aside>

<div id="orderlistcontainer">
	
	
	
	<!-- 주문 목록이 있을 때 -->
	<c:if test="${userorderlist!=null}">
	
	
	<%-- <input type="hidden" name="userid" value="${meminfo.userid}" /> --%>
	<c:forEach items="${userorderlist}" var="olist">
	
 	<%-- ${olist.orderno} --%>
 	<a href="/db/product/orderdetail?orderno=${olist.orderno}">
 	<div id="eachtable">
	<table id="orderlistnotnull">
		  <tr>
			<td>주문번호</td>
			<td>
				<p>${olist.orderno}</p>	
			</td>
		</tr> 
		
		<tr>
			<td>주문날짜</td>
			<td>
				<p>${olist.orderdate}</p>	
			</td>
		</tr>
		
		<tr>
			<td>수령인</td>
			<td>
				<p>${olist.oname}</p>	
			</td>
		</tr>
		
		<tr>
			<td>주소</td>
			<td>
				<p>${olist.opostcode} ${olist.oadd1} ${olist.oadd2}</p>	
			</td>
		</tr>
		
		<tr>
			<td>총가격</td>
			<td>
				<p><fmt:formatNumber value="${olist.totalprice}" pattern="₩ ###,###,###" /></p>	
			</td>
		</tr>
		
	</table>
	</div>
	</a>
	
	</form>
	</c:forEach>
	
	
	</c:if>
	
	<!-- 주문목록이 없을 때 -->
	<c:if test="${userorderlist[0]==null}">
	<table id="orderlistnull">
		<tr>
			<td>주문 목록이 없습니다.</td>
		</tr>
	</table>
	</c:if>
	
</div>
</section>


<!-- footer -->
<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>