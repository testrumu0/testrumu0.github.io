<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.*" import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %> <!--인코딩-->

<% 
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		
		 String connectionURL = "jdbc:sqlserver://localhost:1433;databaseName=CSR_cal;user=PPP;password=11";
		Connection con = DriverManager.getConnection(connectionURL);
		
		Statement stmt = con.createStatement();
		
		 //입력받은 값을 변수에 저장
		 String suserid = request.getParameter("userid"); 
		 String suserpw = request.getParameter("userpw");
		 String susernm = request.getParameter("usernm");           
		 String suserph = request.getParameter("userph");
		 
		 //ID 중복체크
		  String SQL = "select count(*) cnt from member where userid = '"+suserid+"'";
		  ResultSet rs = stmt.executeQuery(SQL);
		  rs.next();
		 
		 if(rs != null){
			 if(rs.getInt("cnt")>0){
				 out.print("<script>alert('이미 사용하고 있는 아이디입니다.');history.back();</script>");
			 }else if(suserid.equals("")||suserpw.equals("")||susernm.equals("")||suserph.equals("")){
				 out.print("<script>alert('모든 항목을 입력하세요.');history.back();</script>");
			 }
			 else{
				SQL = "insert into member (userid,userpw,usernm,userph) values (";
				SQL += "'" + suserid + "','" + suserpw + "','" +susernm + "','" +suserph +"')";

				 stmt.executeUpdate(SQL);
				 
				 stmt.close();
				 con.close();		
				
				out.print("<script>alert('가입이 완료되었습니다.');location.href='login_main.jsp'</script>");
			 }
		 }

		 

		 
	%>	 
