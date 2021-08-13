<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<html>
    <head>
	   <link rel= "stylesheet" type="text/css" href="sub_pg.css">
       <meta content="text/html; charset=UTF-8">
    </head>
<body>
<%
    String goal = request.getParameter("goal");
    String writer = request.getParameter("writer");
    String num = request.getParameter("num");

    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    try ( 
			 Connection con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=CSR_cal;user=PPP;password=11");
			Statement stmt = con.createStatement();
    ) {
    	
    	if (goal == null || goal.length() == 0) {
    	    stmt.executeUpdate(String.format("update bucket set goal=NULL where writer='%s' and num=%s",
    		    	writer, num
		    ));
    	} else {
    	    stmt.executeUpdate(String.format("update bucket set goal='%s' where writer='%s' and num=%s",
    		    	goal, writer, num
		    ));
    	}
    } catch(Exception e) {
        e.printStackTrace();
    }
%>

</body>
</html>