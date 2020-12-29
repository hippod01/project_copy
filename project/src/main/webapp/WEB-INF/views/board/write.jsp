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
<script src="../resources/js/boardwrite.js" type="text/javascript"></script>
</head>

<body>


<!-- header -->
<jsp:include page="../header.jsp"></jsp:include>

<!-- 제품 목록 모달 -->
<div class="modal">
	<div id="userorderlist">
		
	</div>							
</div>



<section>


 <div id="boardlistcontainer">
  	<!-- 내용(공지사항) -->
	 <c:if test="${boardvo.btype eq 'notice'}">
	 <h3 id="cateback">NOTICE</h3>
	 <div id="container">
		<form role="form" action="/db/board/write" method="post">
			<table id="noticewrite">
				
				<!-- 제목 -->
				<tr>
					<td><input type="text" id="noticetitle" name="title" placeholder="제목을 입력해주세요." autofocus="autofocus"/></td>
				</tr>
				
				<!-- 내용 -->
				<tr>
					<td><textarea name="content" id="" cols="30" rows="10" placeholder="내용을 입력해주세요."></textarea></td>
				</tr>
				
				<tr>
					<td>
						<p>첨부파일</p>
						<input type="file" id="attachfile" name="file" multiple="multiple"/>
						
						<div id="uploadfileList">
							<ul>
							</ul>
						</div>
						
						<!-- 데이터베이스에 파일 정보 넘기는 input hidden 들어오는 곳 -->
						<div id="uploadfileinfo">
							
						</div>
					</td>
					
				</tr>
				
				<tr>
					<td colspan="4">
						<input type="hidden" name="btype" value="${boardvo.btype}" />	
						<input type="submit" id="boardwrite" class="writebtn" value="작성하기" />
	 					<input type="button" class="writebtn" onclick="location.href='/db/board?btype=${boardvo.btype}'" value="목록">
					</td>
				</tr>
		
			</table>
		</form>
		</div>
	 </c:if>
	 
	 
	<!-- 내용 부분(리뷰/Q&A) -->	
	<c:if test="${boardvo.btype eq 'review' || boardvo.btype eq 'qanda'}">
	 
  	<!-- 상단 타이틀 부분 -->
	  <h3 id="boardname">COMMUNITY</h3>
	 
	 <div id="catearea">
		   	<c:if test="${boardvo.btype eq 'review'}">
		 	  <a href="/db/board?btype=review">REVIEW</a>
		   </c:if>
		   
		   <c:if test="${boardvo.btype eq 'qanda'}">
		   	 <a href="/db/board?btype=qanda">Q&A </a>
		   </c:if>
	 </div>
	 
	<!-- 내용 --> 
	<div id="readtablecont">
		<form action="/db/board/write" method="post">
		
	  	<table id="readtable">
	  	
	  	<c:if test="${boardvo.btype eq 'review' || productvo.pno ne null}">
		  	<tr>
		  		<td style="display : flex; align-items: flex-end; border-bottom : 1px solid #ccc; padding-bottom : 10px;">
			  		<!-- 이미지 들어가는 장소 -->
		  			<img id="pimgname" style="width : 90px;" src="../resources/image/product/${productvo.pimgname}" alt="" />
		  			<div style="padding : 0 10px;">
			  			<!-- 제품 이름 들어가는 장소 -->
			  			<p id="pnameinput">${productvo.pname}</p>
			  			
			  			<c:if test="${boardvo.btype eq 'review'}">
			  				<input type="button" id="selectbtn" value="제품 선택하기">
			  			</c:if>
			  			<c:if test="${boardvo.btype eq 'qanda'}">
			  				<input type="button" class="writebtn" onclick="location.href='/db/product/view?pno=${productvo.pno}'" value="제품 상세보기">
			  			</c:if>
			  			
		  			</div>
		  		</td>
		  	</tr>
		 </c:if>
		 
		  	<tr>
		  		<td style="padding : 10px 0 ;">
		  			<p>제목 : <input type="text" name="title" /> ⎪ 작성자 : <input type="text" id="writer" name="writer" value="${boardvo.writer}" readonly="readonly"/> </p>
		  		</td>
		  	</tr>
		  	
		  	<tr>
		  		<td>
		  			<textarea name="content" ></textarea>
		  		</td>
		  	</tr>
	  	</table>
	  	
	  	<!-- submit 영역 -->
	  	<div>
	  		<!-- board/write 정보 영역 -->
	  		<input type="hidden" name="btype" value="${boardvo.btype}" />
	  		<input type="hidden" id="pnoinput" name="pno" value="${boardvo.pno}" />
	  		<!-- reviewchk update 필요한 정보 영역 -->
	  		<input type="hidden" id="review_orderno" name="orderno"  />
	  		
	  		<input type="submit" class="writebtn" value="작성하기" />
	 		<input type="button" class="writebtn" onclick="location.href='/db/board?btype=${boardvo.btype}'" value="목록">
	 		
	 	</div>
	 	
	  </form>
	 </div>
	</c:if>		
</div>

</section>






<!-- footer -->
<jsp:include page="../footer.jsp"></jsp:include>


</body>
</html>