<%@page import="pjmember.PJMemberDTO"%>
<%@page import="pjmember.PJMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp" %>
<%
String id = (String)session.getAttribute("UserId");

PJMemberDAO dao = new PJMemberDAO(application);
PJMemberDTO dto = dao.selectInfo(id);

String sessionId = session.getAttribute("UserId").toString();

int delResult = 0;

if (sessionId.equals(dto.getId())) {
	// 회원 탈퇴한다. 
	dto.setId(id);
	delResult = dao.deleteMember(dto);
	// 자원 해제
	dao.close();
	
	if (delResult == 1){
		/*
			게시물이 삭제되면 내용보기는 의미가 없으므로 목록(리스트)로
			이동하면 된다.
		*/
		JSFunction.alertLocation("탈퇴가 정상적으로 처리되었습니다.", "Login/Logout.jsp", out);
	}
	else {
		// 실패한 경우는 뒤로 이동한다.
		JSFunction.alertBack("삭제에 실패하였습니다.", out);
	}
}
%>