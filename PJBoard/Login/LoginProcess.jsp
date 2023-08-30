<%@page import="pjmember.PJMemberDTO"%>
<%@page import="pjmember.PJMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<%
// 로그인 폼에서 입력한 아이디, 패스워드를 받는다.
String userId = request.getParameter("user_id");
String userPwd = request.getParameter("user_pw");

// web.xml에 입력한 컨텍스트 초기화 파라미터를 읽어온다.
// 해당 정보는 오라클에 접속하기 위한 값으로 구성되어 있다.
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

// 위 정보를 통해 DAO객체를 생성하고 이때 오라클에 연결된다.
PJMemberDAO dao = new PJMemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
// 폼값으로 받은 아이디, 패스워드를 인수로 전달하여 로그인처리를 위한 쿼리를
// 실행한다.
PJMemberDTO PJmemberDTO = dao.getPJMemberDTO(userId, userPwd);
// 자원 해제
dao.close();

if(PJmemberDTO.getId() != null){
	// 로그인에 성공한 경우라면...
	// 세션 영역에 회원아이디와 이름을 저장한다.
	session.setAttribute("UserId", PJmemberDTO.getId());
	session.setAttribute("UserName", PJmemberDTO.getName());
	// 로그인페이지로 이동한다.
	response.sendRedirect("LoginForm.jsp");
}
else {
	// 로그인에 실패한 경우라면...
	// 리퀘스트영역에 에러메세지를 저장한다.
	request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
	// 그리고 로그인페이지로 '포워드'한다. 
	request.getRequestDispatcher("LoginForm.jsp").forward(request, response);
}
%>
<title>Insert title here</title>
</head>
<body>

</body>
</html>