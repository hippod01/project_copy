<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, minimum-scale=1.0">
<title>매거진B</title>
<!-- css -->
<link rel="stylesheet" href="<c:url value="/resources/css/default.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>">
<!-- fontawesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.13.1/css/all.css" integrity="sha384-xxzQGERXS00kBmZW/6qxqJPyxW3UR0BPsL4c8ILaIWXva5kFi7TxkIIaMiKtqV1Q" crossorigin="anonymous">
<!-- font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<!-- js -->
<script src="<c:url value="/resources/js/jquery-3.5.1.js"/>" type="text/javascript"></script>
<script src="<c:url value="/resources/js/header.js"/>" type="text/javascript"></script>


</head>
<body>




<!-- 상단 -->
<header>

	<!-- 로고, 메뉴 nav -->
	<div id="headcont">
		
		<!-- 로고  -->
		<!-- <a href="/db/"><img src="" alt="logo" /></a> -->
		<a href="/db/"><span id="logo">B</span></a>
		
		<!-- 메인메뉴 -->
		<nav id="menunav">
			<ul>
				<li><a href="<c:url value="/board?btype=notice"/>">NOTICE</a></li>
				<li><a href="<c:url value="/about"/>">ABOUT</a></li>
				<li><a href="<c:url value="/product/viewall"/>">PRODUCTS</a></li>
				<li><a href="<c:url value="/store"/>">STORE</a></li>
				
			</ul>
		</nav>
		
		<!-- 사용자 nav -->
		<nav id="usernav">
			<ul>
				
				<!-- 검색 아이콘 -->
				<li><a href="#" class="search_icon"><img style="width : 30px; height : 30px;" src="<c:url value="/resources/image/icon/search.png"/>" alt="" /></a></li>
				
				<!-- 로그인 안했을 때 -->
				<sec:authorize access="isAnonymous()">
					<li><a href="<c:url value="/Customlogin"/>"><img style="width : 30px; height : 30px;" src="<c:url value="/resources/image/icon/user2.png"/>" alt="" /></a></li>	
				</sec:authorize>
				
				<!-- 로그인 했을 때 -->
				<sec:authorize access="isAuthenticated()">
					<sec:authentication var="principal" property="principal" />
					<!-- 쪽지 키운트 -->
					<input type="hidden" id="login_id" value="${principal.username}" />
					<!-- 사용자 아이콘 -->
					<li>
						<div style="width : 30px; height : 30px">
						<a href="<c:url value="/member/info"/>"><img style="width : 30px; height : 30px;" src="<c:url value="/resources/image/icon/user2.png"/>" alt="" /></a>
						<p id="MsgCheckIcon"></p>
						</div>
					</li>
				</sec:authorize>
				
				<!-- 장바구니 아이콘 -->
				<li><a href="<c:url value="/product/cart"/>"><img style="width : 30px; height : 30px;" src="<c:url value="/resources/image/icon/shopping-bag.png"/>" alt="" /></a></li>
				
				<!-- 관리자 페이지-->
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<li><a href="<c:url value="/member/adminpage?type=member"/>"><img style="width : 30px; height : 30px;" src="<c:url value="/resources/image/icon/settings.png"/>" alt="" /></a></li>
				</sec:authorize>
				
				
			</ul>
	
		</nav>
		
		
		
		<!-- 모바일 메뉴바 -->
		<div id="mbmenubar"> 
			<span class="fas fa-bars menubar"></span>
		</div>
		
	</div>
	
	<div id="search_text_area">
		<form action="/db/product/viewall" method="get">
			<input type="text" id="search_input" name="keyword" placeholder="검색어를 입력해주세요." />
			
			<input type="submit" id="search_submit" value="검색"/>
		</form>
	</div>
	
	<div id="search_result_area">
	
	</div>
	
	
</header>



<div id="mobdiv">
	<!-- 메인메뉴 -->
	<nav id="mobmenunav">
		<ul>
				<li><span class="fas fa-times navclose"></span></li>
			<sec:authorize access="isAnonymous()">
				<li><a href="<c:url value="/Customlogin"/>">login</a></li>
				<li><a href="<c:url value="/register"/>">join us</a></li>
			</sec:authorize>
				
			<sec:authorize access="isAuthenticated()">
				<li><a href="<c:url value="/logout"/>">logout</a></li>
				<li><a href="<c:url value="/member/info"/>">mypage</a></li>
			</sec:authorize>
				
				<li><a href="<c:url value="/board?btype=notice"/>">notice</a></li>
				<li><a href="<c:url value="/about"/>">about</a></li>
				<li><a href="<c:url value="/product/viewall"/>">products</a></li>
				<li><a href="#">store</a></li>
				<li><a href="#">search</a></li>
				
				
		</ul>
	</nav>
		
</div>




<sec:authorize access="isAuthenticated()">
<!-- websocket 쪽지 조회 -->
<script type="text/javascript">

	var wsUri = "wss://7rojd6r5o4.execute-api.ap-northeast-2.amazonaws.com/production/";
	var webSocket = new WebSocket(wsUri);
	
	// 접속이 완료되면
	webSocket.onopen = function(message) {
		/* alert("Server connect..."); */
		sendMessage();
		
	};
	
	// 접속이 끝기는 경우
	webSocket.onclose = function(message) { };
	
	// 에러가 발생하면
	webSocket.onerror = function(message) {
		console.log("error...");
	};
	
	/* header 배지 */
	let MsgCheckIcon = document.getElementById("MsgCheckIcon");
	
	
	
	
	// 서버로부터 메시지가 도착하면 콘솔 화면에 메시지를 남긴다.
	webSocket.onmessage = function(message) {
		
		var data = JSON.parse(message.data);
		
		/* meminfo */
		let MsgIcon = document.getElementById("MsgIcon");
			
			
		if(data.msgcnt >= 0){
			MsgCheckIcon.innerHTML = data.msgcnt;
			MsgIcon.innerHTML = data.msgcnt;
		} 
			
		
	};
	
	// 서버로 메시지를 발송하는 함수
	function sendMessage() {
		// 로그인 아이디 가져옴
		let login_id = document.getElementById("login_id");
		// 소켓으로 보낸다.
		const payload = {"message" : "sendMessage", "login_ig" : login_id.value};
		webSocket.send(JSON.stringify(payload));
		//webSocket.send(login_id.value);
	}
	
	
	

</script>
</sec:authorize>

</body>
</html>