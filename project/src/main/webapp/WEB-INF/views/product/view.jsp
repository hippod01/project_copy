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
<!-- js -->
<script src="../resources/js/jquery-3.5.1.js" type="text/javascript"></script>
<script src="../resources/js/productview.js" type="text/javascript"></script>

<!-- css -->
<link rel="stylesheet" href="../resources/css/product.css" />
<script src="https://cdn.ckeditor.com/ckeditor5/22.0.0/classic/ckeditor.js"></script>
</head>

<body>

<!-- 장바구니 모달창 -->
<div class="modal">
	<div id="cartmodal">
		장바구니 담기 성공!
		<a href="/db/product/cart">장바구니 보러 가기</a>
	</div>
</div>

<!-- header -->
<jsp:include page="../header.jsp"></jsp:include>
<section>
<div id="productviewdiv">
	<form>
		
		<input type="hidden" id="pno" name="pno" value="${product.pno}" />
		
		<table id="productview">
			
			<sec:authorize access="hasRole('ROLE_ADMIN')" var="hasRoleAdmin">
			<c:if test="${hasRoleAdmin}">	
			<input type="hidden" id="auth" value="${hasRoleAdmin}" />
			</c:if>
			
			<tr>
				<td>
					
					<input type="submit" id="adminmodify" value="수정"/>
					<input type="submit" id="admindelete" value="삭제"/>
				</td>
			</tr>
			</sec:authorize>
			
			<!-- 제품 이미지 -->
			<tr>
				<td>
					<img style="width : 250px; height : 364px;" src="../resources/image/product/${product.pimgname }" alt="" />
				</td>
			</tr>
			
			<tr>
				<td><!-- 이미지 스크롤 영역 --></td>
			</tr>
			
			<!-- 제품 이름 -->
			<tr>
				<td style="border-bottom : 0;">
					<p class="pviewname">${product.pname }</p>
				</td>
	
			</tr>
			
		
			<!-- 제품 가격 -->
			<tr>
				<td>
					<p class="viewprice">
					<fmt:formatNumber value="${product.pprice }" pattern="₩ ###,###,###" />
					</p>
				</td>
				
			</tr>
			
			<tr>
				<td>옵션</td>
			</tr>
		
			<!-- 상품 갯수 -->
			<tr>
				<td>
					<div id="spandiv">
						<span class="spanbox cntbtn btnleft"><img style="height : 15px; width : 15px;" src="../resources/image/icon/left-arrow.png" alt="" /></span>
						<span class="spanbox cntbox cntnum">1</span>
						<span class="spanbox cntbtn btnright"><img style="height : 15px; width : 15px;"  src="../resources/image/icon/next.png" alt="" /></span>
					</div>
				</td>
			</tr>
			
			<!-- 장바구니 -->
			<tr>
				<td id="td_cart"><p id="p_cart">장바구니</p></td>
			</tr>
			
			<!-- 배송정보 -->
			<tr>
				<td id="td_shipinfo">
					
					<p id="shipinfo_p"> SHIPPING INFORMATION ↓</p>
					<div id="div_shipinfo">
						<h4>배송정보</h4>
						<p>평균 배송기간은 영업일 기준(주말/공휴일제외) 2~3일정도 소요됩니다. 기본 배송료는 3,000원 이며 배송 정책 및 프로모션에 따라 실제 금액은 달라질 수 있습니다.</p>
						<h4>주문취소</h4>
						<p>회원의 경우 마이페이지에서 주문취소가 가능합니다. 비회원의 경우 [주문조회] – [비회원 1:1문의 게시판]을 통해 접수 가능합니다. 상품 발송 전에만 가능하며 발송 이후에는 교환 및 환불 문의를 통해 가능합니다.</p>
						<h4>교환 및 환불</h4>
						<p>단순 변심에 의한 환불 및 교환은 상품 수령일 포함 7일 이내, 반송은 14일 이내만 가능합니다. 주문 관련 기타 문의는 1:1문의게시판 또는 고객센터를 통해 접수해주세요</p>
					</div>
				</td>
			</tr>
			
		</table>
	</form>
	
	<!-- 글 내용 -->
	<div id="contentarea">
		<div id="contentareainbox">
			${product.pcontent }
		</div>
		<div id="contentlogobox">
		<img style="width : 150px; height: 77px;" src="../resources/image/contentlogo.png" alt="" />
		</div>
		
	</div>
	
	<!-- 리뷰 게시판 -->
	<div class="boardarea review">
		<h3 class="boardname">REVIEW</h3>
		<div class="boardbtnarea">
			<input type="button" onclick="location.href='/db/board?btype=review'" value="LIST">
			<!-- <input type="button" onclick="location.href='/db/board/write?btype=review'" value="WRITE"> -->

		</div>
		<table id="review">
			
				<tr>	
					<td>번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>조회수</td>
				</tr>
				
				<c:if test="${reviewlist[0]!=null}">
				
				<c:forEach items="${reviewlist}" var="rlist">
						
				<!-- 게시판 리스트 -->		
				<tr>
					<td id="tdbno${rlist.bno}" data-bno="${rlist.bno}"></td>
					<td><span id="title">${rlist.title}</span></td>
					<td>${rlist.writer}</td>
					<td>
						<fmt:parseDate value="${rlist.regdate}" var="regdateFmt" pattern="yyyy-MM-dd" />
						<fmt:formatDate value="${regdateFmt }" pattern="yyyy-MM-dd" />
					</td>
					<td>${rlist.viewcnt}</td>
				</tr>
				
				
				<!-- 내용 보이는 영역 -->
				<tr class="contenttr">
					<td colspan ="5" id="contenttd">
						
						<!-- 내용 -->
						<p>${rlist.content}</p>
						<div class="replayarea" id="replylist${rlist.bno}">
							<!-- 댓글 리스트 -->
							
							<%-- "<div id='reply"+this.bno+"' class='replylist' >
									<p class='replyer'>"+this.replyer+this.regdate+"</p>"+
									<p class='replytext'>
										<span>"+this.replytext+"<span>";
										<span>
											<input type='button' id='modify"+bno+"' class='modifybtn' value='수정' />"+
											<input type='button' id='delete"+bno+"' class='deletebtn' value='삭제' /></p></div>";
										</span>
									</p>
								</div>"; 	--%>
						
						</div>
						<!-- 관리자만 댓글 작성 가능 -->
						<c:if test="${hasRoleAdmin==true}">
						<div id="replywrite">		
							<input type="hidden" id="bno" value="${rlist.bno}" />
							<input type="text" id="replyer${rlist.bno}" name="replyer" class="writeinputtext replyer" value="${loginuserid}" readonly="readonly" placeholder="작성자"/>
							<input type="text" id="replytext${rlist.bno}" name="replytext" class="writeinputtext replytext replytext" placeholder="댓글 내용" />								
							<input type="button" data-bno = "${rlist.bno}" id="replybutton${rlist.bno}" class="writesubmitbtn" value="댓글쓰기"/>
							<input type="hidden" id="updatebutton${rlist.bno}" class="updatesubmitbtn" value="댓글수정" />
						</div>
						</c:if>
					</td>
				</tr>
				
				</c:forEach>
				
				</c:if>
				
				<c:if test="${reviewlist[0]==null}">
					<tr><td colspan='5'>작성 글이 없습니다.</td></tr>
				</c:if>
				
		</table>
	</div>
	
	
	<!-- 문의 게시판 -->
	<div class="boardarea qanda">
		
		<h3 class="boardname">Q&A</h3>
		<div class="boardbtnarea">
			<input type="button" onclick="location.href='/db/board?btype=qanda'" value="LIST">
			<input type="button" onclick="location.href='/db/board/write?btype=qanda&pno=${product.pno}'" value="WRITE">

		</div>
		
		
		<table id="qanda">
			
				 <tr>
					<td>번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>조회수</td>
				</tr> 
					
				<c:if test="${qandalist[0]!=null}">
				
				<c:forEach items="${qandalist}" var="qlist">
				
					
				<tr>
					<td id="tdbno${qlist.bno}" data-bno="${qlist.bno}"></td>
					
					<!-- 관리자 일때 -->
					<c:if test="${hasRoleAdmin==true}">
					<td><span id="title">${qlist.title}</span></td>
					</c:if>
					
					<!-- 관리자 아닐 때 -->
					<c:if test="${hasRoleAdmin!=true}">
					<td><span>문의</span></td>
					</c:if>
					
					<td>${qlist.writer}</td>
					<td>
						<fmt:parseDate value="${qlist.regdate}" var="regdateFmt" pattern="yyyy-MM-dd" />
						<fmt:formatDate value="${regdateFmt }" pattern="yyyy-MM-dd" />
					</td>
					<td>${qlist.viewcnt}</td>
				</tr>
				
				<!-- 내용 보이는 영역 -->
				<tr class="contenttr">
					<td colspan ="5" id="contenttd">
						
							<p>${qlist.content}</p>
							
							<div class="replayarea" id="replylist${qlist.bno}">
							<!-- 댓글 리스트 -->
							<%-- <div id="reply${rlist.bno}" class="replylist"> 
								
								
									<p class="replyer">작성자 / 작성일</p>
									<p class="replytext">
										<span>작성내용</span>
										<div>
											<input type="button"  class="replymodifybtn" value='수정' />
											<input type="button"  class="replymodifybtn" value='삭제' />
										</div>
									</p>										 
								</div>	
								
							</div> --%>
			
							</div>
						
						<!-- 관리자만 댓글 작성 가능 -->
						<c:if test="${hasRoleAdmin==true}">
							<div id="replywrite">		
								<input type="hidden" id="bno" value="${qlist.bno}" />
								<input type="text" id="replyer${qlist.bno}" name="replyer" class="writeinputtext replyer" value="${loginuserid}" readonly="readonly" placeholder="작성자"/>
								<input type="text" id="replytext${qlist.bno}" name="replytext" class="writeinputtext replytext" placeholder="댓글 내용" />								
								<input type="button" data-bno = "${qlist.bno}" id="replybutton${qlist.bno}" class="writesubmitbtn" value="댓글쓰기" />
							</div>
						</c:if>
						
					</td>
					
				</tr>
				
				</c:forEach>
				
				</c:if>
				
				<c:if test="${qandalist[0]==null}">
					<tr><td colspan='5'>작성 글이 없습니다.</td></tr>
				</c:if>	
				
			
		</table>
		
	</div>
	
	
</div>		
</section>

<!-- footer -->
<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>