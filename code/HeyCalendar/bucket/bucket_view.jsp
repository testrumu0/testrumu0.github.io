<%@ page language="java" contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@page import="java.util.*" import = "java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel= "stylesheet" type="text/css" href="sub_pg.css"> 
        <title>Bucket_view</title>
    </head>
<body>
<%//-------------------------------------------------------------------------------------------------------------------------------//
		//DB연결
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			
		 String connectionURL = "jdbc:sqlserver://localhost:1433;databaseName=CSR_cal;user=PPP;password=11";
		 
		 Connection con = DriverManager.getConnection(connectionURL);
			
		int idx = Integer.parseInt(request.getParameter("idx")); //글 번호 받아오기 copy

		PreparedStatement pstmt = null;

		if(session.getAttribute("userid")==null){
		out.print("<script>alert('로그인하세요');location.href='member/login_main.jsp'</script>");
		}else{ /*사용자와 글번호가 같은 글 불러오기*/
			String suserid = (String)session.getAttribute("userid");
			
			String SQL = "select title,date,cont from bucket where writer = ? AND num = ?";
				pstmt = con.prepareStatement(SQL);
				pstmt.setString(1,suserid);
				pstmt.setInt(2,idx);
				ResultSet rs = pstmt.executeQuery();

			 if(rs.next()){

					String btitle = rs.getString(1);                           
					String bdate = rs.getString(2);                        
					String bcontent = rs.getString(3);

  %>
   <div class="wrap">
    <h3 class="header">BUCKET LIST를 확인하세요</h3><br>
        <table>
		<form name="delete_form" method="post" action="bucket_delete.jsp?idx=<%=idx%>">
            <tr>
                <th>제목</th>
                <td>            
                <%=btitle%>
                </td>
            </tr>
            <tr>
                <th>작성일시</th>
                <td>
                <%=bdate%>
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                <%=bcontent%>
                </td>
            </tr>
			</form>
        </table>
    <br>
   <div align ="center">
    <input type="button" value="목록 보기" onclick="location.href='bucket_li.jsp' "><!--llist로-->
    <input type="button" value="수정" onclick="location.href='bucket_update.jsp?idx=<%=idx%>' ">
    <input type="button" value="삭제" onclick="location.href='bucket_delete.jsp?idx=<%=idx%>' "> 
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