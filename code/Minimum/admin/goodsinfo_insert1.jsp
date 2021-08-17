<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
  <TITLE> 상품등록(1)</TITLE>
	<link href="/chap11/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>
<%
		String id = (String)session.getAttribute("G_ADMIN_ID");
		if (id == null)	
		{
			out.print("<script type=text/javascript>");
			out.print("alert('관리자 로그인을 하시기 바랍니다.!!!');");
			out.print("location.href = 'admin_index.jsp';");
			out.print("</script>");
		}
%>

<script language=javascript>
function valid_check()
{

	if (document.frm1.cat1cd.value == "")
	{
		alert("대분류를 선택하여 주시기 바랍니다.");
		document.frm1.cat1cd.focus();
		return false;
	}

	if (document.frm1.cat2cd.value == "")
	{
		alert("중분류를 선택하여 주시기 바랍니다.");
		document.frm1.cat2cd.focus();
		return false;
	}

	document.frm1.submit();

}

function KeyNumber()
{
	var event_key = event.keyCode;	

	if((event_key < 48 || event_key > 57) && (event_key != 8 && event_key != 46))
	{
		event.returnValue=false;
	}
}

function cat1cd_Change() {
	var x					= document.frm1.cat1cd.options.selectedIndex;
	var cat1size	= document.frm1.cat1cd.options.length;
	var cat2G			= new Array(cat1size);

	for (i = 0; i < cat1size; i++)
		cat2G[i] = new Array();

	cat2G[0][0]	=	new Option("대분류를 먼저 선택하세요","");
	cat2G[1][0]	=	new Option("==중분류를 선택하세요==","");
	cat2G[1][1]	=	new Option("침대",		"D");
	cat2G[1][2]	=	new Option("옷장",				"P");
	cat2G[1][3]	=	new Option("수납장",			"S");
	cat2G[1][4]	=	new Option("화장대",			"M");

	cat2G[2][0]	=	new Option("==중분류를 선택하세요==","");
	cat2G[2][1]	=	new Option("장식장",				"J");
	cat2G[2][2]	=	new Option("액세서리",			"A");
	cat2G[2][3]	=	new Option("소파",				"F");
	

	cat2G[3][0]	=	new Option("==중분류를 선택하세요==","");
	cat2G[3][1]	=	new Option("식탁",				"H");
	cat2G[3][2]	=	new Option("수납장",		    "S");
	cat2G[3][3]	=	new Option("의자",				"V");
	
	
	cat2G[4][0]	=	new Option("==중분류를 선택하세요==","");
	cat2G[4][1]	=	new Option("침대",				"D");
	cat2G[4][2]	=	new Option("책상",		    "T");
	cat2G[4][3]	=	new Option("수납장",		    "S");
	cat2G[4][4]	=	new Option("소파/의자",		    "F");
	cat2G[4][5]	=	new Option("액세서리",		    "A");
	
	
	cat2G[5][0]	=	new Option("==중분류를 선택하세요==","");
	cat2G[5][1]	=	new Option("책상",		"T");
	cat2G[5][2]	=	new Option("책장",				"O");
	cat2G[5][3]	=	new Option("수납장",			"S");
	cat2G[5][4]	=	new Option("의자",			"V");
	


	temp = document.frm1.cat2cd;
	for (m = temp.options.length - 1; m > 0; m--)
	 temp.options[m] = null;

	 for (i = 0; i < cat2G[x].length; i++){
		temp.options[i] = new Option(cat2G[x][i].text, cat2G[x][i].value);
	 }

	 temp.options[0].selected = true;
}

</script>

<BODY>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
		<table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="/chap11/includes/admin_top.inc" %>
      <tr>
        <td height="80" background="/chap11/icons/sub_bg.jpg">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="547" height="45" align="left" class="new_tit">상품등록</td>
          </tr>
          <tr>
			<FORM NAME = "frm1" ACTION = "goodsinfo_insert1_ok.jsp" METHOD = "post" enctype="multipart/form-data">
            <td align="center">
							<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">대분류</td>
									<td width="76%" align="left" bgcolor="#FFFFFF">
										<SELECT NAME="cat1cd" onChange="cat1cd_Change();">
											<OPTION VALUE="">==대분류를 선택하세요==</OPTION>
											<%
												ResultSet rs = null;
												Statement stmt  = con.createStatement();
												String strSQL	= "SELECT cat1cd, cat1nm FROM category1";
												rs	= stmt.executeQuery(strSQL);

												while (rs.next()){
													out.print("<OPTION VALUE=\"");
													out.print(rs.getString("cat1cd"));
													out.print("\">");
													out.print(rs.getString("cat1nm"));
													out.println("</OPTION>");
												}
												stmt.close();
												rs.close();
												con.close();
											%>
											
										<!--	<OPTION VALUE="B">BOTTOM</OPTION>
											<OPTION VALUE="O">OUTER</OPTION>
											<OPTION VALUE="T">TOP</OPTION>-->
										</SELECT>
									</td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">중분류</td>
									<td width="76%" align="left" bgcolor="#FFFFFF">
										<SELECT NAME="cat2cd">
										</SELECT>
									</td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">상품명</td>
									<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "30" MAXLENGTH = "50" NAME = "goodsnm"></td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">판매단가</td>
			 						<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "10" MAXLENGTH = "7" NAME = "unitprice" onKeyDown = "KeyNumber()"></td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">베스트상품여부</td>
									<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "checkbox" NAME = "best_yn"></td>
								</tr>						
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">이미지</td>
									<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "file" NAME = "goodsimg1" size = 50></td>
								</tr>
								<tr>
									<td colspan=2 align=center  bgcolor="#FFFFFF"><INPUT TYPE = "button" VALUE = "등록" onclick="valid_check()"></td>
								</tr>
						</FORM >
          <tr>
        </td>
      </tr>
		</table>
    </td>
  </tr>
</table>
</BODY>
</HTML>