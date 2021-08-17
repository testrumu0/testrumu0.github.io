<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
  <TITLE>주문배송 등록</TITLE>
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

	document.frm1.submit();

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
            <td width="547" height="45" align="left" class="new_tit">주문배송 등록</td>
          </tr>
          <tr>
			<FORM NAME = "frm1" ACTION = "deliveryinfo_insert_ok.jsp" METHOD = "post" >
            <td align="center">
							<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">주문번호 선택</td>
									<td width="76%" align="left" bgcolor="#FFFFFF">
										  <SELECT NAME="ordcd">
											<OPTION VALUE="">==주문번호==</OPTION>
											<%
												ResultSet rs = null;
												PreparedStatement pstmt  = null;
												String strSQL = "SELECT ordNo FROM order_H ";
												pstmt = con.prepareStatement(strSQL);
												rs = pstmt.executeQuery();

												while (rs.next()){
													String ordcd = rs.getString("ordNo");
													%>
													<option value="<%=ordcd%>">
													<%
													out.print(ordcd);
													out.println("</OPTION>");
												}
												%>
											</SELECT>
									</td>
											
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">배송상태</td>
									<td width="76%" align="left" bgcolor="#FFFFFF">
										<select NAME = "deliState">
												<option value="">==처리현황==</option>
												<option value="1">입금 전</option>
												<option value="2">배송준비 중</option>
												<option value="3">배송 중</option>
												<option value="4">배송 완료</option>
										</select>
									</td>
								</tr>

								<tr>
									<td colspan=2 align=center  bgcolor="#FFFFFF"><INPUT TYPE = "submit" VALUE = "등록" ></td>
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

	rs.close();
	pstmt.close();
	con.close();	
	%>
</HTML>