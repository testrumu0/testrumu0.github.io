<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@page import="java.util.*" import = "java.sql.*" %>
<html>
    <head>
	 <link rel= "stylesheet" type="text/css" href="sub_pg.css">
       <meta content="text/html; charset=UTF-8">
	   <title>Daily_Update</title>
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
			
			int idx = Integer.parseInt(request.getParameter("idx")); //글 번호 받아오기 copy
			String daily_emo = null;
			
			PreparedStatement pstmt = null; //DB연결
		
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
	
 //-------------------------------------------------------------------------------------------------------------------------------// 
%>
 <div class="wrap">
      <h3 class="header"><%=suserid%>님 "Hey!캘린더"에 일기를 기록하세요</h3><br>
        <table>
		<form name="update_form" method="post" action="daily_update_ok.jsp?idx=<%=idx%>"> <!--폼을통해전송-->
            <tr>
                <td>제목</td>
                <td><input type="text" name="daily_title" maxlength="80" value="<%=dtitle%>"></td>
            </tr>
            <tr>
                <td>작성일시</td>
			    <td><input type="text" name="daily_date" maxlength="80" value="<%=ddate%>"></td>
            </tr>
            <tr>
                 <td>기분</td>&nbsp;
				 <td><img src = "../img/<%=demoji%>.jpg">&nbsp;&nbsp;
                    <input type="radio" name="emoji" value="1" >즐거움
                    <input type="radio" name="emoji" value="2">슬픔
                    <input type="radio" name="emoji" value="3">화남
                    <input type="radio" name="emoji" value="4">무기력
                    <input type="radio" name="emoji" value="5">보통
				</td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea name="daily_content" cols="80" rows="5"><%=dcontent%></textarea></td>
            </tr>
        </table>
        <br>
        <div align="center">
            <input type="submit" value="수정" onclick="location.href='daily_update_ok.jsp">
            <input type="button" value="취소" onclick="location.href='daily_li.jsp' ">
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