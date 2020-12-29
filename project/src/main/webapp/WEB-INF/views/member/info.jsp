<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="../resources/css/default.css" />
<link rel="stylesheet" href="../resources/css/member.css" />


</head>
<body>

<!-- header -->
<jsp:include page="../header.jsp"></jsp:include>


<section>

<sec:authorize access="isRememberMe()">
	This user is login by "Remember Me Cookies"
</sec:authorize>

<div id="container">
	
	<form action="modify" method="get">
	<%-- <input type="hidden" name="userid" value="${meminfo.userid}" /> --%>
	
	<h3>MY PAGE</h3>
	
	<aside>
		<a href="/db/member/info">계정정보</a>
		<a href="/db/member/orderlist">주문정보</a>
		<sec:authorize access="hasRole('ROLE_ADMIN')" var="hasRoleAdmin">
		<a href="/db/member/adminpage?type=member">관리자</a>
		</sec:authorize>
	</aside>
	
	<table id="memberinfo">
	
		<tr>
			<td>
				<p>아이디</p>
			
			</td>
		</tr>
		
		<tr>
			<td>	
				<p class="meminfobox">${meminfo.userid}</p>
			</td>
		</tr>
	
		
		<tr>
			<td>
				<p>이름</p>
			</td>
		</tr>
		
		<tr>
			<td>
				<p class="meminfobox">${meminfo.username}</p>
			</td>
		</tr>
		
		<tr>
			<td>
				<p>이메일</p>
			</td>
		</tr>
		
		<tr>
			<td>
				<p class="meminfobox">${meminfo.useremail}</p>
			</td>
		</tr>
		
		<tr>
			<td>
				<p>연락처</p>
			</td>
		</tr>
		
		<tr>
			<td>
				<p class="meminfobox">${meminfo.usercont}</p>
				
			</td>
		</tr>
		
		<tr>
			<td>
				<p>주소</p>
			</td>
		</tr>
		
		<tr>
			<td>
				<p class="meminfobox">${meminfo.useradd}</p>
			</td>
		</tr>
		
		<tr>
			<td style="display : flex; justify-content: center;">
				
				<c:if test="${!fn:contains(meminfo.userid,'@')}">
					<input type="submit" value="수정하기" />
				</c:if>
				<input type="button" value="로그아웃" onclick="location.href='/db/logout'"/>
			</td>
		</tr>
		
	</table>
	</form>
</div>
</section>


<!-- footer -->
<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>