<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@page import="java.util.*" import = "java.sql.*" %>

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

			String SQL = "delete from bucket  where writer = ? AND num = ?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, suserid); 
			pstmt.setString(2, idx); 			
			
			pstmt.execute();			
%>
			<script>
				self.window.alert("해당 글을 삭제하였습니다.");
				opener.location.reload();
				location.href="bucket_li.jsp";
			</script>
<%			
		pstmt.close();
		con.close();
	}
//-------------------------------------------------------------------------------------------------------------------------------//
   %>
