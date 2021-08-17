<%@ page language="java" import="java.util.*,java.io.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>
<%
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String OrdNo = request.getParameter("ordcd");
	String delistate	= request.getParameter("deliState");
	String ord = "";
	String user = "";

try{
	String SQL = "select a.*, b.ordNo, b.userid from deliveryinfo a inner join order_H b on a.ordNo = b.ordNo";
	pstmt = con.prepareStatement(SQL);
	rs = pstmt.executeQuery();
	while(rs.next()){
		user = rs.getString("userid");
		ord = rs.getString("ordNo");
	}
	
	if(OrdNo.equals(ord)){//중복 처리 안됨...
		SQL = "update deliveryinfo set stat = ? where ordNo = ? ";
		pstmt = con.prepareStatement(SQL);
		
		pstmt.setString(1, delistate); 
		pstmt.setString(2, OrdNo);
		
		pstmt.execute();
				
		pstmt.executeUpdate();
		
	}else{
		SQL = "insert into deliveryinfo (ordNo, stat, userid) values(?, ?, ?)";
		pstmt = con.prepareStatement(SQL);

		pstmt.setString(1, OrdNo);
		pstmt.setString(2, delistate);
		pstmt.setString(3, user);
		
		pstmt.executeUpdate();
	}
	


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
	if (pstmt != null) pstmt.close();
	if (rs    != null) rs.close();
	if (con   != null) con.close();
	response.sendRedirect("deliverylist.jsp");
}
%>