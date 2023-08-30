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
		액션 태그를 통해 공통링크로 사용할 페이지를 인클루드하여 해당문서에
		포함시킨다.
	 -->
	<jsp:include page = "../Common2/Link.jsp" />
	
	<h2>로그인 페이지</h2>
	<!-- 
		삼항연산자를 통해 request영역에 저장된 속성값이 있는 경우에만
		에러 메세지를 화면에 출력한다.
		해당 속성값은 로그인 처리 페이지에서 회원정보를 DB에서 찾지 못한 경우
		request영역에 속성값을 저장하게 된다.
	 -->
	<span style="color: red; font-size: 1.2em;">
		<%= request.getAttribute("LoginErrMsg") == null ?
			"" : request.getAttribute("LoginErrMsg")%>
	</span>
	<%
	/*
		세션영역에 UserId라는 속성값이 없는 경우, 즉 로그인 처리가 되지 않은
		상태에서는 로그인폼과 검증을 위한 JS를 웹브라우저에 출력한다.
	*/
	if (session.getAttribute("UserId") == null){  // 로그인 상태 확인
		
		//로그아웃 상태
		
	%>
	<!-- 로그인 폼의 입력값을 검증하기 위한 함수로 빈값인지를 확인한다. -->
	<script>
	function validateForm(form) {
		/*
			<form>태그 하위의 각 input 태그에 입력값이 있는지 확인하여 만약
			빈값이라면 경고창, 포커스 이동, 폼값전송 취소 처리를 한다.
		*/
		if(!form.user_id.value){
			alert("아이디를 입력하세요.");
			return false;
			
		}
		if(form.user_pw.value == ""){
			alert("패스워드를 입력하세요.");
			return false;
		}
			
	}
	</script>
	<!-- 
		폼값 전송을 위한<form>태그로 전송할 때 URL, 전송방식, 폼의 이름,
		submit이벤트 리스너로 구성한다. 특히 폼값검증을 위한 validateForm()
		함수 호출시 <form>태그의 DOM을 인수로 전달한다.
	 -->
	<form action="./LoginProcess.jsp" method="post" name="loginFrm"
		onsubmit="return validateForm(this);">
		<span >아이디</span><br><input type = "text" name="user_id" placeholder = "id" class = 'box'/> <br/>
		<span >비밀번호</span><br><input type = "password" name="user_pw" placeholder = "pw" class = 'box'/><br/>
		<input type="submit" value="로그인하기"
		style="background:#00C850; color:white; width: 450px; border: 1px solid #666; height:50px; font-size: x-large;" />
	</form>
	<%
	} else{ // 로그인 상태
		/*
			session영역에 저장된 속성값이 있다면 로그인된 상태이므로 회원정보
			및 로그아웃 버튼을 화면에 출력한다.
		*/
	%>
		<% JSFunction.alertLocation("로그인 성공", "../List.jsp", out); %>
	<%
	}
	%>
</body>
</html>