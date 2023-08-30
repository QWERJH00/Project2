<%@ page import="utils.JSFunction" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
	로그인 체크를 위한 파일로 섹션영역에 UserId라는 속성값이 없으면
	경고창을 띄운 후 로그인페이지로 이동합니다.
	로그인이 필요한 모든 페이지 상단에 include지시어를 통해 포함시킬
	예정이다.
*/
if(session.getAttribute("UserId") == null){
	JSFunction.alertLocation("로그인 후 이용해주십시오.",
			"./Login/LoginForm.jsp", out);
	
	return;
}

// else if(session.getAttribute("UserId") != ("admin")){
// 	JSFunction.alertLocation("관리자가 아닙니다.", 
// 			"./List.jsp", out);
// 	return;
// }
%>
