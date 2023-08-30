<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<%
// 로그아웃 처리를 위한 방법
// 1. 회원인증 정보를 session영역에서 삭제한다.
session.removeAttribute("UserId");
session.removeAttribute("UserName");

// 2.session영역에 모든 속성을 한꺼번에 삭제한다.
session.invalidate();

response.sendRedirect("../List.jsp");
%>
<title>Insert title here</title>
</head>
<body>

</body>
</html>