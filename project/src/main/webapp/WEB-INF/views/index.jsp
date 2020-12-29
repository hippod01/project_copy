<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- <title>메인페이지</title> -->
<!-- css -->
<link rel="stylesheet" href="resources/css/default.css" />
<link rel="stylesheet" href="resources/css/index.css" />
<!-- js -->
<script src="resources/js/jquery-3.5.1.js" type="text/javascript"></script>
<script src="resources/js/index.js" type="text/javascript"></script>

</head>
<!-- header -->
<jsp:include page="header.jsp"></jsp:include>
<body>




<!-- 내용 -->
<div id="indexwrap">
	
	
	<!-- 메인 이미지 슬라이드 -->
	<div id="mainimg">
		<div class="leftbtn btn"><img style="cursor: pointer" width = "30px" src="resources/image/icon/left-arrow.png" alt="" /></div>
		<ul>
			<li><a href="/db/product/view?pno=25"><div id="img1" class="backgroundimg" ></div></a></li>
			<li><a href="/db/product/view?pno=26"><div id="img2" class="backgroundimg" ></div></a></li>
			<li><a href="/db/product/view?pno=1"><div id="img3" class="backgroundimg" ></div></a></li>
		</ul>	
		<div class="rightbtn btn"><img style="cursor: pointer" width="30px" src="resources/image/icon/next.png" alt="" /></div>	 
	</div>
	
	
	<div id="contwrap">
		<!-- 공지사항 상하 슬라이드 -->
		<div id="div_notice" class="divsection">
			<h3>NOTICE</h3>
			<ul>
				<c:forEach items="${nlist}" var="nlist" begin="0" end="4" >
				<li>
					<table>
						<tr>
							<td width="10%"><p class="far fa-bell"></p></td>
							<td width = "20%">
								<p id="regdate" >
								<fmt:parseDate value="${nlist.regdate}" var="regdateFmt" pattern="yyyy-MM-dd" />
								<fmt:formatDate value="${regdateFmt }" pattern="yyyy-MM-dd" />
								</p>		
							</td>
							<td style=" width : 60%; text-align: left;">
								<a href="/db/board/read?btype=notice&bno=${nlist.bno }">
									<p id="noticetitle">${nlist.title }</p>
								</a>
							</td>
							<td style=" width : 10%; ">
								<a href="/db/board?btype=notice">
								<p id="morenotice">MORE &ensp;<i class="fas fa-angle-double-right"></i></p>
								</a>
							</td>
						</tr>
					</table>
				</li>
				</c:forEach>
			</ul>
		</div>
	
	
		<!-- 제품영역 -->
		<div id="div_shop" class="divsection">
			<h3>SHOP</h3>
			<div id="viewallcontainer">	
			<c:forEach items="${plist}" var="plist" begin="0" end="4" >
				<div class="griditem">		
					<a href="/db/product/view?pno=${plist.pno }">
						<div id="product">
							<div id="imgarea">
								<img src="resources/image/product/${plist.pimgname }" alt="" />
							</div>
							<p class="pname">${plist.pname}</p>
							<p class="pprice"><fmt:formatNumber value="${plist.pprice }" pattern="₩ ###,###,###" /></p>
						</div>
					</a>	
				</div>
			</c:forEach>
			</div>
	
		</div>	
	
	</div>
	
	
</div>


<!-- footer -->
<jsp:include page="footer.jsp"></jsp:include>


</body>
</html>