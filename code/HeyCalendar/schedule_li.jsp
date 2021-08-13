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
            
			int total = 0; //총 게시물 수
			int cpage=request.getParameter("pg") != null ? Integer.parseInt(request.getParameter("pg")) : 1; //현재페이지번호
			int pageSize  = 5; //한페이지에나타낼게시물수
			int pageBlock = 5; //페이지블럭사이즈
			int totalPage = 0; //총페이지수
			int EndNo = pageSize * cpage; //마지막페이지번호
			int StartNo = EndNo - pageSize; //페이지시작번호
			int start = (cpage-1)* pageSize; //게시물불러오는거시작위치
            
            String sqlCount = "select count(*) from schedule  where writer = ?";
            pstmt = con.prepareStatement(sqlCount);
            pstmt.setString(1,suserid);
            ResultSet rs = pstmt.executeQuery(); 
            
            if(rs.next()){
                total = rs.getInt(1);
            }
            rs.close();
            out.print("총 게시물 : " +total + "개");
            	   
%>

<!DOCTYPE html>
<html>
    <head>
         <link rel= "stylesheet" type="text/css" href="sub_pg.css">      
        <meta content="text/html; charset=UTF-8">
        <title>Scedule List</title>

    </head>
   
   <body>
      <div class="wrap">
		<h3 class="header">기록한 일정을 확인하세요</h3><br>
	 
	 <aside style="float: left; width: 200px;font-size: 16px;">
<!--------------------copy--jsp캘린더코드카피---------------------------------------->
  <%
	/*Calendar코드*/
	 java.util.Calendar cal=java.util.Calendar.getInstance(); //Calendar객체 cal생성
	 
	 int currentYear=cal.get(java.util.Calendar.YEAR); //현재 날짜 기억
	 int currentMonth=cal.get(java.util.Calendar.MONTH);
	 int currentDate=cal.get(java.util.Calendar.DATE);
	 

	 String Year=request.getParameter("year"); //나타내고자 하는 날짜
	 String Month=request.getParameter("month");
	 int year, month;

	 if(Year == null && Month == null){ //처음 호출했을 때 현재 날짜 표시
		 year=currentYear;
		 month=currentMonth;
	 }else { //나타내고자 하는 날짜를 숫자로 변환
		year=Integer.parseInt(Year);
		month=Integer.parseInt(Month);
		if(month<0) { month=11; year=year-1; } //1월부터 12월까지 범위 지정.
		if(month>11) { month=0; year=year+1; }
	 }
 
  %>
  <!------------------------------Calendarcopyend------------------------------------------------->
    <body>
		<div class="minical">
			<div class="thead">
					<div align="center" style="color:#fff;">
					<a href="schedule_li.jsp?year=<%=year-1%>&amp;month=<%=month%>" target="_self">◀</a>
					<% out.print(year); %>년
					<a href="schedule_li.jsp?year=<%out.print(year+1);%>&month=<%out.print(month);%>">▶</a>
						
						&nbsp;&nbsp;
					<a href="schedule_li.jsp?year=<%out.print(year);%>&month=<%out.print(month-1);%>">◀</a>
					<% out.print(month+1); %>월
					<a href="schedule_li.jsp?year=<%out.print(year);%>&month=<%out.print(month+1);%>">▶</a>
				</div>
			</div>
			
		<table>
				  <tr>
					  <td id="red">S</td>
					  <td>M</td>
					  <td>T</td>
					  <td>W</td>
					  <td>T</td>
					  <td>F</td>
					 <td id="blue">S</td>
				  </tr>           
