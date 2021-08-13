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
				String dtitle = request.getParameter("daily_title");
				String ddate =  request.getParameter("daily_date");
				int demoji = Integer.parseInt(request.getParameter("emoji"));

				String dcontent = request.getParameter("daily_content").replace("\r\n","<br>");
					if(dtitle.equals("") || dcontent.equals("") || demoji==0 ){
						
					   out.print("<script>alert('모든 항목을 작성하세요.');history.go(-1);</script>");
						}else{
						String SQL = "update daily set title = ?, date = ?, emoji = ?, cont = ? where  writer = ? AND num = ?";
						
						pstmt = con.prepareStatement(SQL);
		
						pstmt.setString(1, dtitle); 
						pstmt.setString(2, ddate); 
						pstmt.setInt(3, demoji);
						pstmt.setString(4, dcontent);					
						pstmt.setString(5, suserid);
						pstmt.setString(6, idx);

						pstmt.execute();
			
						pstmt.executeUpdate();
	%>			
	<script>
		alert("글이 수정되었습니다.");
		location.href="daily_view.jsp?idx=<%=idx%>";
	</script>
<%	 
				pstmt.close();
				con.close();
			}
	   }//-------------------------------------------------------------------------------------------------------------------------------//
   %>
