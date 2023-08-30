<%@page import="pjmember.PJMemberDTO"%>
<%@page import="pjmember.PJMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp"%>
<%

String id = (String)session.getAttribute("UserId");
// DAO 객체 생성
PJMemberDAO dao = new PJMemberDAO(application); 
// 기존 게시물의 내용을 읽어온다.
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

<script type="text/javascript">
function validateForm(form) {  
    if (form.name.value == "") {
        alert("이름을 입력하세요.");
        form.name.focus();
        return false;
    }
    if (form.phone.value == "") {
        alert("핸드폰 번호를 입력하세요.");
        form.phone.focus();
        return false;
    }
    if (form.email.value == ""){
		alert("이메일을 작성하세요.");
		form.email.focus();
		return false;
	}
    if (form.gender.value == ""){
		alert("성별을 선택하세요.");
		form.gender.focus();
		return false;
	}
}
</script>
<script>
		 const hypenTel = (target) => {
		 target.value = target.value
		   .replace(/[^0-9]/g, '')
		   .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
		}
</script>
</head>
<body>
	<jsp:include page="./Common2/Link.jsp" />
	<form name="editFrm" method="post" action="MemberEditPro.jsp" 
	      onsubmit="return validateForm(this);">
	<table class="table table-right table-striped-columns"
	 border="1" style="width:300px;height:200px;">
	<tr>
		<td>아이디</td>
		<td><%= dto.getId() %></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td> <%= dto.getPass() %></td>
	</tr>
	<tr>
	    <td>이름</td>
	    <td>
	        <input type = "text" name="name" placeholder = "이름을 입력하세요" class = 'box'/>
	    </td>
	</tr>
	<tr>
	    <td>폰 번호</td>
	    <td>
	        <input type = "text" name="phone" 
                 placeholder = "전화번호를 입력하세요" class = 'box' oninput="hypenTel(this)" maxlength="13"/>
	    </td>
	</tr>
	<tr>
	    <td>이메일</td>
	    <td>
	        <input type = "text" name="email" placeholder = "이메일을 입력하세요" class = 'box'/>
	    </td>
	</tr>
	<tr>
	    <td>성별</td>
	    <td>
	        남자<input type ="radio" name="gender" value="m"/>
            여자<input type ="radio" name="gender" value="f" />
	    </td>
	</tr>
	</table>
	
	<table class="table table-right table-striped-columns"
		style="width:400px;height:200px;border:1px;">
	<tr>
	<td align="center">
	    <button type="submit" class="btn btn-success">작성 완료</button>
	    <button type="reset" class="btn btn-success">다시 입력</button>
	    <button type="button" class="btn btn-success" onclick="location.href='List.jsp';">
	        목록 보기
	</button>
	</td>
	</tr>
	</table>     
	</form>
	      
</body>
</html>