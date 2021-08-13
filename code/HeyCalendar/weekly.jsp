<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*" %>
<% request.setCharacterEncoding("utf-8");%>
<%@page import="java.util.*" import = "java.sql.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>

<html>
 <head>
  <link rel= "stylesheet" href="common.css" type="text/css" >
  <meta content="text/html; charset=UTF-8">
   <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>	
    <title>Hey!Calendar</title>
 </head>
<body>
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
<!--------------------copy--jsp캘린더코드카피---------------------------------------->
<!------------------JSP 날짜 차이 계산 https://m.blog.naver.com/PostView.nhn?blogId=cacung82&logNo=10180593661&proxyReferer=https:%2F%2Fwww.google.com%2F-------------->
<%     
/*Calendar코드*/

	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	
	java.util.Calendar cal=java.util.Calendar.getInstance(); //Calendar객체 cal생성
	
	int yyyy     = cal.get(java.util.Calendar.YEAR);   //현재 년도
    int MM      = cal.get(java.util.Calendar.MONTH);  //현재 달
    int dd        = cal.get(java.util.Calendar.DATE);    //현재 날짜

    cal.set(yyyy, MM, dd); //현재 날짜 세팅
		
	long diff = 0;
	long diffDays = 0;


   int dayOfWeek = cal.get(java.util.Calendar.DAY_OF_WEEK); //요일을 구한다

   String korDayOfWeek = "";
   switch(dayOfWeek){
      case 1:
         korDayOfWeek = "일요일";
         break;
      case 2:
         korDayOfWeek = "월요일";
         break;
      case 3:
         korDayOfWeek = "화요일";
         break;
      case 4:
         korDayOfWeek = "수요일";
         break;
      case 5:
         korDayOfWeek = "목요일";
         break;
      case 6:
         korDayOfWeek = "금요일";
         break;
      case 7:
         korDayOfWeek = "토요일";
         break;

      }
 %> <!------------------------------Calendarcopyend------------------------------------------------->
  
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
		function delChk(){
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
             <button onclick="delChk();">-</button>
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
						String buck_goal = rs.getString("goal"); 
						String buck_checked = (buck_goal == null || buck_goal.length() == 0) ? "" : " checked";
			  %>

			<li>
			  <input type="checkbox" name="buckbox" value="<%=bidx%>"<%=buck_checked%>>
			  <a href onclick="window.open('bucket/bucket_view.jsp?idx=<%=bidx%>','BUCKET LIST','width=800,height=400,location=no,status=no,scrollbars=yes');">
			  <%=btitle%>
			  </a>
			  </li>
            </ul>
			<%
					}
					rs.close();
			%>
			<script>
					function goAjax(num, goal) {
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
							goAjax($(this).val(), goal);
						}); 
					});
		</script>
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
    
    <section id="content">   
       <div class="weekly">
         <div class="scroll">
        <table class="main_table">

          <thead>
          <th>
             <td><h4>TODAY</h4></td>
             <td align="right"><% out.print(yyyy + "-" + (MM+1) + "-" + dd); %>
        	 </td>
        	 <td><%out.print(korDayOfWeek);%></td>
        	 <td>
                 <button type="button" onclick="location.href='schedule_write.jsp' ">
                 일정 추가</button>
        	 </td>
        	 <td>
        	     <button type="button" onclick="location.href='schedule_li.jsp' ">
                 일정 확인</button>  
        	 </td>
          </th>
        </thead>      
              
	<tbody>
			<tr class="w_week">
					<td>DATE</td>	
					  <td id="red">SUN</td>
					  <td>MON</td>
					  <td>TUE</td>
					  <td>WED</td>
					  <td>THU</td>
					  <td>FRI</td>
					 <td id="blue">SAT</td>
		   </tr>

		<tr>
		<td>TIME</td>
<%

			String fwd = "";
			//이번주 첫째 날짜
	 		cal.add(Calendar.DATE, 1 - cal.get(Calendar.DAY_OF_WEEK)); 
			int firstWeekDay =  (cal.get(Calendar.DATE)); 
			fwd = Integer.toString(firstWeekDay);

			
			//이번주 마지막 날짜  
			cal.add(Calendar.DATE, 7 - cal.get(Calendar.DAY_OF_WEEK)); 
			int lastWeekDay = (cal.get(Calendar.DATE)); 
	
		 for(int d=1; d<=7; d++){ //i날짜출력
			out.println("<td>");
			cal.add(Calendar.DATE, d - cal.get(Calendar.DAY_OF_WEEK)); 
			int WeekDay = (cal.get(Calendar.DATE)); 
			out.print(WeekDay);	
			out.print("</td>");				
		 }
		 
		  String m = Integer.toString(MM+1);
			if(m.length()==1){ //형식맞추기20200624
				m = "0"+m;
			}

