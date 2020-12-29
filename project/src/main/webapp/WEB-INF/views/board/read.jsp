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

<script src="../resources/js/jquery-3.5.1.js" type="text/javascript"></script>
<script src="../resources/js/boardread.js" type="text/javascript"></script>


</head>
<body>

<!-- header -->
<jsp:include page="../header.jsp"></jsp:include>

<!-- 권한 -->
<sec:authorize access="hasRole('ROLE_ADMIN')" var="hasRoleAdmin">
		<input type="hidden" id="auth" value="${hasRoleAdmin}" />
</sec:authorize>

<section>

 <div id="boardlistcontainer">
     
	 <!-- 내용(공지사항) -->
	 <c:if test="${boardvo.btype eq 'notice'}">
	 <h3 id="cateback">NOTICE</h3>
	 <div id="container">
			<table id="noticeread">
				<!-- 제목 -->
				<tr>
					<td><p id="title">${boardvo.title }</p></td>
				</tr>
				<tr>
					<td>등록일 ${boardvo.regdate}</td>
				</tr>
				<tr>
					<td> 조회수 ${boardvo.viewcnt}</td>
				</tr>
				<!-- 내용 -->	
				<tr>
					<td class="contentbox">${boardvo.content }</td>
				</tr>
				
				<tr>
					<td style="border-bottom : 1px solid #ccc;">
						<p style="font-weight: 400; padding-bottom : 10px;">첨부파일</p>
						<div id="uploadfileList">
							<ul>
							
							</ul>
						</div>
					</td>
				</tr>
				
				<tr>
					<td style="padding : 20px 0;">
						<form>
							
							<input type="hidden" id="bno" name="bno" value="${boardvo.bno}" />
							<%-- <input type="hidden" name="pageNum" value="${cri.pageNum }" /> --%>	
							<input type="hidden" name="btype" value="${boardvo.btype}" />				
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<input type="submit" id="modifyget" class="writebtn" value="수정"/>
								<input type="submit" id="delete" class="writebtn" value="삭제"/>
							</sec:authorize>
							<input type="submit" id="list" class="writebtn" value="목록"/>
						</form>
					</td>
				</tr>
				
			</table>
		
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
		   
		   <c:if test="${boardvo.btype eq 'notice'}">
		   	  <a href="/db/board?btype=notice">NOTICE </a>
		   </c:if>	
	 </div>
	
	<div id="readtablecont">
	  	<table  id="readtable">
	  		<c:if test="${boardvo.pno ne 0}">
		  	<tr>
		  		<td style="display : flex; align-items: flex-end; border-bottom : 1px solid #ccc; padding-bottom : 10px;">
		  			<img style="width : 90px;" src="../resources/image/product/${boardvo.pimgname}" alt="" />
		  			<div style="padding : 0 10px;">
			  			<p>${boardvo.pname}</p>
			  			<button onclick="location.href='/db/product/view?pno=${boardvo.pno}'">제품 상세보기</button>
		  			</div>
		  		</td>
		  	</tr>
		  	</c:if>
		  	
		  	<tr>
		  		<td style="padding : 10px 0 ;">
		  			<p> ${boardvo.title} ⎪ ${boardvo.writer} ⎪ ${boardvo.regdate} | 조회수 : ${boardvo.viewcnt}</p>
		  		</td>
		  	</tr>
		  	
		  	<tr>
		  		<td>
		  			<p>${boardvo.content}</p>
		  		</td>
		  	</tr>
		 
	  	</table>
	  </div>
	 
	 
	 <!-- 버튼 영역 -->
	 <div id="btnarea">
	 	<form>
	 		<input type="button" class="writebtn" onclick="location.href='/db/board?btype=${boardvo.btype}'" value="목록">
	 		<input type="hidden" id="bno" name="bno" value="${boardvo.bno}" />
	 		<input type="hidden" name="btype" value="${boardvo.btype}" />
	 		
	 	<c:if test="${loginuser eq boardvo.writer || hasRoleAdmin}">
	 		<input type="submit" id="modifyget" class="writebtn" value="수정">
	 		<input type="submit" id="delete" class="writebtn"  value="삭제" />
	 	</c:if>
	 	</form>
	 </div>
	 
	 
	<!-- 댓글 내용 -->
	 <div id="replylistarea">
	 	
	 	
	 	<!-- 댓글 작성창 -->
	 	<c:if test="${hasRoleAdmin==true}">
			<div id="replywrite" class="replylist">		
				<input type="hidden" id="bno" value="${boardvo.bno}" />
				<input type="text" id="replyer${boardvo.bno}" name="replyer" class="writeinputtext replyer" value="${loginuser}" readonly="readonly" placeholder="작성자"/>
				<input type="text" id="replytext${boardvo.bno}" name="replytext" class="writeinputtext replytext" placeholder="댓글 내용" />								
				<input type="button" data-bno = "${boardvo.bno}" id="replybutton${boardvo.bno}" class="writesubmitbtn" value="댓글쓰기" />
				<input type="hidden" id="updatebutton${boardvo.bno}" class="updatesubmitbtn" value="댓글수정" />
			</div>
		</c:if>
	 </div>
			
	</c:if>		
			
			
</div>



</section>






<!-- footer -->
<jsp:include page="../footer.jsp"></jsp:include>




</body>
</html>