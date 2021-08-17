<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>

<!DOCTYPE html>
<HTML>
<HEAD>
  <TITLE>주문배송관리</TITLE>
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
		
			String SQL = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
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
            <td width="547" height="45" align="left" class="new_tit">주문배송 관리</td>
          </tr>
		  <%
				SQL = "select a.ordNo, a.ordDtm, a.userid, a.deliUserName, a.deliAddr, b.ordNo, b.goodscd, c.ordNo, c.stat from order_H a ";
				SQL = SQL + "inner join order_D b on a.ordNo = b.ordNo inner join deliveryinfo c on a.ordNo = c.ordNo ";					
				pstmt = con.prepareStatement(SQL);
				rs = pstmt.executeQuery();

		  %>
		  
          <tr>
						<!--<FORM NAME = "frm1" ACTION = "deliveryinfo_insert_ok.jsp" METHOD = "post" >-->
						<td align="center">
							<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
									<tr>
										<td width="15%" align="center" bgcolor="#EEEEEE">사용자 아이디</td>
										<td width="10%" align="center" bgcolor="#EEEEEE">상품번호</td>
										<td width="10%" align="center" bgcolor="#EEEEEE">주문번호</td>
										<td width="25%" align="center" bgcolor="#EEEEEE">주문날짜</td>
										<td width="20%" align="center" bgcolor="#EEEEEE">배송지</td>
										<td width="20%" align="center" bgcolor="#EEEEEE">주문 배송 현황</td>
								   </tr>
								   <%
																	
									while(rs.next()){

										String user = rs.getString("userid");
										String OrdNo = rs.getString("ordNo");
										String goodscd = rs.getString("goodscd");
										String OrdDate = rs.getString("ordDtm");
										String addr = rs.getString("deliAddr");
										int delistate = Integer.parseInt(rs.getString("stat"));
										

								   %>
								   <tr>
										<td align="center" bgcolor="#FFFFFF"><%= user%></td>
										<td align="center" bgcolor="#FFFFFF"><a href="/chap11/admin/deliveryinfo_insert.jsp?pgoodscd=<%= goodscd %>"><%= goodscd %></a></td>
										<td align="center" bgcolor="#FFFFFF"><%= OrdNo	%></td>
										<td align="center" bgcolor="#FFFFFF"><%= OrdDate	%></td>
										<td align="center" bgcolor="#FFFFFF"><%= addr%></td>
										<td align="center" bgcolor="#FFFFFF">
										<%
										if(delistate==1){
											out.print("입금 전");
										}else if(delistate==2){
											out.print("배송 준비 중");
										}else if(delistate==3){
											out.print("배송 중");
										}else if(delistate==4){
											out.print("배송완료");
										}											
										
										%>
										</td>
								  </tr>														
						<%
							}
							con.close();
							pstmt.close();
							rs.close();
						%>
						<!--</FORM >-->
						<tr>
							<td colspan = 6 align="center" bgcolor="#FFFFFF"><a href="/chap11/admin/deliveryinfo_insert.jsp">등록</a></td>
						</tr>
          <tr>
        </td>
      </tr>
		</table>
    </td>
  </tr>
</table>
</BODY>
</HTML>