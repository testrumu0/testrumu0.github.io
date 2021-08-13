<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.Date"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@page import="java.util.*" import = "java.sql.*" %>
<%@ page import="java.text.*"%>
<html>
    <head>	
        <meta content="text/html; charset=UTF-8">
		 <link rel= "stylesheet" type="text/css" href="sub_pg.css"> 
        <title>MY GOAL</title>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
    </head>
<body>
<%
				//DB연결
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				
			 String connectionURL = "jdbc:sqlserver://localhost:1433;databaseName=CSR_cal;user=PPP;password=11";
			 Connection con = DriverManager.getConnection(connectionURL);
				
		    PreparedStatement pstmt = null;
			
			if(session.getAttribute("userid")==null){
			  out.print("<script>alert('로그인하세요');location.href='member/login_main.jsp'</script>");
			 }else{ 
				String suserid = (String)session.getAttribute("userid");//세션  
			 
				 int total = 0; //총 게시물 수
				 int count = 0;
				 float rate = 0;
				 DecimalFormat format = new DecimalFormat("0.0");
				 
				String sqlCount = "select count(*) from checklist where writer = ?";
				pstmt = con.prepareStatement(sqlCount);
				pstmt.setString(1,suserid);
				ResultSet rs = pstmt.executeQuery(); //총 게시물 수
				
				if(rs.next()){
					total = rs.getInt(1);
				}
				rs.close();
				
				sqlCount = "select count(goal) from checklist where writer = ?";
				pstmt = con.prepareStatement(sqlCount);
				pstmt.setString(1,suserid);
				rs = pstmt.executeQuery();  
				
				if(total == 0){
					out.print("등록된 항목이 없습니다.");
				}else {
					while(rs.next()){	
						count = rs.getInt(1);
					}
				}
				rs.close();
				
				rate=((float)count/total*100);
%>
  <div class="wrap">
     <h3 class="header"><%=suserid%>님의 달성율</h3><br>
	
	<div style = "text-align:center; margin:0 auto;">
			총 <%=total%>개 중 <%=count%>개 완료 "달성율<%=format.format(rate)%>%"
	</div>
	<br>
	<div align="center">
		<script src="js/chart/Chart.js"></script>
			<canvas id="myChart" width="800" height="500"></canvas>
			<script>
			var ctx = document.getElementById("myChart");
			var myChart = new Chart(ctx, {
				type: 'bar',
				data: {
					labels: ['total','checked'],
					datasets: [{
						label: 'MY GOALS',
						data: [<%=total%>,<%=count%>],
						backgroundColor: [
							'rgba(255, 99, 132, 0.2)',
							'rgba(54, 162, 235, 0.2)'

						],
						borderColor: [
							'rgba(255,99,132,1)',
							'rgba(54, 162, 235, 1)'

						],
						borderWidth: 1
					}]
				},
				options: { responsive: false,
					scales: {
						yAxes: [{
							ticks: {
								beginAtZero:true
							}
						}]
					}
				}
			});
			</script>
	</div>	

  </div><!--wrap--> 
	<%				
			pstmt.close();
			con.close();
	}//세션

	%>
</body>
</html>