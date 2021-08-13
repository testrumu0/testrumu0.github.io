<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@page import="java.util.*" import = "java.sql.*" %>
<html>
    <head>
        <link rel= "stylesheet" type="text/css" href="common.css"> 
        <meta content="text/html; charset=UTF-8">
        <title>Bucket_Insert</title>
    </head>
<body>
	<form action="calendar.jsp" method = "post">
 <%//-------------------------------------------------------------------------------------------------------------------------------//
			//DB연결
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				
			 String connectionURL = "jdbc:sqlserver://localhost:1433;databaseName=CSR_cal;user=PPP;password=11";
			 Connection con = DriverManager.getConnection(connectionURL);
				
		    PreparedStatement pstmt = null;
			   
		if(session.getAttribute("userid")==null){
		  out.print("<script>alert('로그인하세요');location.href='../member/login_main.jsp'</script>");
		 }else{ 
			String suserid = (String)session.getAttribute("userid");//세션

				String btitle = request.getParameter("bk_title");
				String bdate = request.getParameter("bk_year")+request.getParameter("bk_month")+request.getParameter("bk_day");
				String bcontent = request.getParameter("bk_content").replace("\r\n","<br>");
			
				if(btitle.equals("") || bcontent.equals("")){
					
				   out.print("<script>alert('모든 항목을 작성해주세요.');history.go(-1);</script>");

				}else{ //DB에 등록
					 String SQL = "insert into bucket (title,date,cont,writer) values (?,?,?,?)";
					
					pstmt = con.prepareStatement(SQL);
	
					pstmt.setString(1, btitle); 
					pstmt.setString(2, bdate);
					pstmt.setString(3, bcontent);
					pstmt.setString(4, suserid);					

					pstmt.execute();
					
					
			%>
			<script>
				self.window.alert("항목을 저장하였습니다.");
				opener.location.reload();
				location.href="bucket_li.jsp";
			</script>
<%
				pstmt.close();
				con.close();
				}

			}//세션
			//-------------------------------------------------------------------------------------------------------------------------------//
%>
</form>
</body>
</html>