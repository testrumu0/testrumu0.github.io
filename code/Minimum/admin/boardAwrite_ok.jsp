<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>
<%

PreparedStatement pstmt = null;

try
{

	String writername	= request.getParameter("writername");  
	String title		= request.getParameter("title");
	String contents		= request.getParameter("contents");

	String strSQL ="INSERT INTO boardA(title, contents, writer, writedtm, updatedtm) VALUES (?, ?, ?, ?, ?)";
	pstmt = con.prepareStatement(strSQL);

	Calendar dateIn = Calendar.getInstance();
	String indate = Integer.toString(dateIn.get(Calendar.YEAR))		+ "-";
	indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1)	+ "-";
	indate = indate + Integer.toString(dateIn.get(Calendar.DATE))		+ " ";
	indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY))	+ ":";
	indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE))		+ ":";
	indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));

	pstmt.setString(1, title);
	pstmt.setString(2, contents);
	pstmt.setString(3, writername);
	pstmt.setString(4, indate);
	pstmt.setString(5, indate);
	pstmt.executeUpdate();


} // try end
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
	if (con   != null) con.close();

	response.sendRedirect("boardAlist.jsp");
} // finally end
%>