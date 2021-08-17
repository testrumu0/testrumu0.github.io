<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*, java.util.Calendar" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>
<HTML>
<HEAD>
  <TITLE> QnA</TITLE>
	<link href="/chap11/includes/all.css" rel="stylesheet" type="text/css" />

</HEAD>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
		<table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="/chap11/includes/top.inc" %>
      <tr>
        <td height="80" background="/chap11/icons/sub_bg.jpg">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" valign="top">
		<table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr>
				<td width="547" height="45" align="left" class="new_tit">고객상담 및 상품문의</td>
				<td width="253" align="right">HOME &gt; QnA</td>
            </tr>
          <tr>
		  <tr>
			  <td>
			  	<form name=frml action="qna.jsp" method=post>
					<input type=text name =search_value value="">
					<input type=submit value="검색">
				</form>
			  </td>
		  </tr>
            <td colspan="2" align="left" valign="top">
			<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
					<tr>
						<th><font size=2><center><b>상품번호</center></font></th>
						<th><font size=2><center><b>상품정보</center></font></th>
						<th><font size=2><center><b>제목</center></font></th>
						<th><font size=2><center><b>작성자</center></font></th>
						<th><font size=2><center><b>작성일</center></font></th>
					</tr>
            
 <%
 		/*
		String strPageNum = request.getParameter("PageNum");
		if(strPageNum == null){
			strPageNum = "1";
			
		}
		int currentPage = Integer.parseInt(strPageNum);
		int pageSize = 6;
		
		int totalRecords = 0;
		if(rs2.next() == false){
			*/
%>
		<!---	<tr>
				<td colspan=5><center>등록된 회원이 없습니다.</center></td>
			</tr>--->
<%  /*  
		}else{
			totalRecords = rs2.getInt(1);  
		*/
%>
			<tr>
				<td align="center" bgcolor="#FFFFFF">1101</td>
				<td align="center" bgcolor="#FFFFFF">esdf</td>
				<td align="center" bgcolor="#FFFFFF">sdf</td>
				<td align="center" bgcolor="#FFFFFF">sdf</td>
				<td align="center" bgcolor="#FFFFFF">sdf</td>
			</tr>
</table>
	  
	  </td>
            </tr>	  
	  </table></td>
      </tr>
		</td>
      </tr>
	  <tr>
	  <td>
	
	  
	  </td>
	  </tr>
      <tr>
        <td height="50" align="center">
          <input type="submit" id="button2" value="메인으로 이동"/>
        </td>
      </tr>

      <tr>
			<%@ include file="/chap11/includes/bottom.inc" %>
      </tr>
    </table>
	</td>
  </tr>
</table>
</body>
</html>
<%

%>