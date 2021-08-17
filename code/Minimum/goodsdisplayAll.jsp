<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>
<HTML>
<HEAD>
  <TITLE> 전체상품 보기</TITLE>
<link href="/chap11/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>

<BODY>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top"><table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="/chap11/includes/top.inc" %>
      </tr>
      <tr>
        <td height="80" background="/chap11/icons/sub_bg.jpg">&nbsp;</td>
      </tr>
      <tr>
<%
String strPageNum = request.getParameter("PageNum"); // 선택된 페이지 번호 참조
if (strPageNum == null) {
	strPageNum = "1";
}

int currentPage = Integer.parseInt(strPageNum);			// 현재 페이지

int pageSize	= 6;

ResultSet rs = null, rs2 = null;
	
Statement stmt  = con.createStatement();

String cat1cd = request.getParameter("pcat1");

String SQL = "select count(*) from goodsinfo";
rs2 = stmt.executeQuery(SQL);

int totalRecords	= 0;  // ResultSet 객체 내의 레코드 수를 저장하기 위한 변수 
if (rs2.next() == false){  // 만약 테이블에 아무것도 없다면
%>
	<TD colspan=7><center>등록된 상품이 없습니다.</center></TD>      
</TR>
<% 
}
else
{	
%>
	        <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
<%
	totalRecords = rs2.getInt(1); 

	SQL = "select top " + pageSize ;
	SQL = SQL  + " goodscd, goodsnm, unitprice, best_yn, goodsimg1 ";
	SQL = SQL  + " from goodsinfo where goodscd not in (select top ";
	SQL = SQL  + (currentPage - 1) * pageSize + " goodscd from goodsinfo";
	SQL = SQL  + " order by goodscd  )";
	SQL = SQL  + " order by goodscd ";
	
	rs = stmt.executeQuery(SQL);	// 현재 페이지에 출력할 회원만 select

	int pageSize_temp = pageSize;			// 현재 표시될 라인을 하나씩 줄임

	int cnt = 0;      // 
	while(rs.next() && pageSize_temp > 0 ){

		cnt ++;


		String goodscd		= rs.getString("goodscd");
		String goodsnm		= rs.getString("goodsnm");

		int unitprice			= rs.getInt("unitprice");
		String best_yn		= rs.getString("best_yn");
		String goodsimg1	= rs.getString("goodsimg1");

		if ( cnt == 1) {
	%>
          <tr>
            <td height="45" align="left" class="new_tit">전체 상품 보기</td>
            <td height="45" colspan="3" align="right">HOME &gt; more</td>
          </tr>
          <tr>
<%
		}
%>
					<TD>
						<TABLE style="border:solid 1px #ccc; margin-left:30px;" cellspacing = "1" cellpadding = "0" width = "200"> 			
						<TR>
								<TD>
									<a href="/chap11/goodsdetail.jsp?pgoodscd=<%= goodscd %>"><img src="/chap11/images/<%= goodsimg1 %>" height=200 width =200></a>								
								</TD>
						</TR>			
						<TR>
								<TD align=center>
									<%= goodsnm %>							
								</TD>
						</TR>			
						<TR>
							<TD align=center>
									<% 		
											DecimalFormat df = new DecimalFormat("###,###,##0"); 
											out.println(df.format(unitprice));	
									%>					
								</TD>
						</TR><br><br>	
				
						</TABLE> 			
				</TD>  
			
	<%		
		pageSize_temp = pageSize_temp - 1;      // 현재 표시될 라인을 하나씩 줄임

	  if (cnt == 3)
			out.print("</TR><TR>");
	}

}
%>
				</tr>
        </table></td>
				</tr>
				<tr><td height=30></td>
				</tr>
				<tr>
					<td colspan=4 align=center>
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

	int intGrpSize  = 1;									// 그룹 당 페이지 수 설정                   
	int currentGrp  = 0;									// 현 그룹 No.

	intR						= currentPage % intGrpSize;
	if	(intR == 0) {
		currentGrp		= currentPage / intGrpSize;
	}
	else
	{
		currentGrp	= currentPage / intGrpSize + 1;
	}

	int intGrpStartPage	= (currentGrp   - 1) * intGrpSize + 1;	// 현 그룹 시작 페이지
	int intGrpEndPage		=  currentGrp * intGrpSize;							// 현 그룹   끝 페이지
	if (intGrpEndPage > intTotPages){
		intGrpEndPage			= intTotPages;
	}
	if (currentGrp > 1){
%>
	 [<A href="goodsdisplayAll.jsp?pcat1=<%=cat1cd%>&PageNum=<%= intGrpStartPage - 1 %>">이전</A>]
<%
	}

	int	intGrpPageCount		= intGrpSize;								// 그룹 당 페이지 수    
	int intIndex					= intGrpStartPage;					// 현 그룹 시작 페이지

	while (intGrpPageCount > 0 && intIndex <= intGrpEndPage){
%>
		[<A href="goodsdisplayAll.jsp?pcat1=<%=cat1cd%>&PageNum=<%= intIndex %>"><%= intIndex %></A>] &nbsp; 
<%
		intIndex = intIndex + 1;
		intGrpPageCount    = intGrpPageCount    - 1;
	}

	if (intIndex <= intTotPages){
%>
		[<A href="goodsdisplayAll.jsp?pcat1=<%=cat1cd%>&PageNum=<%= intIndex %>">다음</A>]
<%
	}
%>
					</td >
				</tr>

      </tr>
			<%@ include file="/chap11/includes/bottom.inc" %>
    </table></td>
  </tr>
</table>
</body>
</html>
<%
if (stmt  != null) stmt.close();
if (rs    != null) rs.close();
if (rs2   != null) rs2.close();
if (con   != null) con.close();
%>
</BODY>