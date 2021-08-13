<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<%@page import="java.util.*" import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

   <%
		//-------------------------------------------------------------------------------------------------------------------------------//
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
					String stitle = request.getParameter("sch_title");
					String salarm = request.getParameter("alarm");
					int syear =Integer.parseInt(request.getParameter("sch_year"));
					int smonth = Integer.parseInt(request.getParameter("sch_month"));
					int sday =Integer.parseInt(request.getParameter("sch_day"));
					int time_start=Integer.parseInt(request.getParameter("sch_start"));
					int time_end =Integer.parseInt(request.getParameter("sch_end"));

					String scontent = request.getParameter("sch_content").replace("\r\n","<br>");
						if(stitle.equals("") || scontent.equals("") || salarm==null ){					
						   out.print("<script>alert('모든 항목을 작성하세요.');history.go(-1);</script>");
						}else{  /*사용자와 글번호가 같은 일정 불러오기*/
							String SQL = "update schedule set title = ?, alarm = ?, year = ?, month = ?, day = ?, cont = ?, start_t = ?, end_t = ? where writer = ? AND num = ?";
							
							pstmt = con.prepareStatement(SQL);
			
							pstmt.setString(1, stitle); 
							pstmt.setString(2, salarm);
							pstmt.setInt(3, syear);
							pstmt.setInt(4, smonth);
							pstmt.setInt(5, sday);
							pstmt.setString(6, scontent);
							pstmt.setInt(7, time_start);
							pstmt.setInt(8, time_end);							
							pstmt.setString(9, suserid);
							pstmt.setString(10, idx);

							pstmt.execute();
				
							pstmt.executeUpdate();
	%>		
	<script>
		alert("글이 수정되었습니다.");
		opener.location.reload();
		location.href="schedule_min_view.jsp?idx=<%=idx%>";
	</script>
	<%	 
				pstmt.close();
				con.close();
			}
	   }//세션끝
//-------------------------------------------------------------------------------------------------------------------------------//
   %>
