<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@page import="java.util.*" import = "java.sql.*" %>
<html>
    <head>
	   <link rel= "stylesheet" type="text/css" href="sub_pg.css">
       <meta content="text/html; charset=UTF-8">
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
		
			String SQL = "select title,date,cont from checklist  where writer = ? AND num = ?";
		
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1,suserid);
			pstmt.setInt(2,idx);
			ResultSet rs = pstmt.executeQuery();

			if(rs.next()){

				String ctitle = rs.getString(1);
				String chdate = rs.getString(2);
				String chcontent = rs.getString(3);

			
 //-------------------------------------------------------------------------------------------------------------------------------// 
%>
<div class="wrap">
      <h3 class="header">CHECK LIST를 추가하세요</h3><br>
        <table>
		<form name="update_form" method="post" action="check_update_ok.jsp?idx=<%=idx%>"> <!--폼을통해전송-->
            <tr>
                <td>제목</td>
                <td><input type="text" name="check_title" maxlength="80" value="<%=ctitle%>"></td>
            </tr>
            <tr>
                <td>작성일시</td>
			    <td><input type="text" name="check_date" maxlength="80" value="<%=chdate%>"></td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea name="check_content" cols="80" rows="5"><%=chcontent%></textarea></td>
            </tr>
        </table>
        <br>
        <div align="center">
            <input type="submit" value="수정" onclick="location.href='check_update_ok.jsp">
            <input type="button" value="취소" onclick="location.href='check_li.jsp' ">
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