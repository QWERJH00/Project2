<%@page import="fileupload.FileUtil"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="noticeboard.NoBoardDAO"%>
<%@page import="noticeboard.NoBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../IsLoggedIn.jsp"%>
<%
String saveDirectiory = application.getRealPath("/Uploads");
int maxPostSize = 1024 * 1000;
//인코딩 방식 지정
String encoding = "UTF-8";

try{
// 파일 업로드 처리. 객체 생성과 동시에 업로드는 완료된다.
MultipartRequest mr = new MultipartRequest(request, saveDirectiory,
					maxPostSize, encoding);


// 파일을 제외한 나머지 폼값을 얻어온다.
// hidden박스에 저장된 내용(게시물 수정 및 파일수정에 필요함.)
String num = mr.getParameter("num");
String prevOfile = mr.getParameter("prevOfile");
String prevSfile = mr.getParameter("prevSfile");
// 사용자가 직접 입력한 값
String name = mr.getParameter("name");
String title = mr.getParameter("title");
String content = mr.getParameter("content");


// DTO에 데이터 저장
NoBoardDTO dto = new NoBoardDTO();
dto.setNum(num);
dto.setTitle(title);
dto.setContent(content);

// 수정페이지에서 첨부한 파일이 있는 경우 파일명을 변경한다.
String fileName = mr.getFilesystemName("attachedFile");
if (fileName != null) {
	// 날짜와 시간으로 파일명을 생성한 후 확장자와 합쳐서 서버에
	// 저장될 파일명을 만든다. 
	String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
	String ext = fileName.substring(fileName.lastIndexOf("."));
	String newFileName = now + ext;
	
	// 파일객체 생성 후 파일명을 변경한다.
	File oldFile = new File(saveDirectiory + File.separator + fileName);
	File newFile = new File(saveDirectiory + File.separator + newFileName);
	oldFile.renameTo(newFile);
	
	// 업로드된 파일명을 DTO에 저장한다.
	dto.setOfile(fileName);
	dto.setSfile(newFileName);
	
	// 새로운 파일이 등록되었으므로 기존파일을 삭제한다.
	FileUtil.deleteFile(request, "/Uploads", prevSfile);
}
else {
	// 새로운 파일을 등록하지 않은 경우 기존 파일명을 DTO에 저장한다.
	dto.setOfile(prevOfile);
	dto.setSfile(prevSfile);
}

//DB연결 및 업데이트 처리
NoBoardDAO dao = new NoBoardDAO(application);
int affected = dao.updateEdit(dto);
dao.close();

if (affected == 1){
	/*
		수정이 완료되었으면 수정된 내용을 확인하기 위해 주로 내용보기
		페이지로 이동한다.
	*/
	response.sendRedirect("NoView.jsp?num=" + dto.getNum());
}
else {
	// 수정에 실패하면 뒤로 이동한다.
	JSFunction.alertBack("수정하기에 실패하였습니다.", out);
}
}catch(Exception e){
	e.printStackTrace();
	System.out.println("수정 예외발생");
}

%>