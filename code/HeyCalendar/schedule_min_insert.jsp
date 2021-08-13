<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<%@page import="java.util.*" import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
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
				  out.print("<script>alert('로그인하세요');location.href='member/login_main.jsp'</script>");
				 }else{ 
					String suserid = (String)session.getAttribute("userid");//세션

				
				String stitle = request.getParameter("sch_title");
				String salarm = request.getParameter("alarm");
				int syear =Integer.parseInt(request.getParameter("sch_year"));
				int smonth = Integer.parseInt(request.getParameter("sch_month"));
				int sday =Integer.parseInt(request.getParameter("sch_day"));
				int s_start=Integer.parseInt(request.getParameter("sch_start"));
				int s_end =Integer.parseInt(request.getParameter("sch_end"));
				
				String scontent = request.getParameter("sch_content").replace("\r\n","<br>");
			
				if(stitle.equals("") || scontent.equals("") || salarm==null ){
					
				   out.print("<script>alert('모든 항목을 작성하세요.');history.go(-1);</script>");
				}else if(s_end<s_start){
									out.print("<script>alert('시간을 다시 설정해주세요.');history.go(-1);</script>");
				}else{ //DB에 등록
					String SQL = "insert into schedule (title,alarm,year,month,day,cont,writer,start_t,end_t) values (?,?,?,?,?,?,?,?,?)";
					
					pstmt = con.prepareStatement(SQL);
	
					pstmt.setString(1, stitle); 
					pstmt.setString(2, salarm); 
					pstmt.setInt(3, syear);
					pstmt.setInt(4, smonth);
					pstmt.setInt(5, sday);
					pstmt.setString(6, scontent);
					pstmt.setString(7, suserid);
					pstmt.setInt(8, s_start);
					pstmt.setInt(9, s_end);
					
					pstmt.execute();
					
%>			
			<script>
				self.window.alert("일정을 저장하였습니다.");
				opener.location.reload();
				window.close();
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