%>
	</tr>   
<%
		
			SQL= "select title, year, month, day, num, start_t, end_t from schedule where writer = ? AND month = ? OR month <= ? ";
				pstmt = con.prepareStatement(SQL);
				pstmt.setString(1,suserid);
				pstmt.setString(2,m);
				pstmt.setInt(3,MM+2); //이번달 마지막주 고려 다음달

				rs = pstmt.executeQuery(); 

				
				// rowspan 데이터가 들어갈 배열
				// buf[시간][날짜-firstWeekDay] 값이, 1이면 일반 td, 1보다 크면 rowspan이 들어갈 자리, 
				// 0이면 윗줄에서 rowspan 했으니 td를 출력하면 안되는 자리 
				int[][] buf = new int[24][7];
				for (int i = 0; i < 24; i++)
					for (int j = 0; j < 7; j++)
						buf[i][j] = 1;					
				
			  // buf와 같은 위치에 출력할 내용을 담은 배열
			String[][] text = new String[24][7];
	
			while(rs.next()){ //정수형으로변환
				String stitle = rs.getString("title");
				String sch_year =   Integer.toString(rs.getInt("year"));
				String sch_month =  Integer.toString(rs.getInt("month"));
					if(sch_month.length()==1) //형식맞추기20200624
						sch_month = "0"+sch_month;
				
				String sch_day =   Integer.toString(rs.getInt("day"));
				int dnum =  rs.getInt("num");
				int time_start = rs.getInt("start_t");
				int time_end = rs.getInt("end_t");					
				int span = (time_end - time_start)+1; //합병될 행 값 구하기	
			
			//날짜차이구하기
			String dbegin = (sch_year+sch_month+sch_day); //sch_day
		
			String dend =  (Integer.toString(yyyy)+m+fwd); //firstWeekDay
	
			Date beginDate = df.parse(dbegin);
			Date endDate = df.parse(dend); 

			
			diff = beginDate.getTime() - endDate.getTime(); //밀리세컨단위로 계산됨 sch_day-firstWeekDay
			diffDays = diff / (24 * 60 * 60 * 1000); 
			
			 int d_index = 0;
			 
			 if(diffDays>=0 && diffDays<7 ) //날짜 차이가 인덱스 범위를 넘어서면 들어오지 못하게 함. 음수면 지난주꺼
			 {
				 d_index =  (int)diffDays; //배열이 int형식이므로 캐스팅
			 

			// rowspan 들어갈 자리에 span 크기 적어넣기			
			buf[time_start][d_index] = span; 
				
			// 그 아래줄 같은 컬럼은 span 수 - 1 만큼 0으로 채우기. 그래야 나중에 td를 출력안함
			for (int j = time_start + 1; j <= time_end; j++)
				buf[j][d_index] = 0;
			
			// 이 자리에 출력할 텍스트 저장
			text[time_start][d_index] = stitle +"/"+(sch_day)+"<br>";
		}//ifEND
		}rs.close();	

		for(int t=7; t<=23; t++){ //시간출력
			out.print("</tr>");
		
			out.print("<td>");
			out.print(t + ":00");
			out.print("</td>");
		
		
	    for (int i = 0; i < 7; i++) {
	    	
    		if (buf[t][i] > 1)
    			out.println("<td rowspan=" + buf[t][i] + " style='background:#b7a8d4; color:#fff;'>"+ text[t][i] +"<br></td>");
    		else if (buf[t][i] == 1)
    			out.println("<td  style='border:solid 1px #f1f3f5;'>&nbsp;<br></td>");
    		else   // 이 값이 0이면 td를 출력하면 안된다.
    			;
	    }
	    
        out.print("</tr>");
	}//시간출력
				

%>
            </tbody>          
        </table>	

    </div><!--scroll-->
   </div><!--cal-->  
   </section><!--content-->
    
  </div><!--wrap-->
 <% 
 				pstmt.close(); 
				con.close();
		}//세션
%>
</body>
</html>