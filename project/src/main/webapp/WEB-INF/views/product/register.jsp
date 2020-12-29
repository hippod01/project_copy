<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- js -->
<script src="../resources/js/jquery-3.5.1.js" type="text/javascript"></script>
<!-- css -->
<link rel="stylesheet" href="../resources/css/product.css" />

<!-- 에디터 4 -->
<script src="../resources/ckeditor/ckeditor.js" type="text/javascript"></script>

<style>

</style>

</head>
<body>
<!-- header -->
<jsp:include page="../header.jsp"></jsp:include>

<section>
<div id="productviewdiv">
	
	<h3 id="registertitle">add product</h3>
	
	<form action="register" method="post">
	
	<table id="productregister">
		<tr>
			<td width="40%">카테고리</td>
			<td>
				<select name="pcno" id="pcnoselect">
					<option value="100">매거진B</option>
					<option value="200">매거진F</option>
				</select>
			</td>
		</tr>
		
		<tr>
			<td>이미지 파일명</td>
			<td><input type="text" name="pimgname" placeholder="이미지 파일 이름,확장자"  value="default.jpg"/></td>
		</tr>
		
		
		
		
		<tr>
			<td>상품 이름</td>
			<td><input type="text" name="pname" placeholder="상품 이름"/></td>
		</tr>
		
		<tr>
			<td>제품 가격</br>(숫자만 입력)</td>
			<td><input type="text" name="pprice" placeholder="00,000" /></td>
		</tr>
		
		
	</table>
	
	<div id="editorarea">
		<textarea id="editor" name="pcontent"></textarea>
		<script>
		 CKEDITOR.replace('editor',{ 
			// 드래그드롭 업로드
	        uploadUrl: "/db/image/drag",
	     	// 일반 업로드
	        filebrowserUploadUrl: "/db/image?${_csrf.parameterName}=${_csrf.token}",
	        height : 600,
	    } ); 
		</script>
	</div>
	
	<div id="submitarea">
		<input type="submit" value="등록하기" />
	</div>
</form>
				
	
	
</div>
</section>





<!-- footer -->
<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>