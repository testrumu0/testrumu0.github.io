<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<%@page import="java.util.*" import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

   <%//-------------------------------------------------------------------------------------------------------------------------------//
		//DB연결
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			
		 String connectionURL = "jdbc:sqlserver://localhost:1433;databaseName=CSR_cal;user=PPP;password=11";
		 
		 Connection con = DriverManager.getConnection(connectionURL);
		 
		if(session.getAttribute("userid")==null){
		   out.print("<script>alert('로그인하세요');location.href='member/login_main.jsp'</script>");
	   }else{ 
			String suserid = (String)session.getAttribute("userid");//세션
		 
			PreparedStatement pstmt = null;
			
			String idx = request.getParameter("idx");

			String SQL = "delete from schedule where writer = ? AND num = ?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, suserid); 
			pstmt.setString(2, idx); 		
			
			pstmt.execute();			
%>
			<script>
				self.window.alert("해당 글을 삭제하였습니다.");
				location.href="schedule_li.jsp";

			</script>
<%		 
		pstmt.close();
		con.close();
    }
//-------------------------------------------------------------------------------------------------------------------------------//
   %>
