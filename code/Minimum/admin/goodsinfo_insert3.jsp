<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE>상품등록(3)</TITLE>
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


function getXMLHttpRequest() {
	if (window.ActiveXObject) {
		try {
			return new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				return new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e1) {
				return null;
			}
		}
	} else if (window.XMLHttpRequest) {
		return new XMLHttpRequest();
	} else {
		return null;
	}
}

function processEvent() {
	httpRequest = getXMLHttpRequest();
	httpRequest.onreadystatechange = callbackFunction;
	httpRequest.open("GET", "/chap11/goodsinfo_insert_ajax_svr.jsp?cat1cd=" + document.frm1.cat1cd.value, true);
	httpRequest.send(null);
}

function callbackFunction() {

	if (httpRequest.readyState == 4) {//객체 상태, 데이타 사용가능 상태 데이터의 전부를 받음
		if (httpRequest.status == 200) {
			var m_len; // 현재의 중분류 태그 배열 개수 (1, 2, ....)
			cat2cd_size = document.frm1.cat2cd.length;
			j = cat2cd_size - 1;

			// 현재의 중분류 태그의 option절 마지막 부터 지움							
			for ( var i = 0; i < cat2cd_size; i++) {
				document.frm1.cat2cd.options[j] = null;
				j = j - 1;
			}
			var arr = new Array();
			var rTxt;
			rTxt = httpRequest.responseText;
			rTxt = rTxt.replace(/\r/g, '');
			rTxt = rTxt.replace(/\n/g, '');
//alert(rTxt);
			//			rTxt = rTxt.substr(4, rTxt.length - 4);
			arr = rTxt.split("|");
			//			alert(arr[0]);

			for ( var i = 0; i < arr.length - 1; i++) {
				var new_value, new_text
				new_value = arr[i].substr(0, 1);
				new_text = arr[i].substr(1, arr[i].length - 1);
				//				alert(new_value + new_value.length);
				var new_option = new Option(new_text, new_value);
				document.frm1.cat2cd.options[i] = new_option;
			}
		} else {
			alert("fail : " + httpRequest.status);
		}
	}
}

</script>

<%

	ResultSet rs = null, rs2 = null;
	Statement stmt  = con.createStatement();

try{

	String strSQL  = "SELECT cat1cd, cat1nm FROM category1 ORDER BY cat1cd";
	rs = stmt.executeQuery(strSQL);

%>
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
										<SELECT NAME="cat1cd" onchange="processEvent()">
											<OPTION VALUE="">==대분류를 선택하세요==</OPTION>
											<%

											String	cat1cd_1st = null;
											int   	ii         = 1;
											while (rs.next()){
												if (ii == 1)
													cat1cd_1st = rs.getString("cat1cd");

												out.print("<OPTION VALUE=\"");
												out.print(rs.getString("cat1cd"));
												out.print("\"");
												if (ii == 1)
													out.print (" selected ");
												out.print(">");
												out.print(rs.getString("cat1nm"));
												out.println("</OPTION>");

												ii++;
											}
											%>
										</SELECT>
									</td>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">중분류</td>
									<td width="76%" align="left" bgcolor="#FFFFFF">
										<SELECT NAME="cat2cd">
											<OPTION VALUE="">==중분류를 선택하세요==</OPTION>
											<%
											if (rs    != null) rs.close();
											strSQL = "SELECT cat1cd, cat2cd, cat2nm FROM category2 ORDER BY cat1cd, cat2cd";
											rs = stmt.executeQuery(strSQL);

											while (rs.next()){
												if (rs.getString("cat1cd").equals(cat1cd_1st)) {
													out.print("<OPTION VALUE=\"");
													out.print(rs.getString("cat2cd"));
													out.print("\">");
													out.print(rs.getString("cat2nm"));
													out.println("</OPTION>");
												}
											}
											%>
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
	if (stmt  != null) stmt.close();
	if (rs    != null) rs.close();
	if (con   != null) con.close();
} // finally end
%>
</HTML>