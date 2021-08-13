<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*" %>
<% request.setCharacterEncoding("utf-8");%>
<%@page import="java.util.*" import = "java.sql.*" %>

<!DOCTYPE html>
<html>
 <head>
  <link rel= "stylesheet" href="common.css" type="text/css" >
  <meta content="text/html; charset=UTF-8">
   <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>	
    <title>Hey!Calendar</title>
 </head>
<body>
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
<% 
	  //DB연결
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		
	 String connectionURL = "jdbc:sqlserver://localhost:1433;databaseName=CSR_cal;user=PPP;password=11";
	 
	 Connection con = DriverManager.getConnection(connectionURL);
	  
	 PreparedStatement pstmt = null;
	 ResultSet rs = null;//결과값
	 String SQL=null;//쿼리문

	   if(session.getAttribute("userid")==null){
		   out.print("<script>alert('로그인하세요');location.href='member/login_main.jsp'</script>");
	   }else{//세션	
				String suserid = (String)session.getAttribute("userid");		   
%>

  <div id="wrap">
     <div id="logo">
         <h2>"HEY!CALANDER"</h2>
           <form action="logout.jsp" method="post">
                <div id="user">
                   <%
                      out.print(suserid + "님 환영합니다!");
                      out.print("<a href='member/logout.jsp'>&nbsp;&nbsp;로그아웃</a>");
                   %>
                </div>
           </form>
     </div>
   
   <aside id="side">
      <nav>
        <div class="tab">
          <ul>
            <li><a href="weekly.jsp">Weekly</a></li>
            <li>/</li>
            <li><a href="calendar.jsp">Monthly</a></li>
          </ul>
        </div>	

    <script>//[출처] Javascript : alert 확인/취소 창 구현하기|작성자 거셩
		function delChk(){
		if (confirm("정말 삭제하시겠습니까??")){    //확인
			 location.href="check/check_min_del.jsp";
		 }else{   //취소
			 document.write("취소");
			 window.close();
			}
		}
	</script>
	  
	  <div id="check" class="clearfix"> 
            <ul>
              <a href onclick="window.open('check/check_li.jsp','CHECK LIST','width=800,height=400,location=no,status=no,scrollbars=yes');">
			  <h4>CHECK LIST</h4></a>
              <li class="btn">
              <button onclick="window.open('check/check_write.jsp','CHECK LIST','width=800,height=400,location=no,status=no,scrollbars=yes');">+</button>
              <!--CHECK LIST추가-->
              <button onclick="delChk();">-</button>
              <!--checklist삭제-->
              </li>			  
			 <%
			  		SQL = "select top 5 * from checklist  where writer = ? order by num desc"; //체크리스트 출력,출력갯수제한
						pstmt = con.prepareStatement(SQL);
						pstmt.setString(1,suserid);
						rs = pstmt.executeQuery(); 
			  
					while(rs.next()){
						String ctitle = rs.getString("title");
						String cidx = Integer.toString(rs.getInt("num"));
						String goal = rs.getString("goal"); 
						String checked = (goal == null || goal.length() == 0) ? "" : " checked";
			  %>
			  <li>	
				   <input type="checkbox" name = "chkbox" value="<%=cidx%>"<%=checked%>>
				   <a href onclick="window.open('check/check_view.jsp?idx=<%=cidx%>','CHECK LIST','width=800,height=400,location=no,status=no,scrollbars=yes');">
				   <%=ctitle%>
				   </a>				  
			  </li>         
			<%			
					}
				rs.close();				
			%>
				 <script>
					function goAjax(num, goal) {
						$.ajax({
							url:'rate_update.jsp', //request 보낼 서버의 경로
							type:'post', // 메소드(get, post)
							data:{writer: '<%=suserid%>', num:num, goal:goal}, //보낼 데이터
							success: function(data) {
								//서버로부터 정상적으로 응답이 왔을 때 실행
							},
							error: function(err) {
								//서버로부터 응답이 정상적으로 처리되지 못햇을 때 실행
							}
						});
					}
					
					$(document).ready(function() { 
						$('input[name=chkbox]').on('click', function() { 
							var goal = null;
							if ( $(this).prop('checked') ) { 
								goal = $(this).val();
							} 
							goAjax($(this).val(), goal);
						}); 
					});
				</script>
			</ul>
       </div>
	   
	   <div id="goal" class="clearfix">
		    <a href onclick="window.open('rate_view.jsp');">
            <h4>&nbsp;&nbsp;MY GOAL</h4></a>
	   </div>
	
	
	    <script>//[출처] Javascript : alert 확인/취소 창 구현하기|작성자 거셩
		function delBuk(){
		if (confirm("정말 삭제하시겠습니까??")){    //확인
			 location.href="bucket/bucket_min_del.jsp";
		 }else{   //취소
			 document.write("취소");
			 window.close();
			}
		}
	</script>
	   
	   <div id="bucket" class="clearfix">        
            <ul>
              <a href onclick="window.open('bucket/bucket_li.jsp','BUCKET LIST','width=800,height=400,location=no,status=no,scrollbars=yes');">
              <h4>BUCKET LIST</h4></a>
              <li class="btn">
              <button onclick="window.open('bucket/bucket_write.jsp','BUCKET WRITE','width=800,height=400,location=no,status=no,scrollbars=yes');">+</button>
              <!--BUCKET LIST추가-->
             <button onclick="delBuk();">-</button>
              <!--BUCKET LIST삭제-->
              </li>

			 <%
			  		SQL = "select top 5 * from bucket  where writer = ? order by num desc"; //체크리스트 출력,출력갯수제한
						pstmt = con.prepareStatement(SQL);
						pstmt.setString(1,suserid);
						rs = pstmt.executeQuery(); 
			  
					while(rs.next()){	
						String btitle = rs.getString("title");
						int bidx = rs.getInt("num");
						String goal = rs.getString("goal"); 
						String checked = (goal == null || goal.length() == 0) ? "" : " checked";
			  %>

			<li>
			  <input type="checkbox" name="buckbox" value="<%=bidx%>"<%=checked%>>
			  <a href onclick="window.open('bucket/bucket_view.jsp?idx=<%=bidx%>','BUCKET LIST','width=800,height=400,location=no,status=no,scrollbars=yes');">
			  <%=btitle%>
			  </a>
			  </li>

			<%
					}
					rs.close();
			%>
				<script>
					function goAj(num, goal) {
						$.ajax({
							url:'buck_goal_update.jsp', //request 보낼 서버의 경로
							type:'post', // 메소드(get, post)
							data:{writer: '<%=suserid%>', num:num, goal:goal}, //보낼 데이터
							success: function(data) {
								//서버로부터 정상적으로 응답이 왔을 때 실행
							},
							error: function(err) {
								//서버로부터 응답이 정상적으로 처리되지 못햇을 때 실행
							}
						});
					}
					
					$(document).ready(function() { 
						$('input[name=buckbox]').on('click', function() { 
							var goal = null;
							if ( $(this).prop('checked') ) { 
								goal = $(this).val();
							} 
							goAj($(this).val(), goal);
						}); 
					});
				</script>
		  </ul>
        </div>
        
		<div id="daily" class="clearfix">
          <ul>
            <a href="daily/daily_li.jsp"><h4>DAILY KIT</h4></a>
            <a href="daily/daily_write.jsp"><li>일기 작성</li></a>
          <br> 
<!------------------------------WeatherStart------------------------------------------------->
  <%
	
	//map을 담을 리스트 만들기
	List<Map> pubList = new ArrayList();

	//xml 데이터 호출하기

	String url = "http://apis.data.go.kr/1360000/SfcInfoService/getStnbyRtmObs?";
	url = url+"serviceKey=6U2BMyvdJAFrXgX8yXJcLfKa4eZC9Q3CChNhoN4m9TXPyNOdmjy0vebK0VZeb6Yi8f5peL3MMln1QEhfLYi%2BKg%3D%3D&numOfRows=10&pageNo=1&stnId=108";

	DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

	DocumentBuilder builder = factory.newDocumentBuilder();

	Document document = builder.parse(url);

	NodeList items = document.getElementsByTagName("items");

	String[] elements = {"temperature", "windSpeed","stnId"};

	for(int i=0; i < items.getLength(); i++) {
		Node n = items.item(i);
		
		Element e = (Element) n;
		
		Map<String, String> pub = new HashMap();
		
		//child를 기준으로 for문 만들기
		for(String element : elements) {
			NodeList titleList = e.getElementsByTagName(element);
			Element titleElement = (Element)titleList.item(0);
			Node titleNode = titleElement.getChildNodes().item(0);
			pub.put(element, titleNode.getNodeValue());
		}
		//리스트에 map 담기
		pubList.add(pub);
	}

  %>
  <!------------------------------Weathercopyend------------------------------------------------->
         	
			<h4> 오늘의 날씨<!--API 출력--></h4>
				<li>
					<%for(Map pub : pubList){%>
								<li>지역&nbsp;&nbsp;&nbsp;
								<%
								if(pub.get("stnId").equals("108"))
									out.print("서울");
								%>
								</li>	
								<li>기온&nbsp;&nbsp;&nbsp;<%=pub.get("temperature") %>°C</li>
								<li>풍속&nbsp;&nbsp;&nbsp;<%=pub.get("windSpeed")%>m/s</li>	
				
						<%} %>	
				</li>
		  </ul>
        </div><!--daily-->
      </nav>
    </aside><!--side-->
	
    <section id="content" class="clearfix">
        <div class="cal">
          <table>
<!-----------------------copy---------------------------------------------------->
          <thead>
          <th>
        		<td> <!-- 년 도--현재날짜-->        		
        		<a href="calendar.jsp?year=<%=year-1%>&amp;month=<%=month%>" target="_self">◀</a>
        		<% out.print(year); %>년
        		<a href="calendar.jsp?year=<%out.print(year+1);%>&month=<%out.print(month);%>">▶</a>
        		</td>
        		<td align=center> 
        		<a href="calendar.jsp?year=<%out.print(year);%>&month=<%out.print(month-1);%>">◀</a>
        		<% out.print(month+1); %>월
        		<a href="calendar.jsp?year=<%out.print(year);%>&month=<%out.print(month+1);%>">▶</a>
        		</td>
        		<td align=right><% out.print(currentYear + "-" + (currentMonth+1) + "-" + currentDate); %>&nbsp;&nbsp;&nbsp;&nbsp;
        		</td>
        		<td>
                 <button type="button" onclick="location.href='schedule_write.jsp' ">일정 추가</button>
        	   </td>
        	   <td>
        	     <button type="button" onclick="location.href='schedule_li.jsp' ">일정 확인</button>  
        	   </td>
           </th>
         </thead>
          <tbody> <!-- 달력 부분 -->
        	  <tr class="week">
        		  <td id="red">SUN</td>
        		  <td>MON</td>
        		  <td>TUE</td>
        		  <td>WED</td>
        		  <td>THU</td>
        		  <td>FRI</td>
        		 <td id="blue">SAT</td>
        	  </tr>
           
		   <tr>
 <%
           cal.set(year, month, 1); //현재 날짜를 현재 월의 1일로 설정
           int startDay=cal.get(java.util.Calendar.DAY_OF_WEEK); //현재날짜(1일)의 요일
           int end=cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); //이 달의 끝나는 날
           int br=0; //7일마다 줄 바꾸기
           
           
           for(int i=0; i<(startDay-1); i++){ //빈칸출력
%> 		<td style="height:75px;">
<%		   
            out.println("&nbsp;</td>");
            br++;
        		if((br%7)==0) {
        		 out.println("<br>");//줄바꿈
        		}
           }
           for(int i=1; i<=end; i++) { //i날짜출력
            out.println("<td>");
%>
			<a href onclick="window.open('schedule_min_write.jsp','SCHEDULE WRITE','width=650,height=400,top=200,left=300,location=no,status=no,scrollbars=no');">
<%
			out.print(i + "</a>"+"<br>"); //메모(일정) 추가 부분
			
			int sch_year, sch_month, sch_day; //일정에서 데려올 날짜 데이터
			
			 SQL= "select title, year, month, day, num from schedule where writer = ?";
				pstmt = con.prepareStatement(SQL);
				pstmt.setString(1,suserid);
				rs = pstmt.executeQuery(); 

			while(rs.next()){ //정수형으로변환
				sch_year =  rs.getInt("year");
				sch_month =  rs.getInt("month");
				sch_day =  rs.getInt("day");
				int sidx = rs.getInt("num");
							
			//캘린더 날짜와 비교,일정클릭시미니뷰어뜸
			if(sch_year==year&&sch_month==month+1&&sch_day==i){
%>
			<a href onclick="window.open('schedule_min_view.jsp?idx=<%=sidx%>','SCHEDULE VIEW','width=650,height=400,top=200,left=300,location=no,status=no,scrollbars=no');" style="background:#ca6a9a;color:#fff;">
<%
					out.println(rs.getString("title")+"</a>"+"<br>");

				}

			}//whileEND	
			rs.close();
			
			out.println("</td>");
			br++;
				  
		  if((br%7)==0 && i!=end) {
        		 out.println("</tr><tr height=90>");
        		}
           }//forEND
           while((br++)%7!=0) //말일 이후 빈칸출력
            out.println("<td>&nbsp;</td>"); 
           %>
