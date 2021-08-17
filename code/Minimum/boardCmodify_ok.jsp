<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8"%>
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

Statement stmt = null;

try
{
	int num		= Integer.parseInt(multi.getParameter("pnum"));
	
	String title	= multi.getParameter("title");
	String contents	= multi.getParameter("contents");
	String fileName1	= multi.getFilesystemName("file1");
	String fileName2	= multi.getFilesystemName("file2");

	stmt = con.createStatement();

	Calendar dateIn = Calendar.getInstance();
	String indate = Integer.toString(dateIn.get(Calendar.YEAR))		+ "-";
	indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1)	+ "-";
	indate = indate + Integer.toString(dateIn.get(Calendar.DATE))		+ " ";
	indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY))	+ ":";
	indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE))		+ ":";
	indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));

	String SQL	= "UPDATE boardC SET ";
	SQL			=  SQL + "  title	= '" + title     + "'";
	SQL			=  SQL + ", contents	= '" + contents  + "'";
	SQL			=  SQL + ", updatedtm	= '" + indate	 + "'";

	if (fileName1 != null) 
		SQL		=  SQL + ", upfile1 	= '" + fileName1 + "'";
	if (fileName2 != null) 
		SQL		=  SQL + ", upfile2 	= '" + fileName2 + "'";

	SQL			=  SQL + " WHERE num	= " + num;
	
	stmt.executeUpdate(SQL);

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
	if (stmt != null) stmt.close();
	if (con   != null) con.close();

	response.sendRedirect("boardClist.jsp");

} // finally end	
%>