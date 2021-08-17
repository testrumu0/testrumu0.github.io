<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>
<%
String realFolder = "";
String saveFolder = "/chap11/upfile";
String encType = "utf-8";

int sizeLimit = 10 * 1024 * 1024;
realFolder = application.getRealPath(saveFolder);
MultipartRequest multi	= new MultipartRequest(request, realFolder, sizeLimit, encType);

PreparedStatement pstmt = null;
ResultSet rs = null;

try
{
	int num			= Integer.parseInt(multi.getParameter("pnum")); 
	String writername	= multi.getParameter("writername");  
	String title		= multi.getParameter("title");
	String pwd_chk		= multi.getParameter("pwd_chk");
	if (pwd_chk == null) pwd_chk = "N";
	String pwd		= multi.getParameter("pwd");
	String contents		= multi.getParameter("contents");
	String fileName1	= multi.getFilesystemName("file1");
	String fileName2	= multi.getFilesystemName("file2");
	
	String strSQL = "SELECT * FROM boardC WHERE num = ?";
	pstmt = con.prepareStatement(strSQL);
	pstmt.setInt(1, num);

	rs = pstmt.executeQuery();
	rs.next();

	int mgrp		= rs.getInt("mgrp");
	int mseq		= rs.getInt("mseq");
	int mlvl		= rs.getInt("mlvl");

	int new_mseq		= mseq + 1;  // 답변글의 정렬 순번
	int new_mlvl		= mlvl + 1;  // 답변글의 레벨	
		
	Calendar dateIn = Calendar.getInstance();
	String indate = Integer.toString(dateIn.get(Calendar.YEAR)) 		+ "-";
	indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1) 	+ "-";
	indate = indate + Integer.toString(dateIn.get(Calendar.DATE))	 	+ " ";
	indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) 	+ ":";
	indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) 	+ ":";
	indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));

	strSQL = "UPDATE boardC SET mseq = mseq + 1 WHERE mgrp = " + mgrp + " and mseq > " + mseq;
	pstmt = con.prepareStatement(strSQL);
	pstmt.executeUpdate();

	if (rs != null) rs.close();
	rs = null;
		
	strSQL = "select isnull(max(num), 0) from boardC";
	pstmt = con.prepareStatement(strSQL);

	rs = pstmt.executeQuery();

	rs.next();

	int maxnum = rs.getInt(1) + 1;  // 게시판 글번호 구하기

	strSQL ="INSERT INTO boardC(num, mgrp, mseq, mlvl, title, contents, lock_yn, pwd, upfile1, upfile2, writer, writedtm, updatedtm)";
	strSQL = strSQL + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	pstmt = con.prepareStatement(strSQL);
	pstmt.setInt   (1, maxnum);
	pstmt.setInt   (2, mgrp);
	pstmt.setInt   (3, new_mseq);
	pstmt.setInt   (4, new_mlvl);

	pstmt.setString(5, title);
	pstmt.setString(6, contents);
	pstmt.setString(7, pwd_chk);
	pstmt.setString(8, pwd);
	pstmt.setString(9, fileName1);
	pstmt.setString(10, fileName2);
	pstmt.setString(11, writername);
	pstmt.setString(12, indate);
	pstmt.setString(13, indate);
	pstmt.executeUpdate();

} //try end
/*
catch(SQLException e1){
	out.println(e1.getMessage());
} // catch SQLException end

catch(Exception e2){
	e2.printStackTrace();
} // catch Exception end
*/
finally{
	if (pstmt != null) pstmt.close();
	if (rs    != null) rs.close();
	if (con   != null) con.close();

	response.sendRedirect("boardClist.jsp");

} // finally end	
%>	