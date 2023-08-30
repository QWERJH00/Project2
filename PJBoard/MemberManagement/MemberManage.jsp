<%@page import="utils.BoardPage" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.*"%>
<%@page import="java.util.List"%>
<%@page import="pjmember.PJMemberDAO"%>
<%@page import="pjmember.PJMemberDTO"%>
<%@page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
PJMemberDAO dao = new PJMemberDAO(application);
Map<String, Object> param = new HashMap<String,Object>();
/*
	검색폼에서 입력한 검색어와 필드명을 파라미터로 받아온다.
	해당 <form>의 전송방식은 get, action속성은 없는 상태이므로
	현재페이지로 폼값이 전송된다.
*/
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
// 사용자가 입력한 검색어가 있다면...
if (searchWord != null){
	/* Map컬렉션에 컬럼명과 검색어를 추가한다. */
	param.put("searchField", searchField);
	param.put("searchWord", searchWord);
}

// Map컬렉션을 인수로 게시물의 갯수를 카운트한다.
int totalCount = dao.selectMember(param);

// 페이징 기능
int pageSize = 
Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage = 
Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));

int totalPage = (int)Math.ceil((double)totalCount / pageSize);


int pageNum = 1; 
String pageTemp = request.getParameter("pageNum");
if (pageTemp != null && !pageTemp.equals(""))
	pageNum = Integer.parseInt(pageTemp);

int start = (pageNum - 1) * pageSize + 1;
int end = pageNum * pageSize;
param.put("start", start);
param.put("end", end);
// 목록에 출력할 게시물을 추출하여 반환받는다.
List<PJMemberDTO> boardLists = dao.selectList(param);
// 자원해제
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<style>
h2 {text-align: center; }
</style>
<meta charset="UTF-8">

</head>
<body>
	<jsp:include page = "../Common2/Link.jsp" /> 
	<h2>회원 관리</h2>
    <!-- 검색 폼 -->
    <form method="get">  
    <table class="container text-center" border="0" style="width:300px;">
    <tr>
        <td align="center">
        	<th style="width:20%">
            <select style="width:85px;height:35px;" name="searchField" size="1" class="form-select" aria-label="Default select example"> 
                <option value="id">회원 아이디</option> 
                <option value="name">회원 이름</option>
            </select>
            </th>
            <th style="width:60%">
            <input class="form-control" list="datalistOptions" id="exampleDataList" placeholder="search" style="width:150px;height:35px;" type="text" name="searchWord" />
            </th>
            <th>
            <input class="btn btn-primary" style="width:85px;height:35px;" type="submit" value="검색하기" />
        	</th>
    </tr>   
    </table>
    </form>
    &nbsp;&nbsp;&nbsp;
    <table class="table table-striped" border="1" >
        <tr align="center">
        	<th width="8%">번호</th>
            <th width="15%">아이디</th>
            <th width="15%">비밀번호</th>
            <th width="15%">이름</th>
            <th width="17%">핸드폰 번호</th>
            <th width="15%">이메일</th>
            <th width="7%">성별</th>
            <th width="8%"></th>
        </tr>
<%
if (boardLists.isEmpty()) {
%>
        <tr>
            <td colspan="5" align="center">
                등록된 회원이 없습니다.
            </td>
        </tr>
<%
}
else {
	// 출력할 게시물이 있는 경우에는 확장 for문으로 List컬렉션에
	// 저장된 데이텅의 갯수만큼 반복하여 출력한다.
    int virtualNum = 0; 
	
	int countNum = 0;
	
    for (PJMemberDTO dto : boardLists)
    {
    	// 현재 출력할 게시물의 갯수에 따라 출력번호는 달라지므로 
    	// totalCount를 사용하여 가상번호를 부여한다.
        virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);   
%>
	<tr align="center">
		<td align="center"><%= virtualNum %></td>
		<td align="center"><%= dto.getId() %></td>
		<td align="center"><%= dto.getPass() %></td>
		<td align="center"><%= dto.getName() %></td>
		<td align="center"><%= dto.getPhone() %></td>
		<td align="center"><%= dto.getEmail() %></td>
		<td align="center"><%= dto.getGender() %></td>
		<td><button type="button" class="btn btn-primary" onclick="location.href='MemberView.jsp?id=<%= dto.getId() %>';">관리</button></td>
	</tr>
<%
    }
}
%>
	</table>
	
    <table class="table table-borderless" border="0" width="90%" class="btn-group me-2" role="group" aria-label="Second group">
		<tr align="right">
        	<td align="right" style="padding-left: 42px;">
			<%= BoardPage.pagingStr(totalCount, pageSize,
                       blockPage, pageNum, request.getRequestURI()) %>
			</td>
		</tr>
	</table>
</body>
</html>