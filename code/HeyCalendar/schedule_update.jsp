<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<%@page import="java.util.*" import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
    <head>
        <link rel= "stylesheet" type="text/css" href="sub_pg.css">
        <meta content="text/html; charset=UTF-8">
        <title>Scedule_Update</title>
    </head>
<body>
<% //-------------------------------------------------------------------------------------------------------------------------------//
	//DB연결
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		
	 String connectionURL = "jdbc:sqlserver://localhost:1433;databaseName=CSR_cal;user=PPP;password=11";
	 Connection con = DriverManager.getConnection(connectionURL);
	
	   if(session.getAttribute("userid")==null){
		   out.print("<script>alert('로그인하세요');location.href='member/login_main.jsp'</script>");
	   }else{ 
			String suserid = (String)session.getAttribute("userid");//세션
			
			int idx = Integer.parseInt(request.getParameter("idx")); //글 번호 받아오기 copy

			PreparedStatement pstmt = null; //DB연결
		
			String SQL = "select title,alarm,year,month,day,cont,start_t,end_t  from schedule where writer = ? AND num = ?";
		
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
			
 //-------------------------------------------------------------------------------------------------------------------------------// 
%>
   <div class="wrap">
      <h3 class="header"><%=suserid%>님 "Hey!캘린더"에 일정을 기록하세요</h3><br>
        <table>
		<form name="update_form" method="post" action="schedule_update_ok.jsp?idx=<%=idx%>"> <!--폼을통해전송-->
            <tr>
                <td>제목</td>
                <td><input type="text" name="sch_title" maxlength="80" value="<%=stitle%>"></td>
            </tr>
			<tr>
                <td>날짜선택</td>
                <td>
                   <select name="sch_year">
                        <option><% out.print(syear);%></option>
                        <% 
                            for(int i=2000; i<=2020; i++){
                            out.print("<option>" + i + "</option>");
                            }
                        %>
                   </select>
                   <select name="sch_month">
                        <option><% out.print(smonth);%></option>
                        <% 
                            for(int i=1; i<=12; i++){
                            out.print("<option>" + i + "</option>");
                            }
                        %>
                   </select>
                   <select name="sch_day">
                        <option><% out.print(sday);%></option>
                        <% 
                            for(int i=1; i<=31; i++){
                            out.print("<option>" + i +"</option>");
                            }
                        %>                       
                   </select>
                </td>
            </tr>
			<tr>
			<td>시간선택</td>
				<td>
					<select name="sch_start">
                        <option><% out.print(time_start);%></option>
                        <% 
                            for(int i=5; i<=24; i++){
                            out.print("<option>" + i + "</option>");
                            }
                        %>                       
                   </select>시 - 
				   <select name="sch_end">
                        <option><% out.print(time_end);%></option>
                        <% 
                            for(int i=5; i<=24; i++){
                            out.print("<option>" + i + "</option>");
                            }
                        %>                       
                   </select>시&nbsp;&nbsp;(한 시간 단위로 설정)
				</td>				
			</tr>
            <tr>
                 <td>알림설정</td>&nbsp;
				 <td>&nbsp;&nbsp; 
                예<input type="radio" name="alarm"<%if(salarm.equals("YES")) out.print("checked");%> value="YES">
				&nbsp;&nbsp;아니오<input type="radio" name="alarm" <%if(salarm.equals("NO")) out.print("checked");%> value="NO">
				</td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea name="sch_content" cols="80" rows="5"><%=scontent%></textarea></td>
            </tr>
        </table>
        <br>
        <div align="center">
            <input type="submit" value="수정" onclick="location.href='schedule_update_ok.jsp">
            <input type="button" value="취소" onclick="window.open('calendar.jsp ', '_self', 'scrollbars=yes,resizable=yes');">
        </div>    
    </form>

   </div><!--wrap--> 

        <%	
				rs.close();
				pstmt.close(); 
				con.close();
		 }
   }
   //-------------------------------------------------------------------------------------------------------------------------------//
		 %>  

 </body>
</html>