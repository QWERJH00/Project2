<%@page import="pjmember.PJMemberDTO"%>
<%@page import="pjmember.PJMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp" %>
<%
String id = (String)session.getAttribute("UserId");
String pass = (String)session.getAttribute("pass");
String name = request.getParameter("name");
String phone = request.getParameter("phone");
String email = request.getParameter("email");
String gender = request.getParameter("gender");

System.out.println(name);


PJMemberDTO dto = new PJMemberDTO();
dto.setId(id);
dto.setPass(pass);
dto.setName(name);
dto.setPhone(phone);
dto.setEmail(email);
dto.setGender(gender);

System.out.println(name);

// DAO객체 생성을 통해 오라클에 연결한다.
PJMemberDAO dao = new PJMemberDAO(application);
// update 쿼리문을 실행하여 게시물을 수정한다.
int affected = dao.editMember(dto);
// 자원해제
dao.close();
System.out.println(affected);
if (affected == 1){
	/*
		수정이 완료되었으면 수정된 내용을 확인하기 위해 주로 내용보기
		페이지로 이동한다.
	*/
	JSFunction.alertLocation("수정이 완료되었습니다.", "Info.jsp", out);
}
else {
	// 수정에 실패하면 뒤로 이동한다.
	JSFunction.alertLocation("수정에 실패하였습니다.", "Info.jsp", out);
}
%>