<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<%@page import="java.util.*" import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
    <head>
        <link rel= "stylesheet" type="text/css" href="sub_pg.css">

        <meta content="text/html; charset=UTF-8">
        <title>Scedule_Write</title>
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
			
			java.util.Calendar cal=java.util.Calendar.getInstance();
			int currentYear=cal.get(java.util.Calendar.YEAR); //현재 날짜 기억
			int currentMonth=cal.get(java.util.Calendar.MONTH);
			int currentDate=cal.get(java.util.Calendar.DATE);
			
  
%>
   <div class="wrap">
      <h3 class="header"><%=suserid%>님 "Hey!캘린더"에 일정을 기록하세요</h3><br>
       <form name="wirte_form" action="schedule_min_insert.jsp" method="post">
        <table>
            <tr>
                <td>제목</td>
                <td><input type="text" name="sch_title" maxlength="40" value=""></td>
            </tr>
            <tr>
                <td>기간</td>
                <td>
                  <input type="hidden" name="date">
                   <select name="sch_year">
                        <option><% out.print(currentYear);%></option>
                        <% 
                            for(int i=2000; i<=2020; i++){
                            out.print("<option>" + i + "</option>");
                            }
                        %>
                   </select>
                   <select name="sch_month">
                        <option><% out.print(currentMonth+1);%></option>
                        <% 
                            for(int i=1; i<=12; i++){
                            out.print("<option>" + i + "</option>");
                            }
                        %>
                   </select>
                   <select name="sch_day">
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
			<td>시간선택</td>
				<td>
					<select name="sch_start">
                        <option><% out.print("시작시간");%></option>
                        <% 
                            for(int i=5; i<=24; i++){
                            out.print("<option>" + i + "</option>");
                            }
                        %>                       
                   </select>시 -
				   <select name="sch_end">
                        <option><% out.print("끝나는시간");%></option>
                        <% 
                            for(int i=5; i<=24; i++){
                            out.print("<option>" + i + "</option>");
                            }
                        %>                       
                   </select>시&nbsp;&nbsp;(한 시간 단위로 설정)
				</td>				
			</tr>
            <tr>
                <td>알림 설정</td>
                <td>예<input type="radio" name="alarm" value="YES">
				&nbsp;&nbsp;아니오<input type="radio" name="alarm" value="NO">
				</td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea name="sch_content" cols="30" rows="5"></textarea></td>
            </tr>
        </table>
        <br>
        <div align="center">
            <input type="submit" value="저장">
            <input type="button" value="취소" onclick="window.close()">
        </div>    
    </form>

   </div><!--wrap--> 
   <% 
					
			con.close();

		}//-------------------------------------------------------------------------------------------------------------------------------//
   %>
 </body>
</html>