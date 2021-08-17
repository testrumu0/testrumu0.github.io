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

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Statement stmt = con.createStatement();

	String cat1cd			= multi.getParameter("cat1cd");
	String cat2cd			= multi.getParameter("cat2cd");
	String goodsnm		= multi.getParameter("goodsnm");
	String unitprice	= multi.getParameter("unitprice");
	String best_yn		= multi.getParameter("best_yn");
	if (best_yn != null && best_yn.equals("on"))
		best_yn	= "Y"; 		// 베스트상품
	else
		best_yn	= "N";		// 일반상품

	String fileName1	= multi.getFilesystemName("goodsimg1");

try{

	int seq	    		= 0;
	String strSeq   = "";
	
	String SQL = "select max(goodscd) from goodsinfo where left(goodscd, 2) = '" + cat1cd + cat2cd + "'";
	rs = stmt.executeQuery(SQL);

	rs.next() ;

	if (rs == null) {
		seq		= 0;
	}else{
		String maxcode	= rs.getString(1);
		if (maxcode == null)
			seq = 0;
		else{
			strSeq				= maxcode.substring(2);
			seq						= Integer.parseInt(strSeq);
		}
	}

	seq++;
	String newSeq 		= "0000" + Integer.toString(seq);
	int newSeqleng		= newSeq.length();
	String newgoodscd	= cat1cd + cat2cd + newSeq.substring(newSeqleng - 4, newSeqleng);

	SQL		= "insert into goodsinfo(cat1cd, cat2cd, goodscd, goodsnm, unitprice, best_yn, goodsimg1, useflag) values(?, ?, ?, ?, ?, ?, ?, 'Y')";
	pstmt = con.prepareStatement(SQL);

	pstmt.setString(1, cat1cd);
	pstmt.setString(2, cat2cd);
	pstmt.setString(3, newgoodscd);
	pstmt.setString(4, goodsnm);
	pstmt.setInt   (5, Integer.parseInt(unitprice));
	pstmt.setString(6, best_yn);
	pstmt.setString(7, fileName1);
		
	pstmt.executeUpdate();

} //try end

catch(SQLException e1){
	e1.printStackTrace();
} // catch SQLException end

catch(Exception e2){
	e2.printStackTrace();
} // catch Exception end

finally{
	if (pstmt != null) pstmt.close();
	if (stmt  != null) stmt.close();
	if (rs    != null) rs.close();
	if (con   != null) con.close();
	response.sendRedirect("goodslist.jsp");
}
%>