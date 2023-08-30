<%@page import="utils.BoardPage" %>
<%@page import="java.util.*"%>
<%@page import="pjboard.PJBoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="pjboard.PJBoardDAO"%>
<%@page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
// DB연결 및 CRUD작업을 위한 DAO객체를 생성한다.
PJBoardDAO dao = new PJBoardDAO(application);

/*
	검색어가 있는 경우 클라이언트가 선택한 필드명과 검색어를 저장할
	Map컬렉션을 생성한다.
*/
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
int totalCount = dao.selectCount(param);

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
List<PJBoardDTO> boardLists = dao.selectList(param);
// 자원해제
dao.close();
%>
<title>Insert title here</title>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script> -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"> -->
<style>
h2 {text-align: center; }
</style>
</head>
<body>
	<!-- 공통링크 -->
	<jsp:include page = "./Common2/Link.jsp" /> 

    <h2>일반 게시판</h2>
    <!-- 검색 폼 -->
    <form method="get">  
    <table class="container text-center" border="0" style="width:300px;">
    <tr>
        <td align="center">
        	<th style="width:20%">
            <select style="width:85px;height:35px;" name="searchField" size="1" class="form-select" aria-label="Default select example"> 
                <option value="title">제목</option> 
                <option value="content">내용</option>
                <option value="id">작성자</option>
            </select>
            </th>
            <th style="width:60%">
            <input class="form-control" list="datalistOptions" id="exampleDataList" placeholder="search" style="width:150px;height:35px;" type="text" name="searchWord" />
            </th>
            <th style="width:20%">
            <input class="btn btn-primary" style="width:85px;height:35px;" type="submit" value="검색하기" />
        	</th>
    </tr>   
    </table>
    </form>
    &nbsp;&nbsp;&nbsp;
    <!-- 게시물 목록 테이블(표) -->
    <table class="table table-striped" border="1" width="90%">
        <tr align="center">
            <th width="10%">번호</th>
            <th width="50%">제목</th>
            <th width="15%">작성자</th>
            <th width="10%">조회수</th>
            <th width="15%">작성일</th>
        </tr>
        
        <!-- 목록의 내용이 나온다. -->
<%
if (boardLists.isEmpty()) {
%>
        <tr>
            <td colspan="5" align="center">
                등록된 게시물이 없습니다^^*
            </td>
        </tr>
<%
}
else {
	// 출력할 게시물이 있는 경우에는 확장 for문으로 List컬렉션에
	// 저장된 데이텅의 갯수만큼 반복하여 출력한다.
    int virtualNum = 0; 
	
	int countNum = 0;
	
    for (PJBoardDTO dto : boardLists)
    {
    	// 현재 출력할 게시물의 갯수에 따라 출력번호는 달라지므로 
    	// totalCount를 사용하여 가상번호를 부여한다.
        virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);   
%>
        <tr align="center">
        	<!-- 게시물의 가상번호 -->
            <td><%= virtualNum %></td>
            <!-- 제목 -->  
            <td align="left"> 
                <a class="nav-link active" aria-current="page"  href="View2.jsp?num=<%= dto.getNum() %>"><%= dto.getTitle() %></a> 

            </td>
            <!-- 작성자 아이디 -->
            <td align="center"><%= dto.getId() %></td>
            <!-- 조회수 -->           
            <td align="center"><%= dto.getVisitcount() %></td>   
            <!-- 작성일 -->
            <td align="center"><%= dto.getPostdate() %></td>
<%--             <td><a href="Download2.jsp?oName=<%= URLEncoder.encode(dto.getOfile(),"UTF-8") %>&sName=<%= URLEncoder.encode(dto.getSfile(),"UTF-8") %>"> --%>
<!-- 			[다운로드]</a></td>     -->
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
            <td align="right"><button type="button" class="btn btn-primary" onclick="location.href='Write.jsp';">글쓰기
                </button></td>
        </tr>
    </table>
	
</body>
</html>