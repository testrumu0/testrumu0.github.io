<%@ page language="java" import="java.sql.*, java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>

 <%

	String idx[]		= request.getParameterValues("chkName");

	Statement stmt  = con.createStatement();

try{

	for (int ii = 0; ii < idx.length; ii ++){
		String SQL = "delete from wishlist where idx = " + idx[ii];
		stmt.executeUpdate(SQL);
		out.print(SQL);
	}
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
	response.sendRedirect("mypage.jsp");
}
%>