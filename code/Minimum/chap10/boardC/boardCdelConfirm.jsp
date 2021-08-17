<%@ page language="java" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE>답변형 게시판 삭제 확인</TITLE>
 </HEAD>

<script language=javascript>
function submit_delete()
{
	document.frm1.action = "boardCdelete_ok.jsp";
	document.frm1.submit();
}

function submit_list()
{
	document.frm1.action = "boardClist.jsp";
	document.frm1.submit();
}

</script>
<%@ include file = "/chap10/include/dbinfo.inc" %>

<%
PreparedStatement pstmt = null;
ResultSet rs = null;

try
{
	int num = Integer.parseInt(request.getParameter("pnum"));

	String strSQL = "SELECT num, title, contents, writer FROM boardC WHERE num = ?";
	pstmt = con.prepareStatement(strSQL);
	pstmt.setInt(1, num);
	rs = pstmt.executeQuery();

	if (rs.next() == false)
		out.print("등록된 게시물이 없읍니다.");
	else
	{
		String writer	= rs.getString("writer");
		String title	= rs.getString("title");
		String contents = rs.getString("contents");
%>

		<h3>답변형 게시판 삭제 확인</h3>
		<BODY>
		<FORM NAME = "frm1" METHOD = "post">
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
				<TD WIDTH = "60%" ALIGN = "left"><%= title %></TD>
			</TR>
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">내용</TD>
				<TD WIDTH = "60%" ALIGN = "left"><%= contents %></TD>
			</TR>
			<TR>
				<TD WIDTH = "100%" ALIGN = "center" COLSPAN = "2">
				<TABLE>
					<TR>
						<TD WIDTH = "50%" ALIGN = "center">
							<INPUT TYPE = "button" VALUE = "삭제완료" onclick = "submit_delete()">
						</TD>
						<TD WIDTH = "50%" ALIGN = "center">
							<INPUT TYPE = "button" VALUE = "목록으로" onclick = "submit_list()">
						</TD>
					</TR>
				</TABLE>
				</FORM>
				</TD>
			</TR>
		</TABLE>
		</BODY>
	<%
	} // if (rs.next() == false) else end

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
</HTML>