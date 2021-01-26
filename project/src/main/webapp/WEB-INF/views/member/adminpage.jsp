<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- css -->
<link rel="stylesheet" href="../resources/css/member.css" />
<!-- js -->
<script src="../resources/js/jquery-3.5.1.js" type="text/javascript"></script>
<script src="../resources/js/msgView.js" type="text/javascript"></script>


</head>

<body>

<!-- header -->
<jsp:include page="../header.jsp"></jsp:include>

<!-- 쪽지 모달 -->
<div class="modal">
	<!-- 비밀번호 찾기 -->
	<div id="viewMsg" style="padding : 10px;">
		<h4>쪽지 보내기</h4>
		<div id="viewMsgCont">
			<span>ID</span> <input type="text" id="receive_id" placeholder="receive_id" disabled="disabled" />

			<input type="text" id="msgCnt" placeholder="내용 입력" />
			<input type="button" id="msgSend" value="보내기" />
		</div>
	</div>
</div>


<section>

<h3>ADMIN PAGE</h3>
	
	<%-- <aside>
		<a href="/db/member/info">계정정보</a>
		<a href="/db/member/orderlist">주문정보</a>
		<sec:authorize access="hasRole('ROLE_ADMIN')" var="hasRoleAdmin">
		<a href="/db/member/adminpage">관리자</a>
		</sec:authorize>
	</aside> --%>
	
	<aside id="adminmenu">
		<a href="/db/member/adminpage?type=member">회원 관리</a>
		<a href="/db/member/adminpage?type=product">상품 관리</a>
		<a href="/db/member/adminpage?type=order">주문 관리</a>
		<a href="/db/member/adminpage?type=board&btype=notice">게시물 관리</a>
	</aside>

