<%@page import="pjmember.PJMemberDAO"%>
<%@page import="pjmember.PJMemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
// System.out.println(id);

// DAO 객체 생성을 통해 오라클에 연결한다.
PJMemberDAO dao = new PJMemberDAO(application);
PJMemberDTO dto = dao.MemberView(id);
// System.out.println(id);

//자원해제
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
</style>
<script>
// 게시물 삭제를 위한 JS 함수
function deleteMember2() {
	// confirm()함수는 대화창에서 "예"를 누를 때 true가 반환딘다.
    var confirmed = confirm("정말로 삭제하겠습니까?"); 
    if (confirmed) {
    	// <form>의 name속성을 통해 DOM을 가져온다.
        var form = document.MemberInfoFrm;
    	// 전송방식과 폼값을 전송할 URL을 설정한다.
        form.method = "post"; 
        form.action = "DeleteMemberPro.jsp"; 
        // submit() 함수를 통해 폼값을 전송한다.
        form.submit();         
        // <form>태그 하위의 hidden박스에 설정된 일련번호가 전송된다.
    }
}
</script>
</head>
<body>
	<jsp:include page="../Common2/Link.jsp" />
	<h2>회원정보</h2>
	<form name="MemberInfoFrm">
	<input type="hidden" name="id" value="<%= id %>">
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
		style="width:800px;height:200px;border:1px;">
		<tr>
		<td align="center">
		<button type="button" class="btn btn-success"
		onclick="location.href='MemberBoard.jsp?searchWord=<%= dto.getId() %>&searchField=id';">
		    회원 게시물 </button>
		<button class="btn btn-success" type="button" onclick="deleteMember2();">탈퇴시키기</button>
		<button class="btn btn-success" type="button" onclick="location.href='MemberManage.jsp';">
	       회원 목록 
	</button>
		</td>
		</tr>
	</table>
	</form>
</body>
</html>