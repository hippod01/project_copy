<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- css -->
<link rel="stylesheet" href="../resources/css/default.css" />
<link rel="stylesheet" href="../resources/css/member.css" />
<!-- 주소찾기 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="../resources/js/addkakaoapi.js" type="text/javascript"></script>
<!-- js -->
<script src="../resources/js/jquery-3.5.1.js" type="text/javascript"></script>
<script src="../resources/js/modify.js" type="text/javascript"></script>
<script>
let msg = '${msg}';
if( msg != ""){
	alert(msg);
}

let err = '${err}';
if ( err != ""){
	alert(err);
}
</script>
</head>
<body>

<!-- header -->
<jsp:include page="../header.jsp"></jsp:include>

<section>
<div id="container">
	<form action="modify" method="post" onsubmit="return checkmem()">
	<h3>MY PAGE</h3>
	
	<table id="memmodify">
		<tr>
			<td>
				<p>아이디 </p>
			</td>
		</tr>
		
		<tr>
			<td>
				<input type="hidden" name="userid" value="${meminfo.userid}" />
				<p  style="background-color: rgb(78,78,78,0.2);" class="meminfobox">${meminfo.userid}</p>
			</td>
		</tr>
		
		<tr>
			<td>
				<p>현재 비밀번호(변경하지 않으려면 비워두세요)</p>
				
			</td>
		</tr>
		
		<tr>
			<td>
				<input type="password" id="curpwd" name="curpwd"  />
			</td>
		</tr>
		
		<tr>
			<td>
				
				<p>새 비밀번호(변경하지 않으려면 비워두세요)</p>
				
			</td>
		</tr>
		
		<tr>
			<td>
				<input type="password" name="userpw" id="userpw"/>
				
				<!-- 유효성 검사 메세지 -->
				<div id="pwmsg"></div>
			</td>
		</tr>
		
		<tr>
			<td>
				
				<p>새 비밀번호 확인</p>
				
			</td>
		</tr>
		
		<tr>
			<td>
				<input type="password" id="checkpw" />
				
				<!-- 유효성 검사 메세지 -->
				<div id="repwmsg"></div>
			</td>
		</tr>
		
		<tr>
			<td>
				
				<p>이름</p>
			</td>
		</tr>
		
		<tr>
			<td>
				<input type="text" name="username" value="${meminfo.username}" />
				
			</td>
		</tr>
		
		<tr>
			<td>
				
				<p>이메일</p>
				
			</td>
		</tr>
		
		<tr>
			<td>
				<input type="text" name="useremail" value="${meminfo.useremail}" />
				
			</td>
		</tr>
		
		<tr>
			<td>
				
				<p>연락처</p>
			</td>
		</tr>
		
		<tr>
			<td>
				<input type="text" name="usercont" value="${meminfo.usercont}" placeholder="000-0000-0000"/>
				
			</td>
		</tr>
		
		<tr>
			<td>
				<p>주소</p>
				
			</td>
		</tr>
		
		<tr>
			<td id="addarea">
				<input type="text" id = "postcode" name="userpc" value="${meminfo.userpc}"readonly="readonly" placeholder="우편번호"/>
				<input type="button" id="pcsearch" value="주소찾기" onclick="addsearch()"/><br>
				<input type="text" id="address" name="useradd1" placeholder="주소" readonly="readonly" value="${meminfo.useradd}"/><br>
				<input type="text" id="extraadd" name="useradd2" placeholder="상세주소" />
			</td>
		</tr>
		
		<tr>
			<td>
				
				<input type="submit" value="수정하기"  />
				<input type="submit" id="delete" value="탈퇴하기"  />
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