<!-------------------------------copy------------------------------->
           </tr>
           </tbody>
          </table>            
        </div><!--cal-->
	
	<section id="cont2">
	<div class="alarm" >
		<h4>*<%=suserid%>님 오늘의 일정*</h4>
			<%
					String alarm_Year=Integer.toString(currentYear); //현재 날짜 기억
					String alarm_Month=Integer.toString(currentMonth+1);
					String alarm_Date=Integer.toString(currentDate);
					
					 String today = alarm_Year+alarm_Month+alarm_Date;
					 
					SQL = "select title,year,month,day,num from schedule  where writer = ? AND alarm = 'YES' order by num desc"; //스케줄에서 일정작성날짜 데려오기
			
						pstmt = con.prepareStatement(SQL);
						pstmt.setString(1,suserid);
						rs = pstmt.executeQuery();

					 while(rs.next()){

					   String alarm_title = rs.getString(1);
					   String alarm_year = rs.getString(2);
					   String alarm_month = rs.getString(3);
					   String alarm_day = rs.getString(4);
					   String anum = rs.getString(5);
					   
					 String alarm_date = alarm_year + alarm_month + alarm_day; 
					 
					 if(today.equals(alarm_date)){
	%>
					<div><a href="schedule_view.jsp?idx=<%=anum%>"><%=alarm_title%></div>
	<% 
					}
		}//whileEND
		rs.close();
	%>	
		</div><!--alarm-->
	</section><!--cont2-->

    </section><!--content-->
  </div><!--wrap-->
 <% 		

 				pstmt.close(); 
				con.close();
		}//세션
%>
</body>
</html>
