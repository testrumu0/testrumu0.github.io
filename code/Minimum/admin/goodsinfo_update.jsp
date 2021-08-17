<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE>상품정보변경</TITLE>
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

	if (document.frm1.goodsnm.value == "")
	{
		alert("상품명을 입력하여 주시기 바랍니다.");
		document.frm1.goodsnm.focus();
		return false;
	}

	document.frm1.action = "goodsinfo_update_ok.jsp";
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

function delete_check() {
	document.frm1.action = "goodsinfo_delete_ok.jsp?pgoodscd=" + document.frm1.goodscd.value;
	document.frm1.submit();
}
</script>

<%

	ResultSet rs = null, rs2 = null, rs3 = null;
	Statement stmt = con.createStatement();

try
{
	String pgoodscd = request.getParameter("pgoodscd");

	String strSQL = "SELECT * FROM goodsinfo where goodscd ='" + pgoodscd + "'";
	rs = stmt.executeQuery(strSQL);

	if (rs.next()){

		String cat1cd			= rs.getString("cat1cd");
		String cat2cd			= rs.getString("cat2cd");
		String goodsnm		= rs.getString("goodsnm");
		String best_yn		= rs.getString("best_yn");
		String goodsimg1	= rs.getString("goodsimg1");
		String useflag		= rs.getString("useflag");
		int		 unitprice	= rs.getInt("unitprice");

%>
<BODY>
<FORM NAME = "frm1" METHOD = "post" enctype = "multipart/form-data">
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
            <td width="547" height="45" align="left" class="new_tit">상품등록-정보변경</td>
          </tr>
          <tr>
            <td align="center">
							<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">대분류</td>
									<td width="76%" align="left" bgcolor="#FFFFFF">
										<SELECT NAME="cat1cd" disabled>
											<OPTION VALUE="">==대분류를 선택하세요==</OPTION>
											<%
												strSQL = "SELECT cat1cd, cat1nm FROM category1 order by cat1cd";
												rs2 = stmt.executeQuery(strSQL);

												while (rs2.next()){
													out.print("<OPTION VALUE=\"");
													out.print(rs2.getString("cat1cd"));
													out.print("\"");
													if (rs2.getString("cat1cd").equals(cat1cd))
														out.print (" selected ");
													out.print(">");
													out.print(rs2.getString("cat1nm"));
													out.println("</OPTION>");
											}
											%>
										</SELECT>
									</td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">중분류</td>
									<td width="76%" align="left" bgcolor="#FFFFFF">
										<SELECT NAME="cat2cd" disabled>
											<OPTION VALUE="">==중분류를 선택하세요==</OPTION>
											<%
												if (cat1cd != null && cat1cd != ""){
													strSQL = "SELECT cat1cd, cat2cd, cat2nm FROM category2 where cat1cd = '" + cat1cd + "' order by cat2cd";
													rs3 = stmt.executeQuery(strSQL);

													while (rs3.next()){
														out.print("<OPTION VALUE=\"");
														out.print(rs3.getString("cat2cd"));
														out.print("\"");
														if (rs3.getString("cat2cd").equals(cat2cd))
															out.print (" selected ");
														out.print(">");
														out.print(rs3.getString("cat2nm"));
														out.println("</OPTION>");
													}
												}

											%>
										</SELECT>
									</td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">상품코드</td>
									<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "10" MAXLENGTH = "6" NAME = "goodscd" VALUE=<%= pgoodscd %> readonly></td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">상품명</td>
									<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "30" MAXLENGTH = "50" NAME = "goodsnm" VALUE=<%= goodsnm %>></td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">판매단가</td>
									<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "10" MAXLENGTH = "7" NAME = "unitprice"  VALUE=<%= unitprice %> onKeyDown = "KeyNumber()"></td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">베스트상품여부</td>
									<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "checkbox" NAME = "best_yn"
										<INPUT TYPE = "checkbox" NAME = "best_yn"
										<%
												if (best_yn.equals("Y")) out.print(" checked ");
										%>
										VALUE = "Y">
									</td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">변경전 이미지</td>
									<td width="76%" align="left" bgcolor="#FFFFFF"><IMG SRC="/chap11/images/<%= goodsimg1%>" height=200 width=200></td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">변경후 이미지</td>
									<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "file" NAME = "goodsimg1" size = 50></td>
								</tr>
								<tr>
									<td colspan=2 align=center  bgcolor="#FFFFFF">
									<INPUT TYPE = "button" VALUE = "변경" onclick="valid_check()"><INPUT TYPE = "button" VALUE = "삭제" onclick="delete_check()"></td>
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
<%
	}
	else
	{
			out.print("등록된 상품정보가 없습니다.");
	}

} //try end

catch(SQLException e1){
	out.println(e1.getMessage());
} // catch SQLException end

catch(Exception e2){
	e2.printStackTrace();
} // catch Exception end

finally{
	if (stmt  != null) stmt.close();
	if (rs    != null) rs.close();
	if (rs2   != null) rs2.close();
	if (rs3   != null) rs3.close();
	if (con   != null) con.close();
} // finally end
%>
</HTML>