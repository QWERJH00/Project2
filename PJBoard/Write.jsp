<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="./IsLoggedIn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function validateForm(form) { // 필수 입력 확인
		
		if (form.title.value == ""){
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		if (form.content.value == ""){
			alert("내용을 입력하세요.");
			form.content.focus();
			return false;
		}
		if (form.attachedFile.value == ""){
			alert("파일을 등록해주세요.");
			form.attachedFile.focus();
			return false;
		}
		
	}
</script>
</head>
<body>
<jsp:include page="./Common2/Link.jsp" />
<h2>게시판 - 글쓰기</h2>

<form name="writeFrm" method="post" action="WriteProcess2.jsp"  enctype="Multipart/form-data"
onsubmit="return validateForm(this);">
<table border="1" width="90%">
	<tr>
		<td>제목</td>
		<td>
			<input type="text" name="title" style="width:90%;" />
		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td>
			<textarea name="content" style="width:90%; height: 100px;"></textarea>
		</td>
	</tr>
	<tr>
		<td>첨부파일</td>
		<td>
			<input type="file" name="attachedFile" />
		</td>
	
	
	<tr>
		<td colspan="2" align="center">
		<button class="btn btn-success" type="submit">작성완료</button>
		<button class="btn btn-success" type="reset">RESET</button>
		<button class="btn btn-success" type="button" onclick="location.href='List.jsp';">
		목록</button>
	</td>
	</tr>
</table>

</form>
</body>
</html>