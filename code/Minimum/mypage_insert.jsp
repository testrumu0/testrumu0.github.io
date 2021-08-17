<%@ page language="java" import="java.sql.*, java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>

 <%

	String goodscd		= request.getParameter("goodscd");
	String colorcd		= request.getParameter("colorcd");
	String unitprice	= request.getParameter("unitprice");
	String sizecd			= request.getParameter("sizecd");
	String userid			=	(String)session.getAttribute("G_ID");

	PreparedStatement pstmt = null;

try{

	
	String SQL = "insert into wishlist (userid, goodscd, unitprice, color, size, chkYN) values (?,?,?,?,?,?)";
			
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, userid);
			pstmt.setString(2, goodscd);
			pstmt.setString(3, unitprice);
			pstmt.setString(4, colorcd);
			pstmt.setString(5, sizecd);
			pstmt.setString(6, "Y");
			pstmt.execute();

} //try end
/*
catch(SQLException e1){
	e1.printStackTrace();
} // catch SQLException end

catch(Exception e2){
	e2.printStackTrace();
} // catch Exception end
*/
finally{
	if (pstmt  != null) pstmt.close();
	if (con   != null) con.close();
	response.sendRedirect("mypage.jsp");
}
%>