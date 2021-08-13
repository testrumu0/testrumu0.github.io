<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@page import="java.util.*" import = "java.sql.*" %>
<html>
    <head>	
        <meta content="text/html; charset=UTF-8">
        <title>Daily_Insert</title>
    </head>
<body>
<form action="daily_view.jsp" method = "post">
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

					String dtitle = request.getParameter("daily_title");
					
					String ddate =  request.getParameter("daily_year")+request.getParameter("daily_month")+request.getParameter("daily_day");
					
					int demoji = Integer.parseInt(request.getParameter("emoji"));

					String dcontent = request.getParameter("daily_content").replace("\r\n","<br>");
				
					if(dtitle.equals("") || dcontent.equals("") || demoji==0){
						
					   out.print("<script>alert('모든 항목을 작성하세요.');history.go(-1);</script>");

					}else{ //DB에 등록
						String SQL = "insert into daily (title,date,emoji,cont,writer) values (?,?,?,?,?)";
						
						pstmt = con.prepareStatement(SQL);
		
						pstmt.setString(1, dtitle); 
						pstmt.setString(2, ddate); 
						pstmt.setInt(3, demoji); 
						pstmt.setString(4, dcontent);
						pstmt.setString(5, suserid);

						pstmt.execute();
%>
			<script>
				self.window.alert("일기를 저장하였습니다.");
				location.href="daily_li.jsp";
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