<!-----------------------copy---------------------------------------------------->
<!-- 달력 부분 -->		   
			   <tr>
			   
	<%	
           cal.set(year, month, 1); //현재 날짜를 현재 월의 1일로 설정
           int startDay=cal.get(java.util.Calendar.DAY_OF_WEEK); //현재날짜(1일)의 요일
           int end=cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); //이 달의 끝나는 날
           int br=0; //7일마다 줄 바꾸기
		   
		   String color="";
		   String bgcolor="";
           
           for(int i=0; i<(startDay-1); i++){ //빈칸출력
			out.print("<td>");
            out.println("&nbsp;</td>");
            br++;
        		if((br%7)==0) {
        		 out.println("<br>");//줄바꿈
        		}
           }
		   
           for(int i=1; i<=end; i++) { //i날짜출력
%>						
			<td style="color:<%=color%>; background:<%=bgcolor%>;" >				
<%		   											
				if(currentYear==year&&currentMonth+1==month+1&&currentDate-1==i){	//error 매월1일을 못 맞춤. -1을 안하면 하루가 밀림.
					out.println(i);
					color="#fff";
					bgcolor="#b7a8d4";					
				}else{
					out.println(i);
					color="#000";
					bgcolor="none";
				}

			out.println("</td>");
			br++;
				  
		  if((br%7)==0 && i!=end) {
        		 out.println("</tr><tr>");
        		}
           }//forEND
           while((br++)%7!=0) //말일 이후 빈칸출력
            out.println("<td>&nbsp;</td>"); 
%>
<!-------------------------------copy------------------------------->
			</tr>
         </table>            
	</div><!--minical-->
</aside>
   
<div class="cont2">	
		   <table class="list_table" align="center">                   
                <tr>
                    <th class="title">제목</th>
                    <th class="alarm">알림설정 </th>
                    <th class="date">기간</th>
					<th class="time">시간</th>
                    <th class="num">글번호</th>
                </tr>

                <%
                   if(total == 0){
                %>
                        <tr>
                            <td align="center">등록된 일정이 없습니다.</td>
                        </tr>
                <%
                }else {
					            
					String sqlList = "select title,alarm,year,month,day,writer,num,start_t,end_t from schedule where writer = ? order by num desc OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"; //나타날게시물만큼떼오고역순으로 정렬
					pstmt = con.prepareStatement(sqlList);
					pstmt.setString(1,suserid);
					pstmt.setInt(2,start);
					pstmt.setInt(3,pageSize);
					rs = pstmt.executeQuery();      
					
                    while(rs.next()){
                        
                        String stitle = rs.getString(1);
                        String salarm = rs.getString(2);
                        int syear = rs.getInt(3);
                        int smonth = rs.getInt(4);
                        int sday = rs.getInt(5);
                        int idx = rs.getInt(7);
						int time_start = rs.getInt(8);
						int time_end = rs.getInt(9);
                %> 
						
                <tr>
                    
                    <td align="center"><a href="schedule_view.jsp?idx=<%=idx%>"><%=stitle%></a></td>
                    <td align="center"><%=salarm%></td>
                    <td align="center"><%=syear+"."+smonth+"."+sday%></td>
					<td align="center"><%=time_start+"시 - "+ time_end%></td>
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
	</div><!--cont2-->
        <br><br><br>
            <div>
                <button type="button" onclick="location.href='schedule_write.jsp' ">일정 추가</button>
                <input type="button" value="취소" onclick="location.href='calendar.jsp' ">
            </div> 
		<br>
<!-----------------------------pagenatione---copy------------------------------------------------>		
	  <%
	totalPage = ((total - 1) / pageSize) + 1;
	int prevPage = (int)Math.floor((cpage - 1) / pageBlock) * pageBlock;
	int nextPage = prevPage + pageBlock + 1;
	%>
<div><!--pagination-->
	<% if(prevPage > 0) { %>
	<a href="schedule_li?pg=<%= prevPage %>">이전<%= pageBlock %>개</a>
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
	 else // 그렇지 않다면 링크를 건다
	 {
	%>
	 [<a href="schedule_li.jsp?pg=<%= i %>"><%= i %></a>]
	<%
	 }
	}
	%>
	<% if(totalPage >= nextPage) { %>
	<a href="schedule_li.jsp?pg=<%= nextPage %>">다음<%= pageBlock %>개</a>
	<% } %>
</div>
<!----------------------------------pagination----copyEND------------------------------------------------>
 <% } %>
        <!------------------------------------------sessionEND---------------------------------------------------------->
       </div><!--wrap-->

    </body>
</html>