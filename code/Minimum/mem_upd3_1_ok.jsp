<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.*" import = "java.sql.*" %>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<% request.setCharacterEncoding("utf-8"); %> <!--인코딩-->

<!doctype html>
<% 
		String realFolder = "";
		String saveFolder = "/chap11/mem_image";
		String encType = "utf-8";
		
		int sizeLimit = 10*1024*1024;
		realFolder = application.getRealPath(saveFolder);
		MultipartRequest multi = new MultipartRequest(request, realFolder, sizeLimit, encType);
		
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		
		String connectionURL = "jdbc:sqlserver://localhost:1433;databaseName=CSR_Book; user=CSR; password=00";
		Connection con = DriverManager.getConnection(connectionURL);
		
		Statement stmt = con.createStatement();
		
		 String suserid = multi.getParameter("userid");
		 String susernm = multi.getParameter("usernm");
		 String spasswd = multi.getParameter("passwd");
		 String sjumin  =  multi.getParameter("jumin1") + request.getParameter("jumin2");
		 String smailrcv = multi.getParameter("mailrcv");
		 if(smailrcv != null && smailrcv.equals("on") )
			 smailrcv = "Y";
		 else
			 smailrcv = "N";
		 String sgender = multi.getParameter("gender");
		 String sjob = multi.getParameter("job");
		 String sintro = multi.getParameter("intro").replace("\r\n","<br>");
		 String fileName = multi.getFilesystemName("pict");
		 
		 String SQL = "update members set  ";
		 SQL  = SQL+ "usernm = " + "'" + susernm + "', ";
		 SQL  = SQL+ "jumin = " + "'" + sjumin + "', ";
		 SQL  = SQL+ "mailrcv = " + "'" + smailrcv + "', ";
		 SQL  = SQL+ "gender = " + "'" + sgender + "', ";
		 SQL  = SQL+ "jobcd = " + "'" + sjob + "', ";
		 if(fileName != null) SQL = SQL + "pict = " + "'" + fileName + "', ";
		 SQL  = SQL+ "intro = " + "'" + sintro + "' ";
		 SQL  = SQL+ "where userid = '" + suserid +"' and passwd = '" + spasswd + "'";

		 int cnt  = stmt.executeUpdate(SQL);
		
		stmt.close();
		 con.close();
		 
		 if(cnt>0){
			 out.println("<script language=javascript>");
			  out.println("alert('변경이 완료 되었습니다');");
			  out.println("</script>");
		 }else{
			 out.println("<script language=javascript>");
			  out.println("alert('변경하지 못하였습니다');");
			  out.println("</script>");
		 }
		 
	%>	 
<html>
    <head>
        <meta charset="utf-8">
        <title>회원가입</title>
    </head>

    <body>
			 
			 가입이 완료 되었습니다.

    </body>
</html>