<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<HTML>
<HEAD>
  <TITLE>공지사항 리스트</TITLE>
</HEAD>

<H3>공지사항 리스트</H3>

<BODY>
<%

String in_search_key	= request.getParameter("search_key");
if (in_search_key == null) in_search_key = "";

String in_search_value	= request.getParameter("search_value");
if (in_search_value == null) in_search_value = "";

%>
<FORM NAME=frm1 ACTION="boardAlist.jsp" METHOD=post>
	<SELECT  NAME = "search_key">
		<OPTION VALUE="title" <% if(in_search_key.equals("title")) out.print (" selected"); %> >제목</OPTION>
		<OPTION VALUE="writer" <% if(in_search_key.equals("writer")) out.print (" selected"); %>>작성자</OPTION>
	</SELECT>
	<INPUT TYPE = text   NAME = "search_value" VALUE="<%= in_search_value %>">
	<INPUT TYPE = submit VALUE = "검색">
</FORM>

<TABLE border = "1" cellspacing = "1" cellpadding = "2" width = "600">      

<TR bgcolor = "cccccc">      
	<TH WIDTH = "10%"><font size=2><center><b>번호</b></center></font></TH>      
	<TH WIDTH = " *%"><font size=2><center><b>제목</b></center></font></TH>      
	<TH WIDTH = "15%"><font size=2><center><b>작성자</b></center></font></TH>      
	<TH WIDTH = "17%"><font size=2><center><b>등록일</b></center></font></TH>      
	<TH WIDTH = "10%"><font size=2><center><b>조회수</b></center></font></TH>      
</TR> 

<%@ include file = "/chap10/include/dbinfo.inc" %>		

<%

ResultSet rs = null, rs2 = null;
Statement stmt = null;

try
{
	String strPageNum = request.getParameter("PageNum");	// 선택된 페이지 번호 참조
	if (strPageNum == null) {
		strPageNum = "1";
	}

	int currentPage = Integer.parseInt(strPageNum);			// 현재 페이지
	int pageSize	= 10;
	
	stmt = con.createStatement();

	String strSQL = "select isnull(count(*), 0) from boardA";
	if (in_search_value.equals("") == false) {
		strSQL = strSQL + " where " + in_search_key + " like '%" + in_search_value + "%'";
	}
	rs2 = stmt.executeQuery(strSQL);

	int totalRecords	= 0;	// ResultSet 객체 내의 레코드 수를 저장하기 위한 변수 

	rs2.next();					// 첫번째 레코드로 이동
	if (rs2.getInt(1) == 0){	// 만약 테이블에 데이터가 없다면
%>
		<TR>      
			<TD colspan=5><center>등록된 공지가 없습니다</center></TD>      
		</TR>
<% 
	}
	else
	{	
		totalRecords = rs2.getInt(1); 

		strSQL = "SELECT TOP " + pageSize + " num, title, writer, CONVERT(CHAR(10), updatedtm, 120) writedt, readcnt FROM boardA  WHERE num NOT IN (SELECT TOP ";
		strSQL = strSQL  + (currentPage - 1) * pageSize + " num FROM boardA ";
		if (in_search_value.equals("") == false) {
			strSQL = strSQL + " where " + in_search_key + " like '%" + in_search_value + "%'";
		}		
		strSQL = strSQL  + " ORDER BY num DESC)";
		if (in_search_value.equals("") == false) {
			strSQL = strSQL + " and " + in_search_key + " like '%" + in_search_value + "%'";
		}
		strSQL = strSQL  + " ORDER BY num DESC";

		rs = stmt.executeQuery(strSQL);			// 현재 페이지에 출력할 공지만 select

		int pageSize_temp = pageSize;			// 현재 표시될 라인을 하나씩 줄임

		while(rs.next() && pageSize_temp > 0){

			int num					= rs.getInt("num");
			String title		= rs.getString("title");
			String writer		= rs.getString("writer");
			String writedt	= rs.getString("writedt");
			int readcnt			= rs.getInt("readcnt");

%>
			<TR>      
				<TD ALIGN = "center"><a href="boardAview.jsp?pnum=<%= num %>"><%= num %></a></TD>      
				<TD><a href="boardAview.jsp?pnum=<%= num %>"><%= title %></a></TD>      
				<TD ALIGN = "center"><%= writer	   %></TD>      
				<TD ALIGN = "center"><%= writedt   %></TD>      
				<TD ALIGN = "center"><%= readcnt   %></TD지      
			</TR>   
<%		
			pageSize_temp = pageSize_temp - 1;      // 현재 표시될 라인을 하나씩 줄임

		} // while(rs.next() && pageSize_temp > 0) end

	} //if (rs2.next() == false) else end
%>
	</TABLE><br><br>    

<%
	// 총 페이지 수 계산
	int intTotPages	= 0;
	int intR		= totalRecords % pageSize;
	if	(intR == 0) {
		intTotPages = totalRecords / pageSize;
	}
	else
	{
		intTotPages = totalRecords / pageSize + 1;          // 나머지가 0 보다 크면 총 페이지수는 몫 + 1
	}

	int intGrpSize  = 10;									// 그룹 당 페이지 수 설정                   
	int currentGrp  = 0;									// 현 그룹 No.
		intR		= currentPage % intGrpSize;
	if	(intR == 0) {										
		currentGrp	= currentPage / intGrpSize;
	}
	else
	{
		currentGrp	= currentPage / intGrpSize + 1;
	}

	int intGrpStartPage	= (currentGrp   - 1) * intGrpSize + 1;	// 현 그룹 시작 페이지
	int intGrpEndPage	=  currentGrp * intGrpSize;				// 현 그룹   끝 페이지
	if (intGrpEndPage > intTotPages){
		intGrpEndPage	= intTotPages;
	}
	if (currentGrp > 1){
%>
		[<A href="boardAlist.jsp?PageNum=<%= intGrpStartPage - 1 %>">이전</A>]
<%
	}

	int	intGrpPageCount		= intGrpSize;								// 그룹 당 페이지 수    
	int intIndex			= intGrpStartPage;							// 현 그룹 시작 페이지

	while (intGrpPageCount > 0 && intIndex <= intGrpEndPage){
%>
		[<A href="boardAlist.jsp?PageNum=<%= intIndex %>"><%= intIndex %></A>] &nbsp; 
<%
		intIndex		= intIndex + 1;
		intGrpPageCount = intGrpPageCount    - 1;
	}

	if (intIndex <= intTotPages){
%>
		[<A href="boardAlist.jsp?PageNum=<%= intIndex %>">다음</A>]
<%
	}

} // try end

catch(SQLException e1){
	out.println(e1.getMessage());
} // catch SQLException end

catch(Exception e2){
	e2.printStackTrace();
} // catch Exception end

finally{
	if (stmt != null) stmt.close();
	if (rs   != null) rs.close();
	if (rs2  != null) rs2.close();
	if (con  != null) con.close();
} // finally end
%>
<br><br>
<FORM NAME = "frm1" ACTION = "boardAwrite.jsp" METHOD = "post">
	<INPUT TYPE = "submit" VALUE = "새글쓰기">
</FORM>
</BODY>