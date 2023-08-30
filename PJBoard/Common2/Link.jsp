<%@page import="pjboard.PJBoardDTO"%>
<%@page import="pjboard.PJBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%
String id = (String)session.getAttribute("UserId");
PJBoardDAO dao = new PJBoardDAO(application);
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<meta charset="EUC-KR">
<table class="table table-borderless"> 
    <tr>
        <td class="nav justify-content-end">
        <!-- 로그인 여부에 따른 메뉴 변화 -->
        <% if (session.getAttribute("UserId") == null) { %>
            <a class="nav-link active" aria-current="page" 
            href="${pageContext.request.contextPath }/PJBoard/Login/LoginForm.jsp">로그인</a>
        <% } else { %>
        	<a class="nav-link active" aria-current="page"
        	href="${pageContext.request.contextPath }/PJBoard/Info.jsp"><%=(session.getAttribute("UserId")) %></a>       	
            <a class="nav-link active" aria-current="page" 
            href="${pageContext.request.contextPath }/PJBoard/Login/Logout.jsp">로그아웃</a>
        <% } %>
        	<a class="nav-link active" aria-current="page"
        	 href="${pageContext.request.contextPath }/PJBoard/NMform.jsp">회원가입</a>
        
        </td>
    </tr>
    </table>
<table class="table table-borderless">
    <tr>
        <td align ="center">
            <!-- 8장과 9장의 회원제 게시판 프로젝트에서 사용할 링크 -->
            <%if(id != null && id.equals("admin")) { %>
            <div class="d-grid gap-2 d-md-block">
            <a class="btn btn-primary" href="${pageContext.request.contextPath }/PJBoard/MemberManagement/MemberManage.jsp">회원관리</a>
            <%} %>

            <a class="btn btn-primary" href="${pageContext.request.contextPath }/PJBoard/NoBoard/AdList.jsp">공지 게시판</a>
 
            <a class="btn btn-primary" href="${pageContext.request.contextPath }/PJBoard/List.jsp">일반 게시판</a>
 
            <a class="btn btn-primary" href="${pageContext.request.contextPath }/PJBoard/Map.jsp">찾아오는 길</a>
            
        	</div>
        </td>
    </tr>
</table>

<title>Insert title here</title>
</head>
<body>
	
</body>
</html>