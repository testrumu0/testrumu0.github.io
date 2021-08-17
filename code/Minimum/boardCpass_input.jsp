<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
  <TITLE>공지사항 등록</TITLE>
	<link href="/chap11/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>

<%
String num = request.getParameter("pnum");
%>
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
				<td width="253" align="right">HOME &gt; QnA &gt; 새글쓰기</td>
            </tr>
          <tr>
            <td colspan="2" align="left" valign="top">
			
<FORM NAME = "frm1" ACTION = "boardCview.jsp?pnum=<%= num %>" METHOD = "post">
<INPUT TYPE = "hidden" NAME = "pnum"  VALUE = <%= num %>>
<TABLE WIDTH = "300" BORDER = "1" CellPadding = "0" CellSpacing = "0" align = "center">
	<TR>
		<TD WIDTH = "30%" ALIGN = "center">비밀번호</TD>
 		<TD WIDTH = "50%" ALIGN = "left"><INPUT TYPE = "password" NAME = "pwd" SIZE = 10 MAXLENGTH = 10></TD>
		<TD WIDTH = "250%" ALIGN = "center"><INPUT TYPE = "submit"   VALUE = "확인" >
	 	</TD>
    </TR>
</TABLE>
</FORM>
<div align = "center"><A HREF = "boardClist.jsp">[목록 보기]</A> </div>                                  

	  
	  </td>
            </tr>	  
	  </table></td>
      </tr>
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
