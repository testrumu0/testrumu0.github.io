<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*, java.util.Calendar" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>
<HTML>
<HEAD>
  <TITLE> 주문 완료</TITLE>
	<link href="/chap11/includes/all.css" rel="stylesheet" type="text/css" />

</HEAD>
<%

			String userid	 =	(String)session.getAttribute("G_ID");
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String usernm1 = "";
			String addr1 = "";
			String telno1 = "";
			String usernm2 = "";
			String addr2 = "";
			String telno2 = "";
			
			String goodscd		= ""; //goodsinfo,order_D
			String goodsnm		= ""; //goodsinfo
			String colornm		= ""; //order_D
			String sizenm		= ""; //order_D
			String colorcd		= ""; //order_D
			String sizecd			= ""; //order_D
			String goodsimg1	= ""; //goodsinfo
			String OrdNo	= ""; //order_D
			int deliState	= 0; //deliveryinfo
			
			int unitPrice	= 0;
			int qty			= 0;
			int amt			= 0;
			int totAmt		= 0;
			
			int st01 = 0;  //주문배송현황 변수
			int st02 = 0;
			int st03 = 0;
			int st04 = 0;
			
			
			DecimalFormat df1	= new DecimalFormat("00"); 
			DecimalFormat df2	= new DecimalFormat("###,###,##0"); 
			
			String SQL = "";
			

			 SQL = "select ordNo from order_H where userid = ?";
			 pstmt = con.prepareStatement(SQL);
			 pstmt.setString(1,userid);
			 rs = pstmt.executeQuery();
			 
			 while(rs.next()){
				 OrdNo = rs.getString("ordNo");			 
			 }rs.close();
			 
			 

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
            <td width="547" height="45" align="left" class="new_tit">주문 배송 조회</td>
            <td width="253" align="right">HOME &gt; 주문 배송 조회</td>
            </tr>
          <tr>
            <td colspan="2" align="left" valign="top">
			<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
              <tr>
                <td width="10%" align="center" bgcolor="#EEEEEE">상품이미지</td>
                <td width="20%" align="center" bgcolor="#EEEEEE">상품명</td>
                <td width="10%" align="center" bgcolor="#EEEEEE">상품색상</td>
                <td width="10%" align="center" bgcolor="#EEEEEE">상품크기</td>
                <td width="10%" align="center" bgcolor="#EEEEEE">단가</td>
                <td width="10%" align="center" bgcolor="#EEEEEE">수량</td>
                <td width="10%" align="center" bgcolor="#EEEEEE">금액</td>
				<td width="20%" align="center" bgcolor="#EEEEEE">처리현황</td>
              </tr>
			
<%
String strSQL = "select a.*, b.*, c.goodsnm, c.goodsimg1, d.colornm, e.sizenm, f.usernm, g.* from order_H a ";
strSQL = strSQL + " inner join order_D b on a.ordNo = b.ordNo ";
strSQL = strSQL + " inner join goodsinfo	c on b.goodscd = c.goodscd ";
strSQL = strSQL + " inner join colorinfo d on b.color = d.colorcd ";
strSQL = strSQL + " inner join sizeinfo e on b.size = e.sizecd ";
strSQL = strSQL + " inner join members	f on a.userid = f.userid ";
strSQL = strSQL + " inner join deliveryinfo	g on b.ordNo = g.ordNo ";
strSQL = strSQL + " where a.userid = '" + userid + "' and a.ordNo = '" + OrdNo + "'";
strSQL = strSQL + " order by ordSeq";

Statement stmt		= con.createStatement();

rs = stmt.executeQuery(strSQL);

