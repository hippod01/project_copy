<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- css -->
<link rel="stylesheet" href="resources/css/board.css" />

<script src="resources/js/jquery-3.5.1.js" type="text/javascript"></script>
<script src="resources/js/board.js" type="text/javascript"></script>

</head>
<body>

<!-- header -->
<jsp:include page="header.jsp"></jsp:include>

<sec:authorize access="hasRole('ROLE_ADMIN')" var="hasRoleAdmin"></sec:authorize>

<section>

 <div id="boardlistcontainer">
 	 <c:if test="${btype == 'notice'}">
		   <h3 id="boardname">NOTICE</h3>
		   <div id="catearea">
		  	<a href="board?btype=review">review</a> ⎪ <a href="board?btype=qanda">Q&A</a>
		  </div>
	 </c:if>
	 
	  <c:if test="${btype == 'review'}">
		   <h3 id="boardname">REVIEW</h3>
		   <div id="catearea">
		  	<a href="board?btype=notice">notice</a> ⎪ <a href="board?btype=qanda">Q&A</a>
		  </div>
	 </c:if>
	 
	 <c:if test="${btype == 'qanda'}">
		   <h3 id="boardname">Q&A</h3>
		   <div id="catearea">
		  	<a href="board?btype=notice">notice</a> ⎪ <a href="board?btype=review">review</a>
		  </div>
	 </c:if>
	<input type="hidden" id="btype" value="${btype }" />
	  
	  <!-- 검색바 -->
	  <form action="board" method="get">
	  <div id="search_area">
		  	  <input type="hidden" name="btype" value="${btype}" />
			  <select name="searchType" >
			  	<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="writer">글쓴이</option>
				<option value="tc">제목+내용</option>
			  </select>
			  <input type="text" class="inputkeyword" name="keyword" placeholder="검색어를 입력해주세요"/>
			  <input type="submit" class="writebtn" value="검색"/>
			
		  <!-- member만 글쓰기 가능 -->
		  <sec:authorize access="hasRole('ROLE_MEMBER')">
			  <div id="write_btn_area">
			 	<input type="button" id="regbtn" class="writebtn"  onclick="location.href='/db/board/write?btype=${boardlist[0].btype}'" value="WRITE"> 
			 </div>
		  </sec:authorize>
		  
	  </div>
	  </form>
	
	  <!-- 리뷰 게시판 -->
	  <c:if test="${btype == 'review'}">
	  	<c:forEach items="${boardlist}" var="blist">
	  	
			<a href="/db/board/read?bno=${blist.bno}&btype=${blist.btype}">
			  <table class="boardlist" data-bno="${blist.bno}">
			  
				  	<tr>
				  		<td rowspan="2" style="width : 15%" >
				  			<img style="width : 70px;" src="resources/image/product/${blist.pimgname}" alt="" />
				  		</td>
				  		<td style="width : 65%">${blist.pname}</td>
				  		<td style="width : 20%">
				  			<fmt:parseDate value="${blist.regdate}" var="regdateFmt" pattern="yyyy-MM-dd" />
							<fmt:formatDate value="${regdateFmt }" pattern="yyyy-MM-dd" />
				  		</td>
				  	</tr>
				  	
				  	 <tr>
				  		<td id="title${blist.bno}">${blist.title }</td>
				  		<td>${blist.writer }</td>
				  	</tr>
			  </table>
			</a>
		  </c:forEach>
	</c:if>
		
		
		
	  
	  <!-- 문의게시판 -->
		<c:if test="${btype == 'qanda'}">
			
		  <c:forEach items="${boardlist}" var="blist">
		  
		  <!-- 관리자용 테이블 -->
		  
		  <c:if test="${hasRoleAdmin}">
				<a href="/db/board/read?bno=${blist.bno}&btype=${blist.btype}">
				  <table class="boardlist" data-bno="${blist.bno}" >
				   
					  	<tr>
					  		<td rowspan="2" style="width : 15%" >
					  			<img style="width : 70px;" src="resources/image/product/${blist.pimgname}" alt="" />
					  		</td>
					  		<td style="width : 65%">${blist.pname}</td>
					  		<td style="width : 20%">
					  			<fmt:parseDate value="${blist.regdate}" var="regdateFmt" pattern="yyyy-MM-dd" />
								<fmt:formatDate value="${regdateFmt }" pattern="yyyy-MM-dd" />
					  		</td>
					  	</tr>
					  	
					  	 <tr>
					  		<td id="title${blist.bno}">${blist.title }</td>
					  		<td>${blist.writer }</td>
					  	</tr>
				  </table>
				</a>
			</c:if>
			
			<!-- 글쓴이 테이블 -->
		 
			<c:if test="${loginuser eq blist.writer && !hasRoleAdmin}">
				<a href="/db/board/read?bno=${blist.bno}&btype=${blist.btype}">
				  <table class="boardlist" data-bno="${blist.bno}" >
				   
					  	<tr>
					  		<td rowspan="2" style="width : 15%" >
					  			<img style="width : 70px;" src="resources/image/product/${blist.pimgname}" alt="" />
					  		</td>
					  		<td style="width : 65%">${blist.pname}</td>
					  		<td style="width : 20%">
					  			<fmt:parseDate value="${blist.regdate}" var="regdateFmt" pattern="yyyy-MM-dd" />
								<fmt:formatDate value="${regdateFmt }" pattern="yyyy-MM-dd" />
					  		</td>
					  	</tr>
					  	
					  	 <tr>
					  		<td id="title${blist.bno}">${blist.title }</td>
					  		<td>${blist.writer }</td>
					  	</tr>
				  </table>
				</a>
			</c:if>
			
			<!-- 글쓴이 아닐 때 테이블 -->
			
			<c:if test="${loginuser ne blist.writer && !hasRoleAdmin}">
				 <table class="boardlist" data-bno="${blist.bno}" >
				   
					  	<tr>
					  		<td rowspan="2" style="width : 15%" >
					  			<img style="width : 70px" src="resources/image/product/${blist.pimgname}" alt="" />
					  		</td>
					  		<td style="width : 65%">${blist.pname}</td>
					  		<td style="width : 20%">
					  			<fmt:parseDate value="${blist.regdate}" var="regdateFmt" pattern="yyyy-MM-dd" />
								<fmt:formatDate value="${regdateFmt }" pattern="yyyy-MM-dd" />
					  		</td>
					  	</tr>
					  	
					  	 <tr>
					  		<td id="title${blist.bno}">비밀글 입니다.</td>
					  		<td>${blist.writer }</td>
					  	</tr>
				  </table>
			</c:if>

		</c:forEach>
		
	</c:if>
	
	
	 <!-- 공지 게시판 -->
	 <c:if test="${btype == 'notice'}">
	  	<c:forEach items="${boardlist}" var="blist">
	  	
			<a href="/db/board/read?bno=${blist.bno}&btype=${blist.btype}">
			  <table class="boardlist">
			  		<tr>
				  		<td rowspan="2" style="width : 15%" >${blist.bno}</td>
				  		<td rowspan="2" style="width : 65%;  font-size : 16px">${blist.title }</td>
			  			<td>
			  				<fmt:parseDate value="${blist.regdate}" var="regdateFmt" pattern="yyyy-MM-dd" />
							<fmt:formatDate value="${regdateFmt }" pattern="yyyy-MM-dd" />
			  			</td>
			  		</tr>
			  
				  	<tr>
				  		<td style="width : 20%">${blist.writer }</td>
				  	</tr>
			  </table>
			</a>
		  </c:forEach>
	</c:if>
	<!-- end 공지 -->
	
	<table id="pageBtnTable">
		 <tr id ="prevnext">
				<td >
					<!-- 이전버튼 -->
					<c:if test="${page.prev }">
						<a href="board?btype=${boardlist[0].btype}&pageNum=${page.startpage-1 }"><img style="height : 15px; width : 15px;" src="resources/image/icon/left-arrow.png" alt="" /></a>
					</c:if>
							
					<!-- 시작페이지, 끝페이지 -->
					<!-- 반복문 시작(배열타입X) -->
					<c:forEach var="pageNum" begin="${page.startpage }" end="${page.endpage }">
						<a href="board?btype=${boardlist[0].btype}&pageNum=${pageNum }">${pageNum}</a>
					</c:forEach>
								
					<!-- 다음버튼 -->
					<c:if test="${page.next }">
						<a href="board?btype=${boardlist[0].btype}&pageNum=${page.endpage+1 }"><img style="height : 15px; width : 15px;" src="resources/image/icon/next.png" alt="" /></a>
					</c:if>
				</td>
		</tr>
			
	</table>
	
</div>

</section>



<!-- footer -->
<jsp:include page="footer.jsp"></jsp:include>



</body>
</html>