<div id="adminpagecontainer">

	
	<div id="admincontent">
	
	<!-- 회원관리  -->
	<c:if test="${memberlist!=null}">
	
		<table id="admin_member" class="admintable">
			<tr>
				<!-- <td><input type="checkbox" id="allcheck"/> 모두 선택
				<a href="#" class="chkbox_del_btn">선택삭제</a></td> -->
				<td>아이디</td>
				<td>이름</td>
				<td>메일</td>
				<td>연락처</td>
				<td>우편번호</td>
				<td width ="25%">주소</td>
				<td width ="10%">가입일자</td>
				<td width ="9%">수정/탈퇴</td>
			</tr>
			
		<c:forEach items="${memberlist}" var="mlist">
			<tr id="table_tr_each">
				<%-- <td><input type="checkbox" class="chkbox" data-chkvalue="${mlist.userid }"></td> --%>
				<td>${mlist.userid}<span class="far fa-envelope"></span></td>
				<td>${mlist.username}</td>
				<td>${mlist.useremail}</td>
				<td>${mlist.usercont}</td>
				<td>${mlist.userpc}</td>
				<td>${mlist.useradd}</td>
				<td>${mlist.regdate}</td>
				<td>
					<a class="adminbtn" href="#">수정</a>
				    <a class="adminbtn" href="#">탈퇴</a>
				</td>
			</tr>
		</c:forEach>
		
			
		</table>
	</c:if>
	
	
	
	
	<!-- 상품관리 -->
	<c:if test="${productlist!=null}">
		<!-- 등록버튼 -->
		<div id="writebtndiv">
			<a class="adminbtn" href="/db/product/register">등록</a>
		</div>
		
		<table id="admin_product" class="admintable">
			<tr>
				<!-- <td><input type="checkbox" id="allcheck"/> 모두 선택
				<a href="#" class="chkbox_del_btn">선택삭제</a></td> -->
				<td>상품번호</td>
				<td>카테고리</td>
				<td>이미지</td>
				<td>상품이름</td>
				<td>상품가격</td>
				<td width ="9%">수정/삭제</td>
			</tr>
			
		<c:forEach items="${productlist}" var="plist">
			<tr id="table_tr_each" style = "cursor:pointer;" onclick="location.href='/db/product/view?pno=${plist.pno }'">
				<%-- <td><input type="checkbox" class="chkbox" data-chkvalue="${plist.pno }" /></td> --%>
				<td width="10%">${plist.pno }</td>
				
				<c:if test="${plist.pcno eq 100}">
					<td width="10%">매거진B</td>
				</c:if>
				
				<c:if test="${plist.pcno eq 200}">
					<td width="10%">매거진F</td>
				</c:if>
				
				<td><img style="width : 75px; height : 100px;" src="../resources/image/product/${plist.pimgname }" alt="" /></td>
				<td>${plist.pname }</td>
				<td>${plist.pprice }</td>
				<td onclick="event.cancelBubble=true">					
					<input type="button" class="adminbtn_submit" onclick="location.href='/db/product/modify?pno=${plist.pno}' " value="수정" />
					<form action="/db/product/delete" method="post">
						<input type="hidden" name="pno" value="${plist.pno}" />
						<input type="submit" class="adminbtn_submit" value="삭제"/>	
				    </form>
				    
				 </td>
			</tr>
		</c:forEach>
		
		</table>
	</c:if>
	
	
	
	<!-- 주문관리 -->
	<c:if test="${orderlist!=null}">
	
		<table id="admin_order" class="admintable">
			<tr>
				<!-- <td><input type="checkbox" id="allcheck"/> 모두 선택</td> -->
				<td>주문번호</td>
				<td width="5%">주문ID</td>
				<td width="13%">주문자</td>
				<td width="8%">우편번호</td>
				<td width="25%">배송지</td>
				<td width="12%">연락처</td>
				<td>총금액</td>
				<td width="10%">주문일자</td>
			</tr>
			
		<c:forEach items="${orderlist}" var="olist">
				<tr id="table_tr_each" style = "cursor:pointer;" onclick="location.href='/db/product/orderdetail?orderno=${olist.orderno}'">
					<!-- <td><input type="checkbox" class="chkbox"/></td> -->
					<td>${olist.orderno }</td>
					
					<td>
					<c:choose>
					<c:when test="${fn:length(olist.userid) gt 12}">
						비회원	
						<c:out value="${fn:substring(olist.userid, 0, 11)}"></c:out>...
						
					</c:when>
			        <c:otherwise>
			       	 	<c:out value="${olist.userid}"></c:out>
			        </c:otherwise>
					</c:choose>
					</td>
					<td>${olist.oname }</td>
					<td>${olist.opostcode }</td>
					<td>${olist.oadd1 } ${olist.oadd2 }</td>
					<td>${olist.ocont }</td>
					<td>
					<fmt:formatNumber value="${olist.totalprice }" pattern="₩ ###,###,###" /></td>
					<td>${olist.orderdate }</td>
				</tr>
		</c:forEach>
		</table>
	</c:if>
	
	
	<!-- 게시물 관리 -->
	<c:if test="${boardlist != null}">
		<aside id="boardmenu" style="margin-bottom : 10px">
			<a  href="/db/member/adminpage?type=board&btype=notice">공지사항</a>
			<a  href="/db/member/adminpage?type=board&btype=review">review</a>
			<a  href="/db/member/adminpage?type=board&btype=qanda">Q&A</a>
		</aside>
		
		<div id="writebtndiv">
			<a class="adminbtn" href="/db/board/write?btype=${board}">등록</a>
		</div>
		
		<table id="admin_board" class="admintable">
			<tr>
				<!-- <td><input type="checkbox" id="allcheck"/> 모두 선택</td> -->
				<td width ="10%">게시물번호</td>
				<td>제목</td>
				<td width ="8%">작성자</td>
				<td width ="13%">등록일</td>
				<c:if test="${board != 'notice'}">
				<td width ="17%">연결 상품</td>
				</c:if>
				<td width ="9%">수정/삭제</td>
			</tr>
		
		<c:forEach items="${boardlist}" var="blist">
			<tr id="table_tr_each" style = "cursor:pointer;" onclick="location.href='/db/board/read?bno=${blist.bno }&btype=${blist.btype}'">
				<!-- <td><input type="checkbox" class="chkbox"/></td> -->
				<td>${blist.bno }</td>
				<td>${blist.title }</td>
				<td>${blist.writer }</td>
				<td>${blist.regdate }</td>

				<c:if test="${board != 'notice'}">
				<td>
					<a href="/db/product/view?pno=${blist.pno }">
					<div id="pnoitems">
						<%-- <img style="width : 75px; height : 100px;" src="../resources/image/product/${blist.pimgname }" alt="" /> --%>
						<p>${blist.pname }</p>
					</div>
					</a>
				</td>
				</c:if>
				
				<td onclick="event.cancelBubble=true">
					<input type="button" class="adminbtn_submit" onclick="location.href='/db/board/modify?bno=${blist.bno }&btype=${blist.btype}'" value="수정" />
					<form action="/db/board/delete" method="post">
						<input type="hidden" name="bno" value="${blist.bno}" />
						<input type="submit" class="adminbtn_submit" value="삭제"/>
				    </form>
				 </td>
			</tr>
		</c:forEach>
		</table>
	</c:if>
	
	</div>
</div>


</section>

<!-- footer -->
<jsp:include page="../footer.jsp"></jsp:include>


</body>
</html>