<%@ page language="java" import="java.sql.*" contentType="text/html; charset=utf-8"%>
<%@ include file = "/chap10/include/dbinfo.inc" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String suserid	= request.getParameter("userid");
	String spasswd	= request.getParameter("passwd");

	String SQL	= "select admin_name from admin_members where admin_id = ? and admin_pw = ?";
	pstmt = con.prepareStatement(SQL);

	pstmt.setString(1, suserid);
	pstmt.setString(2, spasswd);
		
	rs = pstmt.executeQuery();

	if (rs.next() == true)
	{
		session.setAttribute("G_ADMIN_ID", suserid);
		session.setAttribute("G_ADMIN_NM", rs.getString(1));
		session.setMaxInactiveInterval(60 * 60);

		response.sendRedirect("/chap11/admin/admin_index.jsp");
	}
	else 
		out.print("로그인을 실패하였습니다.");

	pstmt.close();
	rs.close();
	con.close();
%>