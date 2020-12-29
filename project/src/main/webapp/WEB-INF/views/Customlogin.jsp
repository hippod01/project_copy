<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- css -->
<link rel="stylesheet" href="resources/css/default.css" />
<link rel="stylesheet" href="resources/css/member.css" />
<!-- js -->
<script src="resources/js/jquery-3.5.1.js" type="text/javascript"></script>
<script src="resources/js/findpw.js" type="text/javascript"></script>


<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>

</head>

<body>

<jsp:include page="header.jsp"></jsp:include>

<!-- 로딩 창 -->
<div class="loading"> 
	<div id="loadimgbox">
	<img style="width : 30px; height : 30px;" src="resources/image/Rolling-1s-200px-2.gif" alt="" />
	</div>
</div>


<!-- 모달창 -->
<div class="modal">
	<!-- 비밀번호 찾기 -->
	<div id="findpw">
		<div id="findpwcont">
		<form action="">
			<h2>비밀번호 찾기</h2>
			<p>아이디</p>
			<input type="text" id = "userid" placeholder="등록된 아이디를 입력해주세요." />
			<p>이메일</p>
			<input type="text" id = "useremail" name="useremail" placeholder="등록된 이메일을 입력해주세요." />
			<input type="button" id="findpwsubmit" value="회원 확인하기" />
		</form>
		</div>
	</div>
	
	<!-- 비회원 주문조회 -->
	<div id="findorder">
		<div id="findordercont">
		<form action="">
			<h2>비회원 주문조회</h2>
			<p>주문번호</p>
			<input type="text" id = "orderno" name="orderno" placeholder="주문번호를 입력해주세요." />
			<p>이름</p>
			<input type="text" id = "ordername" name="oname" placeholder="이름을 입력해주세요." />
			<p>연락처</p>
			<input type="text" id = "ordercont" name="ocont" placeholder="연락처를 입력해주세요." />
			
			<input type="button" id="findOrderSubmit" value="주문 확인하기" />
		</form>
		</div>
	</div>
	
	
</div>

<section>
<div id="container">
<h3>LOGIN</h3>
<form action="login" method="post">
	<table id="login">
	
		<tr>
			<td><p>아이디</p></td>
		</tr>
		
		<tr>
			<td> <input type="text" name="userid" /> </td>
		</tr>
		
		<tr>
			<td><p>비밀번호</p></td>
		</tr>
		
		<tr>
			<td>
				<input type="password" name="userpw" />
				<%-- <input type = "hidden" name = "${_csrf.parameterName }" value = "${_csrf.token }"/> --%>
				<%-- <sec:csrfInput /> --%>
			</td>
		</tr>
		
		<tr>
			<td id="remem_search">
			<div>
				<input type = "checkbox" name="remember-me" value="True" /> 
				<p id="rememberme">로그인 유지</p>
				</div>
				<p id="idpwsearch">비밀번호를 잊으셨나요?</p>
			</td>
		</tr>
		
		<tr>
			<td>
				<input type="submit" value="로그인" />
				<input type="button" value="회원가입" onclick="location.href='/db/register'"/>
			</td>
			
			
		</tr>
		
		<tr>
			<td>
				<input id="findorder" style="width : 100%; background-color: rgb(78,78,78);" type="button" value="비회원 주문조회" />
			</td>
		</tr>
		
		<tr>
			<td  style="padding :  5px 10px;">
				<div style="height : 40px;  overflow : hidden;">
				<a href="/db/oauth2/commence">
					<img style="width : 100%; height : 100%; object-fit : fit;" alt="" src="resources/image/google.jpg"></a>
				<!-- <b>[SIGN-IN with Google]</b> -->
				</div>
			</td>
		</tr>
		
		
		
	</table>
</form>	
	
	






</div>
</section>

<!-- footer -->
<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>