<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%
// ���� �����ð� ���� 1(�޼��� ���) : �ʴ����� �����Ѵ�.
session.setMaxInactiveInterval(1000);

// �ð� ���� ����
SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");

// ���� ���� �ð�
long creationTime = session.getCreationTime();
String creationTimeStr = dateFormat.format(new Date(creationTime));

// ���������� ������ ��û�� �ð�
long lastTime = session.getLastAccessedTime();
String lastTimeStr = dateFormat.format(new Date(lastTime));
%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h2>Session ���� Ȯ��</h2>
	<!-- 
		���� ���� �ð��� ������ ������ ������ 30��(1800)�� �����ȴ�.
		wob.xml���� <session-config> ������Ʈ�� ���� �д����� ������ �� �ִ�.
	 -->
	<ul>
		<li>���� ���� �ð�: <%=session.getMaxInactiveInterval() %></li>
		<li>���� ���̵�: <%=session.getId() %></li>
		<li>���� ��û �ð� : <%=creationTimeStr %></li>
		<li>������ ��û �ð� : <%=lastTimeStr %></li>
	</ul>
</body>
</html>