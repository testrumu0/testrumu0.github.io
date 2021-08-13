<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.*" import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<!doctype html>

<html>
    <head>
		<meta charset="utf-8">
        <title></title>
    </head>

    <body>
    <%
	 //DB연결
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		
	 String connectionURL = "jdbc:sqlserver://localhost:1433;databaseName=CSR_cal;user=PPP;password=11";
	 
	 Connection con = DriverManager.getConnection(connectionURL);

	   if(session.getAttribute("userid")==null){
		   out.print("<script>alert('로그인하세요');location.href='member/login_main.jsp'</script>");
	   }else{//세션	
				String suserid = (String)session.getAttribute("userid");
				
				PreparedStatement pstmt = null;
				
				String SQL = "delete from bucket where writer = ? AND goal != 'NULL'";
			
				pstmt = con.prepareStatement(SQL);
				pstmt.setString(1, suserid); 
				
				pstmt.execute();	
%>
			<script>
				self.window.alert("해당 글을 삭제하였습니다.");
				location.href="../calendar.jsp";
			</script>
<%		 
		pstmt.close();
		con.close();				
	   }//세션
%>

    </body>
</html>