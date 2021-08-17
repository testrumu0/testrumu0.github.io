<%@ page language="java" import="java.util.*,java.io.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>
<%
	String realFolder = "";
	String saveFolder = "/chap11/images/";
	String encType = "utf-8";

	int sizeLimit = 10 * 1024 * 1024;
	realFolder = application.getRealPath(saveFolder);
	MultipartRequest multi	= new MultipartRequest(request,realFolder,sizeLimit,encType);

	Statement stmt = con.createStatement();

	String goodscd		= multi.getParameter("goodscd");
	String goodsnm		= multi.getParameter("goodsnm");
	String unitprice	= multi.getParameter("unitprice");
	String best_yn		= multi.getParameter("best_yn");
	if (best_yn != null && best_yn.equals("Y"))
		best_yn	= "Y"; 		// 베스트상품
	else
		best_yn	= "N";		// 일반상품

	String fileName1	= multi.getFilesystemName("goodsimg1");


try{

	String SQL		= "update goodsinfo set ";
	SQL = SQL + "  goodsnm		= '" + goodsnm		+ "' ";
	SQL = SQL + ", unitprice	= '" + unitprice	+ "' ";
	SQL = SQL + ", best_yn		= '" + best_yn		+ "' ";
	if (fileName1 != null)
		SQL = SQL + ", goodsimg1		= '" + fileName1		+ "' ";
	SQL = SQL + "  where goodscd	= '" + goodscd		+ "'";

	stmt.executeUpdate(SQL);

} //try end

catch(SQLException e1){
	e1.printStackTrace();
} // catch SQLException end

catch(Exception e2){
	e2.printStackTrace();
} // catch Exception end

finally{
	if (stmt  != null) stmt.close();
	if (con   != null) con.close();
	response.sendRedirect("goodslist.jsp");
}
%>