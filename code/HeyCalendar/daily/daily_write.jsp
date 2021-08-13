<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<%@page import="java.util.*" import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
    <head>
        <link rel= "stylesheet" type="text/css" href="sub_pg.css">

        <meta content="text/html; charset=UTF-8">
        <title>Daily_Write</title>
    </head>
<body>
<% //-------------------------------------------------------------------------------------------------------------------------------//
	//DB연결
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		
	 String connectionURL = "jdbc:sqlserver://localhost:1433;databaseName=CSR_cal;user=PPP;password=11";
	 Connection con = DriverManager.getConnection(connectionURL);

   if(session.getAttribute("userid")==null){
       out.print("<script>alert('로그인하세요');location.href='../member/login_main.jsp'</script>");
   }else{ 
	
			String suserid = (String)session.getAttribute("userid");//세션

			java.util.Calendar cal=java.util.Calendar.getInstance();
			int currentYear=cal.get(java.util.Calendar.YEAR); //현재 날짜 기억
			int currentMonth=cal.get(java.util.Calendar.MONTH);
			int currentDate=cal.get(java.util.Calendar.DATE);
			
  
%>
   <div class="wrap">
      <h3 class="header">"Hey!캘린더"에 일기를 기록하세요</h3><br>
       <form name="wirte_daily" action="daily_insert.jsp" method="post">
       <!--action에서 insert,update경로 제어-->
        <table>
            <tr>
                <td>제목</td>
                <td><input type="text" name="daily_title" maxlength="80" value=""></td>
            </tr>
            <tr>
                <td>작성일시</td>
                <td>
                  <input type="hidden" name="date">
                   <select name="daily_year">
                        <option><% out.print(currentYear);%></option>
                        <% 
                            for(int i=2000; i<=2020; i++){
                            out.print("<option>" + i + "</option>");
                            }
                        %>
                   </select>
                   <select name="daily_month">
                        <option><% out.print(currentMonth+1);%></option>
                        <% 
                            for(int i=1; i<=12; i++){
                            out.print("<option>" + i + "</option>");
                            }
                        %>
                   </select>
                   <select name="daily_day">
                        <option><% out.print(currentDate);%></option>
                        <% 
                            for(int i=1; i<=31; i++){
                            out.print("<option>" + i + "</option>");
                            }
                        %>            
                   </select>
                </td>
            </tr>
            <tr>
                <td>기분</td>
                <td>
                    <input type="radio" name="emoji" value="1" checked>즐거움
                    <input type="radio" name="emoji" value="2" >슬픔
                    <input type="radio" name="emoji" value="3" >화남
                    <input type="radio" name="emoji" value="4" >무기력
                    <input type="radio" name="emoji" value="5" >보통
                </td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea name="daily_content" cols="80" rows="5"></textarea></td>
            </tr>
        </table>
        <br>
        <div align="center">
            <input type="submit" value="저장">
            <input type="button" value="취소" onclick="location.href='daily_li.jsp' ">
        </div>    
    </form>

   </div><!--wrap-->    
   <% 
					
			con.close();

		}//-------------------------------------------------------------------------------------------------------------------------------//
   %>
</body>
</html>