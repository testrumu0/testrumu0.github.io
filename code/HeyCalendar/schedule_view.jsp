<%@ page language="java" contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@page import="java.util.*" import = "java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel= "stylesheet" type="text/css" href="sub_pg.css"> 
        <title>Schedule_view</title>
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
			
			String SQL = "select title,alarm,year,month,day,cont,start_t,end_t from schedule where writer = ? AND num = ?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1,suserid);
			pstmt.setInt(2,idx);
			ResultSet rs = pstmt.executeQuery(); 

			 if(rs.next()){

					String stitle = rs.getString(1);
					String salarm = rs.getString(2);
					int syear = rs.getInt(3);
					int smonth = rs.getInt(4);
					int sday = rs.getInt(5);
					String scontent = rs.getString(6);
					int time_start = rs.getInt(7);
					int time_end = rs.getInt(8);

%>
   <div class="wrap">
     <h3 class="header">기록한 일정을 확인하세요</h3><br>
        <table class="view_table">
		<form name="delete_form" method="post" action="schedule_delete.jsp?idx=<%=idx%>">
		     <tr>
                <th>글 번호</th>
                <td>
                <%=idx%>
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td>
                <%=stitle%>
                </td>
            </tr>
			<tr>
                <th>알림</th>
                <td>
                <%=salarm%>
                </td>
            </tr>
            <tr>
                <th>기간</th>
                <td>
                <%=syear+"."+smonth+"."+sday%>
                </td>
            </tr>
			<tr>
                <th>시간</th>
                <td>
                <%=time_start + "시 - " + time_end + "시"%>
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                <%=scontent%>
                </td>
            </tr>
			</form>
        </table>

<br>
   <div align ="center">
    <input type="button" value="목록 보기" onclick="location.href='schedule_li.jsp' "><!--llist로-->
    <input type="button" value="수정" onclick="location.href='schedule_update.jsp?idx=<%=idx%>' ">
    <input type="button" value="삭제" onclick="location.href='schedule_delete.jsp?idx=<%=idx%>' "> 
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