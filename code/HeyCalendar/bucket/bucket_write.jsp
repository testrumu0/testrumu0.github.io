<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<%@page import="java.util.*" import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
    <head>
        <link rel= "stylesheet" type="text/css" href="sub_pg.css">
        <meta content="text/html; charset=UTF-8">
        <title>Bucket_Write</title>
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
      <h3 class="header">BUCKET LIST를 추가하세요</h3><br>
      <form action="bucket_insert.jsp" method="post">
       <table>
           <tr>
              <td >제목</td>
              <td><input type="text" name="bk_title" maxlength="10" value=""></td>
           </tr>
           <tr>
                <td>작성일시</td>
                <td>
                  <input type="hidden" name="date">
                   <select name="bk_year">
                        <option><% out.print(currentYear);%></option>
                        <% 
                            for(int i=2000; i<=2020; i++){
                            out.print("<option>" + i + "</option>");
                            }
                        %>
                   </select>
                   <select name="bk_month">
                        <option><% out.print(currentMonth+1);%></option>
                        <% 
                            for(int i=1; i<=12; i++){
                            out.print("<option>" + i + "</option>");
                            }
                        %>
                   </select>
                   <select name="bk_day">
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
              <td >내용</td>
              <td><textarea name="bk_content" cols="19" rows="5"></textarea></td>
           </tr>
       </table>
       <br>
          <div align="center">
                 <input type="submit"  value="저장">
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