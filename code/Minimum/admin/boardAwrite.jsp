<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>
<HTML>
<HEAD>
  <TITLE> 공지사항 등록</TITLE>
<link href="/chap11/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>

<script language=javascript>
function valid_check()
{

	if (document.frm1.writername.value == "")
	{
		alert("작성자명을 입력바랍니다.");
		document.frm1.writername.focus(); 
		return false;
	}

	if (document.frm1.title.value == "") 
	{
		alert("제목을 입력바랍니다.");
		document.frm1.title.focus(); 
		return false;
	}

	if (document.frm1.contents.value == "") 
	{
		alert("내용을 입력바랍니다.");
		document.frm1.contents.focus(); 
		return false;
	}

	document.frm1.submit();
}

function submit_list()
{
	document.frm1.action = "boardAlist.jsp";
	document.frm1.submit();
}

 </script>

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
			<FORM NAME = "frm1" ACTION = "boardAwrite_ok.jsp" METHOD = "post">
			<TABLE WIDTH = "500" BORDER = "1" CellPadding = "0" CellSpacing = "0" align="center">
				<TR>
					<TD WIDTH = "40%" ALIGN = "center" bgcolor="#D7D7D7">작성자명</TD>
					<TD WIDTH = "60%" ALIGN = "left">
						<INPUT TYPE = "text" SIZE = "15" MAXLENGTH = "10" NAME = "writername">
					</TD>
				</TR>
				<TR>
					<TD WIDTH = "40%" ALIGN = "center" bgcolor="#D7D7D7">제목</TD>
					<TD WIDTH = "60%" ALIGN = "left">
						<INPUT TYPE ="text" NAME="title" SIZE = "50" MAXLENGTH = "50">
					</TD>
				</TR>
				<TR>
					<TD WIDTH = "40%" ALIGN = "center" bgcolor="#D7D7D7">내용</TD>
					<TD WIDTH = "60%" ALIGN = "left">
						<TEXTAREA NAME="contents" ROWS=5 COLS=50></TEXTAREA>
					</TD>
				</TR>
				<TR>
					<TD WIDTH = "100%" ALIGN = "center" COLSPAN = "2">
					<TABLE>
						<TR>
							<TD WIDTH = "33%" ALIGN = "center">
								<INPUT TYPE = "reset" VALUE = "다시 작성">
							</TD>
							<TD WIDTH = "34%" ALIGN = "center">
								<INPUT TYPE = "button" VALUE = "등록" onClick="valid_check()">
							</TD>
							<TD WIDTH = "33%" ALIGN = "center">
								<INPUT TYPE = "button" VALUE = "목록으로" onClick = "submit_list()">
							</TD>
						</TR>
					</TABLE>
					</TD>
				</TR>
			</TABLE>
			</FORM>
	  
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
<%

%>