while(rs.next()){

	goodscd			= rs.getString("goodscd");
	goodsnm			= rs.getString("goodsnm");
	colornm			= rs.getString("colornm");
	sizenm			= rs.getString("sizenm");
	unitPrice		= rs.getInt("unitprice");
	qty					= rs.getInt("ordQty");
	amt					= rs.getInt("ordAmt");
	goodsimg1		= rs.getString("goodsimg1");
	deliState = Integer.parseInt(rs.getString("stat"));
	


%>				<!--주문상품정보---->
              <tr>

                <td align="center" bgcolor="#FFFFFF"><img src="/chap11/images/<%= goodsimg1 %>" width="40" height="40" /></td>
                <td align="center" bgcolor="#FFFFFF"><%= goodsnm					%></td>
                <td align="center" bgcolor="#FFFFFF"><%= colornm					%></td>
                <td align="center" bgcolor="#FFFFFF"><%= sizenm						%></td>
                <td align="center" bgcolor="#FFFFFF"><%= df2.format(unitPrice)%></td>
                <td align="center" bgcolor="#FFFFFF"><%= qty							%></td>
                <td align="center" bgcolor="#FFFFFF"><%= df2.format(amt)	%></td>
				<td align="center" bgcolor="#FFFFFF">
					<%
					if(deliState==1){
						out.print("입금 전");
					}else if(deliState==2){
						out.print("배송 준비 중");
					}else if(deliState==3){
						out.print("배송 중");
					}else if(deliState==4){
						out.print("배송완료");
					}											
					
					%>
				</td>
              </tr>

<%
}
%>
            </table></td>
            </tr>
        
	  <!--주문처리현황---->
	  <tr>
		<td width="547" height="45" align="left" style="font-size:12px; font-weight:bold;">주문 처리 현황</td>
	  </tr>
	  <table width="800" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
		  <tr>
			 <td width="20%" align="center" bgcolor="#EEEEEE">입금 전</td>
			 <td width="20%" align="center" bgcolor="#EEEEEE">배송 준비 중</td>
			 <td width="20%" align="center" bgcolor="#EEEEEE">배송 중</td>
			 <td width="20%" align="center" bgcolor="#EEEEEE">배송 완료</td>
			 <td width="20%" align="center" bgcolor="#EEEEEE">주문 내역</td>
		  </tr>
			<%
				SQL = "select count(stat) from deliveryinfo where stat = '1' AND userid = ?";
				pstmt = con.prepareStatement(SQL);	
				pstmt.setString(1,userid);
			    rs = pstmt.executeQuery();
				
			if(rs.next()){
               st01= rs.getInt(1);
            }rs.close();	

				SQL = "select count(stat) from deliveryinfo where stat = '2' AND userid = ?";
				pstmt = con.prepareStatement(SQL);	
				pstmt.setString(1,userid);
			    rs = pstmt.executeQuery();
				
			if(rs.next()){
               st02= rs.getInt(1);
            }
            rs.close();		


				SQL = "select count(stat) from deliveryinfo where stat = '3' AND userid = ?";
				pstmt = con.prepareStatement(SQL);	
				pstmt.setString(1,userid);
			    rs = pstmt.executeQuery();
				
			if(rs.next()){
               st03= rs.getInt(1);
            }
            rs.close();				
			
				SQL = "select count(stat) from deliveryinfo where stat = '4' AND userid = ?";
				pstmt = con.prepareStatement(SQL);	
				pstmt.setString(1,userid);
			    rs = pstmt.executeQuery();
				
			if(rs.next()){
               st04= rs.getInt(1);
            }
            rs.close();	
			%>

		  <tr>
			  <td align="center" bgcolor="#FFFFFF"><%=st01%></td>
              <td align="center" bgcolor="#FFFFFF"><%=st02%></td>
              <td align="center" bgcolor="#FFFFFF"><%=st03%></td>
              <td align="center" bgcolor="#FFFFFF"><%=st04%></td>
              <td align="center" bgcolor="#FFFFFF">
				<ul style="padding-left:0;">
					<li>취소[0]</li>
					<li>교환[0]</li>
					<li>환불[0]</li>
				</ul>
			  </td>
		  </tr>
	  </table><!--주문처리현황---->
	  
	  </table></td>
      </tr>


<FORM NAME = frm1 ACTION = "index.jsp" METHOD = POST>
      <tr>

		<td align="center">
				<br><br>
		<table width="800" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">

<%
			SQL = "select usernm,addr1,telno from members where userid = ?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1,userid);
			rs = pstmt.executeQuery();

								
			while(rs.next()){
			 usernm1 = rs.getString("usernm");
			 addr1 = rs.getString("addr1");
			 telno1 = rs.getString("telno");

%>			<!--주문자정보---->
          <tr>
            <td colspan="2" align="left" bgcolor="#EEEEEE">주문자 정보</td>
            </tr>
          <tr>
            <td width="24%" align="left" bgcolor="#FFFFFF">주문자 성명</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><%=usernm1%></td>
            </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF">주문자 주소</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><%=addr1%></td>
          </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF">주문자 전화</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><%=telno1%></td>
          </tr>
<%
	}rs.close(); //members종료
	


			SQL = "select top 1 deliUserName,deliAddr,deliTelno from order_H where userid = ? order by ordNo desc";
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1,userid);
			rs = pstmt.executeQuery();

								
			while(rs.next()){
			 usernm2 = rs.getString("deliUserName");
			 addr2 = rs.getString("deliAddr");
			 telno2 = rs.getString("deliTelno");

%>		  	  <!--받는자정보---->
          <tr>
            <td colspan="2" align="left" bgcolor="#EEEEEE">받는자 정보</td>
            </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF">받는자 성명</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><%= usernm2 %></td>
          </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF">받는자 주소</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><%= addr2 %></td>
          </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF">받는자 전화</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><%= telno2 %></td>
          </tr>
        </table>
		</td>
      </tr>
	<%
		}
	%>	
      <tr>
        <td height="50" align="center">
          <input type="submit" id="button2" value="메인으로 이동"/>
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
</html>
<%

 rs.close();
 con.close();
 pstmt.close();
%>