<%@ page language="java" contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@page import="java.util.*" import = "java.sql.*" %>

<%//-------------------------------------------------------------------------------------------------------------------------------//
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		
		 String connectionURL = "jdbc:sqlserver://localhost:1433;databaseName=CSR_cal;user=PPP;password=11";
		Connection con = DriverManager.getConnection(connectionURL);
		
		PreparedStatement pstmt = null; //DB연결
		
		if(session.getAttribute("userid")==null){
       out.print("<script>alert('로그인하세요');location.href='member/login_main.jsp'</script>");
        }else{ 
            String suserid = (String)session.getAttribute("userid");//세션    
				
				String daily_emo = null; //기분나타내는변수
				int total = 0; //총 게시물 수
				int cpage=request.getParameter("pg") != null ? Integer.parseInt(request.getParameter("pg")) : 1; //현재페이지번호
				int pageSize  = 5; //한페이지에나타낼게시물수
				int pageBlock = 5; //페이지블럭사이즈
				int totalPage = 0; //총페이지수
				int EndNo = pageSize * cpage; //마지막페이지번호
				int StartNo = EndNo - pageSize; //페이지시작번호
				int start = (cpage-1)* pageSize; //게시물불러오는거시작위치
				
				String sqlCount = "select count(*) from daily where writer = ?";
				pstmt = con.prepareStatement(sqlCount);
				pstmt.setString(1,suserid);
				ResultSet rs = pstmt.executeQuery(); //총 게시물 수
				
				if(rs.next()){
					total = rs.getInt(1);
				}
				rs.close();
				out.print("총 게시물 : " +total + "개");
				String sqlList = "select title,date,emoji,num from daily where writer = ? order by num desc OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"; //작성자 일치하는 게시물 역순으로 정렬
				pstmt = con.prepareStatement(sqlList);
				pstmt.setString(1,suserid);		
				pstmt.setInt(2,start);
				pstmt.setInt(3,pageSize);
				rs = pstmt.executeQuery();   			
%>

<!DOCTYPE html>
<html>
    <head>
         <link rel= "stylesheet" type="text/css" href="sub_pg.css">      
        <meta content="text/html; charset=UTF-8">
        <title>Daily List</title>
    </head>
    <body>
        <div class="wrap">
        <h3 class="header">DAILY LIST를 확인하세요</h3><br>
            <table class="list_table">
                <tr>
                    <th class="title">제목</th>
                    <th class="date">작성일시</th>
					<th class="emoji">기분 </th>
					<th class="num">글번호</th>
                </tr>
 				<%if(total == 0){
				%>
						<tr>
							<td align="center">등록된 일기가 없습니다.</td>
						</tr>
				<%
				}else {
					while(rs.next()){
						
						String dtitle = rs.getString(1);
						String ddate = rs.getString(2);
						int demoji = rs.getInt(3);
						int idx = rs.getInt(4);


%>	
                <tr>					
                    <td align="center"><a href="daily_view.jsp?idx=<%=idx%>"><%=dtitle%></a></td>
                    <td align="center"><%=ddate%></td>
					 <td align="center"><img src = "../img/<%=demoji%>.jpg"></td>
					<td align="center"><%=idx%></td>					
                </tr>            		
<%
		
		}
		}
		rs.close();
		pstmt.close();
		con.close();
	
%>
        </table>
        <br>
            <div>
                <button type="button" onclick="location.href='daily_write.jsp' ">일기 추가</button>
                <input type="button" value="취소" onclick="location.href='../calendar.jsp' ">
            </div> 
  <br>
	  <%
	totalPage = ((total - 1) / pageSize) + 1;
	int prevPage = (int)Math.floor((cpage - 1) / pageBlock) * pageBlock;
	int nextPage = prevPage + pageBlock + 1;
	%>
<div><!--pagination-->
	<% if(prevPage > 0) { %>
	<a href="daily_li?pg=<%= prevPage %>">이전<%= pageBlock %>개</a>
	<% } %>
	<%
	for(int i = 1 + prevPage; i < nextPage && i <= totalPage; i++)
	{
	 if(i == cpage) // 현재 페이지는 링크가 걸리지 않음
	 {
	%>
	 [<%= i %>]
	<%
	 }
	 else // 그렇지 않다면.. 링크를 걸어야쥐..
	 {
	%>
	 [<a href="daily_li.jsp?pg=<%= i %>"><%= i %></a>]
	<%
	 }
	}
	%>
	<% if(totalPage >= nextPage) { %>
	<a href="daily_li.jsp?pg=<%= nextPage %>">다음<%= pageBlock %>개</a>
	<% } %>
</div><!--pagination-->
 <% } %>
        <!------------------------------------------sessionelseEND---------------------------------------------------------->      
        </div><!--wrap-->
    </body>
</html>