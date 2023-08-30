<%@page import="pjmember.PJMemberDTO"%>
<%@page import="pjmember.PJMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String id = (String)session.getAttribute("UserId");

PJMemberDAO dao = new PJMemberDAO(application);
PJMemberDTO dto = dao.selectInfo(id);
dao.close();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table {
    margin-left:auto; 
    margin-right:auto;
}
h2 {text-align: center;}

</style>
<script>
function deleteMember() {
	var confirmed = confirm("정말 탈퇴하시겠습니까?");
	if(confirmed) {
		var form = document.infoFrm;
		form.method = "post";
		form.action = "DeleteMProcess.jsp";
		form.submit();
	}
}
</script>
</head>
<body>
	<jsp:include page="./Common2/Link.jsp" />
	<h2>내 정보</h2>
	<form name="infoFrm">
	<table class="table table-right table-striped-columns" 
	border="1"  style="width:300px;height:200px;">
	<tr>
		<td>이름</td>
		<td><%= dto.getName() %></td>
	</tr>
	<tr>
		<td>아이디</td>
		<td><%= dto.getId() %></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td> <%= dto.getPass() %></td>
	</tr>
	<tr>
		<td>폰번호</td>
		<td><%= dto.getPhone() %></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><%= dto.getEmail() %></td>
	</tr>
	<tr>
		<td>성별</td>
		<td><%= dto.getGender() %></td>
	</tr>
	</table>
	
	<table class="table table-right table-striped-columns"
		style="width:400px;height:200px;border:1px;">
	<tr>
	<td align="center">
	<button type="button" class="btn btn-success"
		onclick="location.href='MemberEdit.jsp?id=<%= dto.getId() %>';">
		    수정하기</button>
	<button type="button" class="btn btn-success" onclick="deleteMember();">회원탈퇴</button>
	<button type="button" class="btn btn-success" onclick="location.href='List.jsp';">
	       목록 보기
	</button>
	</td>
	</tr>
	</table>
	</form>
</body>
</html>