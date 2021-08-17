<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>

<HTML>
 <HEAD>
  <TITLE>답변형 게시판 글쓰기</TITLE>
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

	if (document.frm1.pwd_chk.checked == true && document.frm1.pwd.value == "") 
	{
		alert("비빌번호를 입력바랍니다");
		document.frm1.pwd.focus(); 
		return false;
	}

	if (document.frm1.pwd_chk.checked == false && document.frm1.pwd.value != "") 
	{
		alert("비밀글 여부를 체크 바랍니다");
		document.frm1.pwd_chk.focus(); 
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
	document.frm1.action = "boardClist.jsp";
	document.frm1.submit();
}

 </script>
<h3>답변형 게시판 글쓰기</h3>
<BODY>
<FORM NAME = "frm1" ACTION = "boardCwrite_ok.jsp" METHOD = "post" ENCTYPE="multipart/form-data">
<TABLE WIDTH = "600" BORDER = "1" CellPadding = "0" CellSpacing = "0">
	<TR>
		<TD WIDTH = "40%" ALIGN = "left">작성자명</TD>
		<TD WIDTH = "60%" ALIGN = "left">
			<INPUT TYPE = "text" SIZE = "15" MAXLENGTH = "10" NAME = "writername">
		</TD>
	</TR>
	<TR>
		<TD WIDTH = "40%" ALIGN = "left">제목</TD>
		<TD WIDTH = "60%" ALIGN = "left">
			<INPUT TYPE ="text" NAME="title" SIZE = "50" MAXLENGTH = "50">
		</TD>
	</TR>
	<TR>
		<TD WIDTH = "40%" ALIGN = "left">비밀글</TD>
		<TD WIDTH = "60%" ALIGN = "left">
			비밀글 여부<INPUT TYPE ="checkbox" NAME="pwd_chk" VALUE = "Y"> 비밀글일 경우에 체크<BR>
			비밀번호 <INPUT TYPE ="text" NAME="pwd" SIZE = "10" MAXLENGTH = "10"> 비밀글일 경우에 입력
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
</BODY>
</HTML>