<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<!-- js -->
<script src="resources/js/jquery-3.5.1.js" type="text/javascript"></script>
<!-- 회원가입 유효성 검사 관련 -->
<script src="resources/js/register.js" type="text/javascript"></script>
<!-- 카카오 주소찾기 api -->
<script src="resources/js/addkakaoapi.js" type="text/javascript"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- css -->
<link rel="stylesheet" href="resources/css/default.css" />
<link rel="stylesheet" href="resources/css/member.css" />

</head>
<body>

<!-- header -->
<jsp:include page="header.jsp"></jsp:include>

<section>
<div id="container">
	<h3>JOIN</h3>
	<form action="register" method="post" onsubmit="return checkmem()">
	<table id="register">
		<tr>
			<td>
				<p>아이디<span class="nec">*</span> </p>
				
			</td>
		</tr>
		
		<tr>
			<td>
				<input type="text" id="userid" name="userid" />
				<!-- 유효성 검사 메세지 -->
				<div id="idmsg"></div>
			</td>
		</tr>
		
		<tr>
			<td>
				<p>비밀번호 <span class="nec">*</span> </p>
			</td>
		</tr>
		
		<tr>
			<td>
				<input type="password" id="userpw" name="userpw" />
				<!-- 유효성 검사 메세지 -->
				<div id="pwmsg"></div>
			</td>
		</tr>
		
		<tr>
			<td>
				<p>비밀번호 확인 <span class="nec">*</span> </p>
			</td>
		</tr>
		
		
		<tr>
			<td>
				<input type="password" id="checkpw"/>
				<!-- 유효성 검사 메세지 -->
				<div id="repwmsg"></div>
			</td>
		</tr>
		
		<tr>
			<td>
				<p>이름 <span class="nec">*</span> </p>
			</td>
		</tr>
		
		<tr>
			<td>
				
				<input type="text" id="username" name="username" />
				
				<!-- 유효성 검사 메세지 -->
				<div id="namemsg"></div>
			</td>
		</tr>
		
		<tr>
			<td>
				<p>이메일 <span class="nec">*</span> </p>
				
			</td>
		</tr>
		
		<tr>
			<td>
				<input type="text" id="useremail" name="useremail" />
			</td>
		</tr>
		
		<tr>
			<td>
				<p>연락처 <span class="nec">*</span> </p>
			</td>	
		</tr>
		
		<tr>
			<td>
				<input type="text" id="usercont" name="usercont" placeholder="000-0000-0000"/>
				<!-- 유효성 검사 메세지 -->
				<div id="contmsg"></div>
			</td>
		</tr>
		
		<tr>
			<td>
				<p>주소 <span class="nec">*</span> </p>
			</td>
		</tr>
		
		<tr>
			<td id="addarea">
				
				<input type="text" id = "postcode" name="userpc" readonly="readonly" placeholder="우편번호"/>
				<input type="button" id="pcsearch" value="주소찾기" onclick="addsearch()"/><br>
				
				<input type="text" id="address" name="useradd1" placeholder="주소" readonly="readonly" value="${meminfo.useradd}"/><br>
				<input type="text" id="extraadd" name="useradd2" placeholder="상세주소" />
			</td>
		</tr>
		
		<tr>
			<td id="submitbtn">
				
				<input type="submit" value="가입하기" />
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