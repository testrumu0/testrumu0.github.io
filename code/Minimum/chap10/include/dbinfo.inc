<%
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	String connectionURL = "jdbc:sqlserver://localhost:1433;databaseName=CSR_Book; user=CSR; password=00";
	Connection con = DriverManager.getConnection(connectionURL);
%>