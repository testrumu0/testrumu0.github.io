<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
  <TITLE>공지사항 등록</TITLE>
	<link href="/chap11/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>
<script language=javascript>
function submit_modify()
{
	document.frm1.action = "boardCmodify_ok.jsp";
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
	String strSQL = "SELECT num, title, contents, upfile1, upfile2, writer FROM boardC WHERE num = ?";
	pstmt = con.prepareStatement(strSQL);
	pstmt.setInt(1, num);
	rs = pstmt.executeQuery();

	if (rs.next() == false)
		out.print("등록된 게시글이 없읍니다.");
	else
	{
		String writer	= rs.getString("writer");
		String title	= rs.getString("title");
		String contents = rs.getString("contents");
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
        <td align="center" valign="top">
		<table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr>
				<td width="547" height="45" align="left" class="new_tit">고객상담 및 상품문의</td>
				<td width="253" align="right">HOME &gt; QnA &gt; 새글쓰기</td>
            </tr>
          <tr>
            <td colspan="2" align="left" valign="top" style="padding-left:150px;">
			
<FORM NAME = "frm1" ACTION = "boardCmodify_ok.jsp" METHOD = "post" ENCTYPE="multipart/form-data">
		<TABLE WIDTH = "500" BORDER = "1" CellPadding = "0" CellSpacing = "0">
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">번호</TD>
				<TD WIDTH = "60%" ALIGN = "left"><%= num %></TD>
				<INPUT TYPE = "hidden" NAME = "pnum" VALUE = <%= num %>>		
			</TR>
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">작성자명</TD>
				<TD WIDTH = "60%" ALIGN = "left"><%= writer %></TD>
			</TR>
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">제목</TD>
				<TD WIDTH = "60%" ALIGN = "left">
					<INPUT TYPE = "text" SIZE = "50" MAXLENGTH = "50" NAME = "title" VALUE = "<%= title %>">			
				</TD>
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
					<TEXTAREA NAME="contents" ROWS=5 COLS=50><%= contents %></TEXTAREA>
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
				<TD WIDTH = "100%" ALIGN = "center" COLSPAN = "2">
				<TABLE>
					<TR>
						<TD WIDTH = "50%" ALIGN = "center">
							<INPUT TYPE = "button" VALUE = "수정완료" onclick = "submit_modify()">
						</TD>
						<TD WIDTH = "50%" ALIGN = "center">
							<INPUT TYPE = "button" VALUE = "목록으로" onclick = "submit_list()">
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
	} // 	if (rs.next() == false) else end

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
