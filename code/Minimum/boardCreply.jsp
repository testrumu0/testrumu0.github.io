<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
  <TITLE>QnA 답변</TITLE>
	<link href="/chap11/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>
<script language=javascript>
function valid_check()
{
	if (frm1.writername.value.length < 1) {
		alert("작성자명을 입력하세요.");
		document.frm1.writername.focus(); 
		return false;
	}

	if (frm1.title.value.length < 1) {
		alert("제목을 입력하세요.");
		document.frm1.title.focus(); 
		return false;
	}

	if (frm1.contents.value.length < 1) {
		alert("내용을 입력하세요.");
		document.frm1.contents.focus(); 
		return false;
	}

	document.frm1.submit();
}

function submit_list()
{
	location.href = "boardClist.jsp";
}

</SCRIPT>
<%
PreparedStatement pstmt = null;
ResultSet rs = null;

try
{
	String num = request.getParameter("pnum"); 

	String strSQL = "SELECT * FROM boardC WHERE num = ?";
	pstmt = con.prepareStatement(strSQL);
	pstmt.setInt(1, Integer.parseInt(num));

	rs = pstmt.executeQuery();
	rs.next();

	String title	= rs.getString("title");
	String writer	= rs.getString("writer");
	String contents	= rs.getString("contents");
    String upfile1  = rs.getString("upfile1");
    String upfile2  = rs.getString("upfile2");
    String ext1     = null;
    if (upfile1 != null) {
    	ext1 =  upfile1.substring(upfile1.indexOf(".") + 1);
    }
    String ext2     = null;
    if (upfile2 != null) {
    	ext2 =  upfile2.substring(upfile2.indexOf(".") + 1);
    }


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
        <td align="center" valign="top" >
		<table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr>
				<td width="547" height="45" align="left" class="new_tit">고객상담 및 상품문의</td>
				<td width="253" align="right">HOME &gt; QnA &gt; 답변달기</td>
            </tr>
          <tr>
            <td colspan="2" align="left" valign="top" style="padding-left:150px;">
			
<FORM NAME = "frm1" ACTION = "boardCreply_ok.jsp" METHOD = "POST" ENCTYPE="multipart/form-data">
	<INPUT TYPE = "hidden" NAME = "pnum"  VALUE = <%= num %>>
	<TABLE WIDTH = "500" BORDER = "1" CellPadding = "0" CellSpacing = "0">
		<TR>
			<TD WIDTH = "40%" ALIGN = "left">작성자명</TD>
			<TD WIDTH = "60%" ALIGN = "left">
				<INPUT TYPE = "text" SIZE = "15" MAXLENGTH = "10" NAME = "writername" >
			</TD>
		</TR>
		<TR>
			<TD WIDTH = "40%" ALIGN = "left">제목</TD>
			<TD WIDTH = "60%" ALIGN = "left">
				<INPUT TYPE = "text" SIZE = "50" MAXLENGTH = "50" NAME = "title" VALUE="[답변]<%= title %>">
			</TD>
		</TR>
		<TR>
		<TD WIDTH = "40%" ALIGN = "left">비밀글</TD>
		<TD WIDTH = "60%" ALIGN = "left">
			비밀글 여부<INPUT TYPE ="checkbox" NAME="pwd_chk" VALUE = "Y"> 비밀글일 경우에 체크<BR>
			비밀번호 <INPUT TYPE ="text" NAME="pwd" SIZE = "10" MAXLENGTH = "10"> 비밀글일 경우에 입력
		</TD>
				<TR>
				<TD WIDTH = "40%" ALIGN = "left">고객 첨부</TD>
				<TD WIDTH = "60%" ALIGN = "left">
<%
				if (upfile1 != null) {
					ext1 = ext1.toLowerCase();
					if (ext1.equals("jpg") || ext1.equals("bmp") || ext1.equals("gif") || ext1.equals("png"))
						out.print ("<IMG SRC='/chap11/upfile/" + upfile1 +"' WIDETH = 100 HEIGHT = 100>");
					else
						out.print ("<IMG SRC='/chap11/icon_file.gif'> " + upfile1);
				}
				if (upfile2 != null) {
					ext2 = ext2.toLowerCase();
					if (ext2.equals("jpg") || ext2.equals("bmp") || ext2.equals("gif") || ext2.equals("png"))
						out.print ("<BR><IMG SRC='/chap11/upfile/" + upfile2 +"' WIDETH = 100 HEIGHT = 100>");
					else
						out.print ("<BR><IMG SRC='/chap11/icon_file.gif'> " + upfile2);
				}
%>
				</TD>
			</TR>
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">내용</TD>
				<TD WIDTH = "60%" ALIGN = "left">
					<TEXTAREA NAME="contents" ROWS=5 COLS=50></TEXTAREA>
				</TD>
			</TR>
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">첨부파일1</TD>
				<TD WIDTH = "60%" ALIGN = "left">
					<INPUT TYPE ="file" NAME="file1" >
				</TD>
			</TR>
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">첨부파일2</TD>
				<TD WIDTH = "60%" ALIGN = "left">
					<INPUT TYPE ="file" NAME="file2" >
				</TD>
			</TR>
			<TR>
	<TR>
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
<%
} //try end
catch(SQLException e1){
	out.println(e1.getMessage());
} // catch SQLException end

catch(Exception e2){
	e2.printStackTrace();
} // catch Exception end

finally{
	if (pstmt != null) pstmt.close();
	if (rs    != null) rs.close();
	if (con   != null) con.close();
} // finally end
%>
</html>
