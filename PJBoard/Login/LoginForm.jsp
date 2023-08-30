<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>

		*{ margin:0; padding: 0;}
        body{background-color: #F5F6F7;}
        form{margin-top: 60px;margin-left: 38%;}
        ul,li{ list-style: none;}
        li{margin-bottom: 20px; text-align: left;}
        .box{width: 450px; height: 50px; border: 1px solid #666; padding: 10px;}
        .pbox{width: 120px; height: 50px; border: 1px solid #666; padding: 10px;}
       .necessary{font-size: small; color:red;}
       placeholder{
       font-size: 20px;
       }
   		
</style>
</head>
<body>
	<!-- 
		�׼� �±׸� ���� ���븵ũ�� ����� �������� ��Ŭ����Ͽ� �ش繮����
		���Խ�Ų��.
	 -->
	<jsp:include page = "../Common2/Link.jsp" />
	
	<h2>�α��� ������</h2>
	<!-- 
		���׿����ڸ� ���� request������ ����� �Ӽ����� �ִ� ��쿡��
		���� �޼����� ȭ�鿡 ����Ѵ�.
		�ش� �Ӽ����� �α��� ó�� ���������� ȸ�������� DB���� ã�� ���� ���
		request������ �Ӽ����� �����ϰ� �ȴ�.
	 -->
	<span style="color: red; font-size: 1.2em;">
		<%= request.getAttribute("LoginErrMsg") == null ?
			"" : request.getAttribute("LoginErrMsg")%>
	</span>
	<%
	/*
		���ǿ����� UserId��� �Ӽ����� ���� ���, �� �α��� ó���� ���� ����
		���¿����� �α������� ������ ���� JS�� ���������� ����Ѵ�.
	*/
	if (session.getAttribute("UserId") == null){  // �α��� ���� Ȯ��
		
		//�α׾ƿ� ����
		
	%>
	<!-- �α��� ���� �Է°��� �����ϱ� ���� �Լ��� �������� Ȯ���Ѵ�. -->
	<script>
	function validateForm(form) {
		/*
			<form>�±� ������ �� input �±׿� �Է°��� �ִ��� Ȯ���Ͽ� ����
			���̶�� ���â, ��Ŀ�� �̵�, �������� ��� ó���� �Ѵ�.
		*/
		if(!form.user_id.value){
			alert("���̵� �Է��ϼ���.");
			return false;
			
		}
		if(form.user_pw.value == ""){
			alert("�н����带 �Է��ϼ���.");
			return false;
		}
			
	}
	</script>
	<!-- 
		���� ������ ����<form>�±׷� ������ �� URL, ���۹��, ���� �̸�,
		submit�̺�Ʈ �����ʷ� �����Ѵ�. Ư�� ���������� ���� validateForm()
		�Լ� ȣ��� <form>�±��� DOM�� �μ��� �����Ѵ�.
	 -->
	<form action="./LoginProcess.jsp" method="post" name="loginFrm"
		onsubmit="return validateForm(this);">
		<span >���̵�</span><br><input type = "text" name="user_id" placeholder = "id" class = 'box'/> <br/>
		<span >��й�ȣ</span><br><input type = "password" name="user_pw" placeholder = "pw" class = 'box'/><br/>
		<input type="submit" value="�α����ϱ�"
		style="background:#00C850; color:white; width: 450px; border: 1px solid #666; height:50px; font-size: x-large;" />
	</form>
	<%
	} else{ // �α��� ����
		/*
			session������ ����� �Ӽ����� �ִٸ� �α��ε� �����̹Ƿ� ȸ������
			�� �α׾ƿ� ��ư�� ȭ�鿡 ����Ѵ�.
		*/
	%>
		<% JSFunction.alertLocation("�α��� ����", "../List.jsp", out); %>
	<%
	}
	%>
</body>
</html>