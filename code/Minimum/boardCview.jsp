﻿<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
  <TITLE>공지사항 보기</TITLE>
	<link href="/chap11/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>
<script language=javascript>
function submit_modify()
{
	document.frm1.action = "boardCmodify.jsp";
	document.frm1.submit();
}

function submit_reply()
{
	document.frm1.action = "boardCreply.jsp";
	document.frm1.submit();
}

function submit_delete()
{
	document.frm1.action = "boardCdelConfirm.jsp";
	document.frm1.submit();
}

function submit_list()
{
	document.frm1.action = "boardClist.jsp";
	document.frm1.submit();
}
</script>
<%
	int num = Integer.parseInt(request.getParameter("pnum"));

	PreparedStatement pstmt = null;
	ResultSet rs = null;

try
{

	String strSQL = "SELECT num, lock_yn, pwd, title, contents, upfile1, upfile2, writer, CONVERT(CHAR(10), updatedtm, 120) writedt, readcnt FROM boardC WHERE num = ?";
	pstmt	= con.prepareStatement(strSQL);
	pstmt.setInt(1, num);
	rs		= pstmt.executeQuery();

	if (rs.next() == false){
		out.print("등록된 게시글이 없습니다.");
	}
	else
	{
		String in_pwd	= request.getParameter("pwd");
		String db_pwd	= rs.getString("pwd");
		String lock_yn	= rs.getString("lock_yn");

		if (lock_yn.equals("Y")) {

			if (in_pwd == null ) 
				response.sendRedirect("boardCpass_input.jsp?pnum=" + num);
			else
				if (in_pwd.equals(db_pwd) == false)
					response.sendRedirect("boardCpass_input.jsp?pnum=" + num);

		} //if (lock_yn.equals("Y")) end

		String writer	= rs.getString("writer");
		String title	= rs.getString("title");
		String contents = rs.getString("contents");
		String writedt  = rs.getString("writedt");
		int readcnt		= rs.getInt("readcnt");
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

		strSQL = "UPDATE boardC SET readcnt = readcnt + 1 WHERE num = ?"; // 조회수를 증가
		pstmt = con.prepareStatement(strSQL);
		pstmt.setInt(1, num);
		pstmt.executeUpdate();

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
				<td width="253" align="right">HOME &gt; QnA &gt; 게시글 보기</td>
            </tr>
          <tr>
            <td colspan="2" align="left" valign="top" style="padding-left:150px;">
			<TABLE WIDTH = "500" BORDER = "1" CellPadding = "0" CellSpacing = "0">
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">작성자명</TD>
				<TD WIDTH = "60%" ALIGN = "left"><%= writer %></TD>
			</TR>
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">제목</TD>
				<TD WIDTH = "60%" ALIGN = "left"><%= title %></TD>
			</TR>
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">첨부</TD>
				<TD WIDTH = "60%" ALIGN = "left">
<%
				if (upfile1 != null) {
					ext1 = ext1.toLowerCase();
					if (ext1.equals("jpg") || ext1.equals("bmp") || ext1.equals("gif") || ext1.equals("png"))
						out.print ("<IMG SRC='/chap11/upfile/" + upfile1 +"' WIDETH = 100 HEIGHT = 100>");
					else
						out.print ("<A HREF='boardCfiledown.jsp?pnum=" + num +"&ftype=1'><IMG SRC='/chap11/icon_file.gif'> " + upfile1 + "</A>");
				}
				if (upfile2 != null) {
					ext2 = ext2.toLowerCase();
					if (ext2.equals("jpg") || ext2.equals("bmp") || ext2.equals("gif") || ext2.equals("png"))
						out.print ("<BR><IMG SRC='/chap11/upfile/" + upfile2 +"' WIDETH = 100 HEIGHT = 100>");
					else
						out.print ("<BR><A HREF='boardCfiledown.jsp?pnum=" + num +"&ftype=2'><IMG SRC='/chap11/icon_file.gif'> " + upfile2 + "</A>");
				}
%>
				</TD>
			</TR>
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">내용</TD>
				<TD WIDTH = "60%" ALIGN = "left">
					<TEXTAREA NAME="contents" ROWS=5 COLS=50 readonly><%= contents %></TEXTAREA>
				</TD>
			</TR>
			<TR>
				<TD WIDTH = "100%" ALIGN = "center" COLSPAN = "2">
				<FORM NAME = "frm1" METHOD = "post">
				<INPUT TYPE = "hidden" NAME = "pnum"  VALUE = <%= num %>>
				<TABLE>
					<TR>
						<TD  ALIGN = "center">
							<INPUT TYPE = "button" VALUE = "수정하기" onclick = "submit_modify()">
						</TD>
						<TD   ALIGN = "center">
							<INPUT TYPE = "button" VALUE = "답변달기" onclick = 'submit_reply();'>
						</TD>
						<TD  ALIGN = "center">
							<INPUT TYPE = "button" VALUE = "삭제하기" onclick = "submit_delete()">
						</TD>
						<TD  ALIGN = "center">
							<INPUT TYPE = "button" VALUE = "목록으로" onclick = "submit_list()">
						</TD>
					</TR>
				</TABLE>
				</FORM>
				</TD>
			</TR>
		</TABLE>
	  
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

	} // if (rs.next() == false) else end

} //try end
/*
catch(SQLException e1){
	out.println(e1.getMessage());
} // catch SQLException end

catch(Exception e2){
	e2.printStackTrace();
} // catch Exception end
*/
finally{
	if (pstmt != null) pstmt.close();
	if (rs    != null) rs.close();
	if (con   != null) con.close();
} // finally end
%>
</html>
