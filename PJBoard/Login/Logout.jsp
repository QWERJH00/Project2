<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<%
// �α׾ƿ� ó���� ���� ���
// 1. ȸ������ ������ session�������� �����Ѵ�.
session.removeAttribute("UserId");
session.removeAttribute("UserName");

// 2.session������ ��� �Ӽ��� �Ѳ����� �����Ѵ�.
session.invalidate();

response.sendRedirect("../List.jsp");
%>
<title>Insert title here</title>
</head>
<body>

</body>
</html>