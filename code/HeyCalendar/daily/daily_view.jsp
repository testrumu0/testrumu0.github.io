<%@ page language="java" contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@page import="java.util.*" import = "java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel= "stylesheet" type="text/css" href="sub_pg.css"> 
        <title>daily_view볼수만있음</title>
    </head>
<body>
<%//-------------------------------------------------------------------------------------------------------------------------------//
		//DB연결
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			
		 String connectionURL = "jdbc:sqlserver://localhost:1433;databaseName=CSR_cal;user=PPP;password=11";
		 
		 Connection con = DriverManager.getConnection(connectionURL);
			
		int idx = Integer.parseInt(request.getParameter("idx")); //글 번호 받아오기 copy
		
		String daily_emo = null; //기분나타내는변수
		
		PreparedStatement pstmt = null;
		
		if(session.getAttribute("userid")==null){
			out.print("<script>alert('로그인하세요');location.href='member/login_main.jsp'</script>");
		}else{ /*사용자와 글번호가 같은 글 불러오기*/			
			String suserid = (String)session.getAttribute("userid");
			
			String SQL = "select title,date,emoji,cont from daily where writer = ? AND num = ?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1,suserid);
			pstmt.setInt(2,idx);
			ResultSet rs = pstmt.executeQuery(); 

			 if(rs.next()){

					String dtitle = rs.getString(1);
					String ddate = rs.getString(2);
					int demoji = rs.getInt(3);
					String dcontent = rs.getString(4);

  %>
   <div class="wrap">
     <h3 class="header">기록한 일기를 확인하세요</h3><br>
        <table class="view_table">
		<form name="delete_form" method="post" action="daily_delete.jsp?idx=<%=idx%>">
            <tr>
                <th>제목</th>
                <td>           
                <%=dtitle%>
                </td>
            </tr>
            <tr>
                <th>작성일시</th>
                <td>
                <%=ddate%>
                </td>
            </tr>
			<tr>
                <th>기분</th>
                <td>
                <img src = "../img/<%=demoji%>.jpg">
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                <%=dcontent%>
                </td>
            </tr>
			</form>
        </table>

<br>
   <div align ="center">
    <input type="button" value="목록 보기" onclick="location.href='daily_li.jsp' "><!--llist로-->
    <input type="button" value="수정" onclick="location.href='daily_update.jsp?idx=<%=idx%>' ">
    <input type="button" value="삭제" onclick="location.href='daily_delete.jsp?idx=<%=idx%>' "> 
   </div>
  </div><!--wrap-->  
 <%	
				rs.close();
				pstmt.close(); 
				con.close();
			 }
		 }//-------------------------------------------------------------------------------------------------------------------------------//
		 %>    
 </body>
</html>