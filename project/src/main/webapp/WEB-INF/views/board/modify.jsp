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
<link rel="stylesheet" href="../resources/css/board.css" />
<!-- js -->
<script src="../resources/js/jquery-3.5.1.js" type="text/javascript"></script>
<script src="../resources/js/boardmodify.js" type="text/javascript"></script>
<script src="../resources/js/attachfile.js" type="text/javascript"></script>


</head>
<body>

<!-- header -->
<jsp:include page="../header.jsp"></jsp:include>

<section>


 <div id="boardlistcontainer">
 
 	<!-- 공지사항 게시판 -->
 	<c:if test="${boardvo.btype eq 'notice'}">
 		<h3 id="cateback">NOTICE</h3>
 		<div id="container">
		<form action="/db/board/modify" method="post">
			
			<table id="noticewrite">
				<!-- 제목 -->
				<tr>
					<td>
						<input type="text" id="noticetitle" name="title" value="${boardvo.title }"/>
					</td>
				</tr>
				
				<!-- 내용 -->
				<tr>
					<td class="contentbox">
						<textarea name="content" cols="30" rows="10" autofocus="autofocus">${boardvo.content }</textarea>
					</td>
				</tr>
				
				<tr>
					<td>
						<p>첨부파일</p>
						<input type="file" id="attachfile" name="file" multiple="multiple"/>
						
						<!-- 첨부파일 리스트 보여지는 곳 -->
						<div id="uploadfileList">
							<ul>
							</ul>
						</div>
						
						<!-- 데이터베이스에 파일 정보 넘기는 input hidden 들어오는 곳 -->
						<div id="uploadfileinfo">
							
						</div>
						
						<!-- 데이터베이스에 파일 정보 넘기는 input hidden 들어오는 곳 -->
						<div id="newfileinfo">
							
						</div>
						
						<!-- 데이터베이스에 파일 정보 넘기는 input hidden 들어오는 곳 -->
						<div id="deletefileinfo">
							
						</div>
						
					</td>
				</tr>
				
				<tr>
					<td>
						
						<input type="hidden" id="bno" name="bno" value="${boardvo.bno}" />
						<input type="hidden" name="btype" value="${boardvo.btype}" />
						<button onclick="history.back()">뒤로가기</button>
	 	
						<input id="modify" class="writebtn" type="submit" value="수정" />
	 					<input id="delete" class="writebtn" type="submit" value="삭제" />
					</td>
				</tr>
			</table>
		</form>	
		</div>
 	
 	</c:if>
 
 
 	<!-- review/q&a 게시판 -->
 	<c:if test="${boardvo.btype eq 'review' || boardvo.btype eq 'qanda'}">
  
	  <h3 id="boardname">COMMUNITY</h3>
	  	
	  <div id="catearea">
		  	<c:if test="${boardvo.btype eq 'review'}">
		 	  <a href="/db/board?btype=review">REVIEW</a>
		   </c:if>
		   
		   <c:if test="${boardvo.btype eq 'qanda'}">
		   	 <a href="/db/board?btype=qanda">Q&A </a>
		   </c:if>
		   
		   <c:if test="${boardvo.btype eq 'notice'}">
		   	 <a href="/db/board?btype=notice">NOTICE </a>
		   </c:if>
	  
	  </div>
	  	
	<!-- 테이블영역 -->
	<form action="/db/board/modify" method="post">
	<div id="readtablecont">
	  	<table  id="readtable">
	  	
		  	<tr>
		  		<td style="display : flex; align-items: flex-end;">
		  			<img style="width : 90px;" src="../resources/image/product/${boardvo.pimgname}" alt="" />
		  			<div style="padding : 0 10px;">
			  			<p>${boardvo.pname}</p>
			  			<%-- <button onclick="location.href='/db/product/view?pno=${boardvo.pno}'">제품 상세보기</button> --%>
		  			</div>
		  		</td>
		  	</tr>
		  	
		  	<tr>
		  		<td style="padding : 10px 0 ;">
		  			<p><input type="text" name="title" value="${boardvo.title}"/> ⎪ 
		  			${boardvo.writer} ⎪ ${boardvo.regdate}</p>
		  		</td>
		  	</tr>
		  	
		  	<tr>
		  		<td>
		  			<textarea name="content" >${boardvo.content}</textarea>
		  		</td>
		  	</tr>
		 
	  	</table>
	  </div>
	  
	 <!-- 버튼 영역 -->
	<div>
		<input type="hidden" name="bno" value="${boardvo.bno}" />
		<input type="hidden" name="btype" value="${boardvo.btype}" />
		
	 	<button onclick="history.back()">뒤로가기</button>
	 		
	 	<c:if test="${loginuser eq boardvo.writer}">
	 		<input id="modify" class="writebtn" type="submit" value="수정" />
	 		<input id="delete" class="writebtn" type="submit" value="삭제" />
	 	</c:if>
	</div>
	</form>
	</c:if>
</div>

</section>






<!-- footer -->
<jsp:include page="../footer.jsp"></jsp:include>




</body>
</html>