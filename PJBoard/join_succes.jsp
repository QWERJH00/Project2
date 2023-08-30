<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page = "./Common2/Link.jsp" />
	<%
	JSFunction.alertLocation("회원가입을 축하합니다.", "List.jsp", out);
	%>
</body>
</html>