<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@page import="java.util.*" import = "java.sql.*" %>
<html>
    <head>
        <meta content="text/html; charset=UTF-8">
        <title>Scedule_Insert</title>
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

				String ctitle = request.getParameter("check_title");
				String chdate = request.getParameter("check_year")+request.getParameter("check_month")+request.getParameter("check_day");
				String chcontent = request.getParameter("check_content").replace("\r\n","<br>");
			
				if(ctitle.equals("") || chcontent.equals("")){
					
				   out.print("<script>alert('일정을 작성하지 않았습니다.');history.go(-1);</script>");

				}else{ //DB에 등록
					 String SQL = "insert into checklist (title,date,cont,writer) values (?,?,?,?)";
					
					pstmt = con.prepareStatement(SQL);
	
					pstmt.setString(1, ctitle); 
					pstmt.setString(2, chdate);
					pstmt.setString(3, chcontent);
					pstmt.setString(4, suserid);

					pstmt.execute();
					
%>
			<script>
				self.window.alert("항목을 저장하였습니다.");
				opener.location.reload();
				location.href="check_li.jsp";
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