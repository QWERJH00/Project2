<%@page import="noticeboard.NoBoardDAO"%>
<%@page import="noticeboard.NoBoardDTO"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--
    	글쓰기 페이지에 오랫동안 머물러 세션이 삭제되는 경우가 있으므로
    	글쓰기 처리 페이지에서도 반드시 로그인을 확인해야된다.
     -->
<%@ include file = "../IsLoggedIn.jsp" %>
<%
String saveDirectory = application.getRealPath("/Uploads");
//업로드할 파일의 최대용량제한(1MB)로 지정한다.
int maxPostSize = 1024 * 1000;
//인코딩 방식 지정
String encoding = "UTF-8";

try 
{
	/*
		앞에서 준비한 3개의 인수와 request내장객체까지를 이용해서
		MultipartRequest객체를 생성한다. 해당객체가 정상적으로 생성되면
		파일업로드는 완료된다.
	*/
	MultipartRequest mr = new MultipartRequest(request, saveDirectory,
												maxPostSize, encoding);
	
	// mr객체를 통해 서버에 저장된 파일명을 가져온다.
	String fileName = mr.getFilesystemName("attachedFile");
	/*
		파일명에서 앞의 .(닷)을 찾아 인덱스를 확인한 후 확장자를 잘라낸다.
		확장자는 파일의 용도를 나타내는 부분이므로 중요하다.
		파일명에 .(닷)을 여러개 사용할 수 있으므로 끝에서부터 찾는다.
	*/
	String ext = fileName.substring(fileName.lastIndexOf("."));
	// 현재날짜와 시간 및 밀리세컨즈까지 이용해서 파일명으로 사용할 문자열을
	// 만든다.
	String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
	// 확장자와 파일명을 합쳐서 서버에 저장할 파일명을 만들어준다.
	String newFileName = now + ext;

	File oldFile = new File(saveDirectory + File.separator + fileName);
	File newFile = new File(saveDirectory + File.separator + newFileName);
	oldFile.renameTo(newFile);
	
// 클라이언트가 작성한 폼값을 받는다.
String num = mr.getParameter("num");
String title = mr.getParameter("title");
String content = mr.getParameter("content");


// 폼값을 DTO객체에 저장한다.
NoBoardDTO dto = new NoBoardDTO();
dto.setNum(num);
dto.setTitle(title);
dto.setContent(content);
dto.setOfile(fileName);
dto.setSfile(newFileName);
/*
	특히 아이디의 경우 로그인 후 작성페이지에 진입할 수 있으므로 
	세션영역에 저장된 회원아이디를 가져와 dto에 저장한다.
*/
dto.setId(session.getAttribute("UserId").toString());

System.out.println(dto.toString());

// DB연결을 위해 DAO객체를 생성한다.
NoBoardDAO dao = new NoBoardDAO(application);
// 입력값이 저장된 dto객체를 인수로 전달하여 insert쿼리문을 실행한다.
int iResult = dao.insertWrite(dto);
// 자원해제
dao.close();

	if (iResult == 1)
	{
		// 입력에 성공한 경우 리스트로 이동하여 새롭게 등록된 게시물을 확인한다.
		JSFunction.alertLocation("게시물이 등록되었습니다.", "AdList.jsp", out);
	} else 
	{
		// 실패하였다면 재입력을 위해 글쓰기 페이지로 다시 돌아간다.
		JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
	}
}
catch (Exception e) {
	e.printStackTrace();
}
%>