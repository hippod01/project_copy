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

<!-- 에디터 4 -->
<script src="../resources/ckeditor/ckeditor.js" type="text/javascript"></script>

<!-- css -->
<link rel="stylesheet" href="../resources/css/product.css" />

</head>

<body>

<!-- header -->
<jsp:include page="../header.jsp"></jsp:include>
<section>
<div id="productviewdiv">

	<h3 id="registertitle">edit product</h3>

	<form action="modify" method="post">
	
		<input type="hidden" id="pno" name="pno" value="${product.pno}" />
		
		<table id="productmodify">
			<tr>
				<td width="40%">카테고리</td>
				<td>
					<select name="pcno" id="pcnoselect" >		
						<c:if test="${product.pcno eq 100}">
							<option value="100" selected="selected">매거진B</option>
							<option value="200" >매거진F</option>
						</c:if>
						<c:if test="${product.pcno eq 200}">					
							<option value="100" >매거진B</option>
							<option value="200" selected="selected">매거진F</option>
						</c:if>
					</select>
				</td>
			</tr>
			<!-- 제품 이미지 -->
			<tr>
				<td colspan="2" style="text-align: center">
					<img style="width : 250px; height : 364px;" src="../resources/image/product/${product.pimgname }" alt="" /><br>
				</td>
			</tr>
			<tr>
				<td>이미지 파일명</td>
				<td><input type="text" name="pimgname" placeholder="제품 이미지 파일 이름" value="${product.pimgname }"/></td>
			</tr>
			<!-- 제품 이름 -->
			<tr>
				<td>제품 이름</td>
				<td><input type="text" name="pname" placeholder="제품 이름" value="${product.pname }" /></td>
			</tr>
			<!-- 제품 가격 -->	
			<tr>
				<td>제품 가격</td>
				<td><input type="text" name="pprice" placeholder="숫자만 입력" value="${product.pprice }"/></td>
			</tr>
		</table>
	
	
	<div id="editorarea">
		<textarea name="pcontent" id="editor">${product.pcontent}</textarea>	
		<script>
		CKEDITOR.replace('editor',{
			uploadUrl: "/db/image/drag",  // 이게 드래그 드롭을 위한 URL
		    filebrowserUploadUrl: "/db/image",  // 파일업로드를 위한 URL
			height : 600
		});
		
		</script>
	</div>
	
	<div id="submitarea">
		
		<input type="submit" value="수정"/>
		<input type="submit" value="삭제"/>
	</div>
	</form>
</div>
</section>


<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>