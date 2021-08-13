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
			String btitle = request.getParameter("bk_title");
			String bdate =  request.getParameter("bk_date");
		    
			String bcontent = request.getParameter("bk_content").replace("\r\n","<br>");			
				if(btitle.equals("") || bcontent.equals("") ){					
				 out.print("<script>alert('모든 항목을 작성하세요.');history.go(-1);</script>");
				}else{
					
					String SQL = "update bucket set title = ?, date = ?, cont = ? where writer = ? AND num = ?";
					
					pstmt = con.prepareStatement(SQL);
	
					pstmt.setString(1, btitle); 
					pstmt.setString(2, bdate); 
					pstmt.setString(3, bcontent);
					pstmt.setString(4, suserid);
					pstmt.setString(5, idx);
					
					pstmt.execute();
		
					pstmt.executeUpdate();
	%>		
	<script>
		alert("항목이 수정되었습니다.");
		opener.location.reload();
		location.href="bucket_view.jsp?idx=<%=idx%>";
	</script>
	<%	 
				pstmt.close();
				con.close();
			}		
	   }//세션끝		
//-------------------------------------------------------------------------------------------------------------------------------//
   %>
