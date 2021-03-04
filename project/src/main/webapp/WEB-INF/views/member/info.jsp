<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- js -->
<script src="../resources/js/jquery-3.5.1.js" type="text/javascript"></script>
<script src="../resources/js/msgView.js" type="text/javascript"></script>
<!-- css -->
<link rel="stylesheet" href="../resources/css/default.css" />
<link rel="stylesheet" href="../resources/css/member.css" />
</head>
<body>

<!-- header -->
<jsp:include page="../header.jsp"></jsp:include>

<!-- 쪽지 모달 -->
<div class="modal">
	<!-- 비밀번호 찾기 -->
	<div id="viewMsg">
		<div id="viewMsgCont">
			
			<c:forEach items="${msglist}" var="mlist">
				
				<div id="msglist" data-msgno ="${mlist.message_no}" data-msgchk="${mlist.msg_check}">
				<!-- <span>보낸이 ${mlist.send_id }</span> | -->
					<p><span>${mlist.send_date }</span></p>
					<p>${mlist.content }<c:if test="${mlist.msg_check == 'NO'}"> <span style="text-align : right; color : green;">●</span></c:if></p>
					
				</div>
			</c:forEach>
		</div>
	</div>
</div>


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
		<!-- <a href="#">쪽지 <i class="far fa-envelope"></i> (<span id="MsgIcon"></span>)</a> -->
		<!-- OAuth2 로그인 안보임 -->
		<sec:authentication var="principal" property="principal" />
		<c:if test="${!fn:contains(principal,'@')}">
		<p id="msgViewLink" style="font-size : 14px; ">쪽지 <i class="far fa-envelope"></i> (<span id="MsgIcon"></span>)</p>
		</c:if>
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