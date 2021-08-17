<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>
<HTML>
<HEAD>
  <TITLE> 마이페이지</TITLE>
<link href="/chap11/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>

<script type="text/javascript">



function delChk() {

	document.frm1.action = "mypage_Delete.jsp";
	document.frm1.submit();
}

function allCheck(){ // chkAll 체크박스로 전체 체크박스들을 체크하거나 체크를 해제 함
	var  chkArr				= document.getElementsByName('chkName'); 
	var  chkArr_size	=	chkArr.length;
	var	 tot					= 0;

	if(document.frm1.chkAll.checked == true){
		for(var i = 1; i <= chkArr_size; i ++ ){	
			var temp			= "document.getElementById('chkId" + i + "').checked = true";
			eval(temp);
	
			var valPrice	= eval("document.frm1.unitPriceId"+ i + ".value");
			var valQty		= eval("document.frm1.qtyId" + i +".value");	

			tot						= tot + valPrice * valQty;
		}

		totViewCreate(tot);

	}else{
		for(var i = 1; i <= chkArr_size; i ++ ){	
			var  temp = "document.getElementById('chkId" + i + "').checked = false";
			eval(temp);
		}

		totViewCreate(0);

	}
}

function allSelReset(){ // chkAll 전체를 체크한 후에 개별 row의 체크박스를 체크 해제할 때 chkAll을 reset
	var  chkArr				= document.getElementsByName('chkName'); 
	var  chkArr_size	=	chkArr.length;
	var	 tot					= 0;
	var  cnt					= 0;

	for(var i = 1; i <= chkArr_size; i ++){	
		var  temp = "document.getElementById('chkId" + i + "').checked";
		var  rv = eval(temp);	
		if ( rv == true ) 
		{
			var valPrice	= eval("document.frm1.unitPriceId"+ i + ".value");
			var valQty		= eval("document.frm1.qtyId" + i +".value");	

			tot						= tot + valPrice * valQty;
			cnt						= cnt + 1;
		}
		else
		{
		document.frm1.chkAll.checked = false;
		}
	}
	
	if (cnt == chkArr_size) 
		{document.frm1.chkAll.checked = true;}	
	else
		{document.frm1.chkAll.checked = false;}	

	totViewCreate(tot);
}


</script>

<BODY>
<FORM NAME = frm1 METHOD = POST>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top"><table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="/chap11/includes/top.inc" %>
      <tr>
        <td height="80" background="/chap11/icons/sub_bg.jpg">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="547" height="45" align="left" class="new_tit">마이페이지</td>
            <td width="300" align="right">HOME &gt; 마이페이지</td>
          </tr>
		  <tr>
		  <td style="font-size:12px; font-weight:bold;">나의 관심 상품</td>
			<td height="30" style="font-size:12px;float:right;">
					<div class="div">정렬하기</div>
					<div class="div">
		<%
		String in_compare_key	= request.getParameter("compare_key");
		if (in_compare_key == null) in_compare_key = "";
		
		String compare_val = "a.goodscd desc";
		%>
	<FORM NAME=frm1 ACTION="mypage.jsp" METHOD=post>	
	<SELECT  NAME = "compare_key">
		<OPTION VALUE="lp">낮은 가격순</OPTION>
		<OPTION VALUE="hp">높은 가격순</OPTION>
		<OPTION VALUE="ra"> 평점순</OPTION>
	</SELECT>
		<INPUT TYPE = submit VALUE = "선택">
	</FORM>
			</div>
			</td>
		  </tr>
          <tr>
            <td colspan="2" align="left" valign="top">
				<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
              <tr>
                <td width="5%" align="center" bgcolor="#EEEEEE">선택 
					<INPUT type = checkbox name = "chkAll" onClick = "allCheck()"></td>
                <td width="20%" align="center" bgcolor="#EEEEEE">상품이미지</td>
                <td width="15%" align="center" bgcolor="#EEEEEE">상품코드</td>
                <td width="20%" align="center" bgcolor="#EEEEEE">상품명</td>
				<td width="25%" align="center" bgcolor="#EEEEEE">평점</td>
                <td width="15%" align="center" bgcolor="#EEEEEE">단가</td>
              </tr> 
							<%

							String userid			=	(String)session.getAttribute("G_ID");
							PreparedStatement pstmt  = null;
							ResultSet rs = null;
							DecimalFormat df	= new DecimalFormat("###,###,##0"); 
							int amt						= 0;
							int totAmt				= 0;
							
							if(in_compare_key.equals("lp")){
								compare_val = "a.unitprice";
							}else if(in_compare_key.equals("hp")){
								compare_val = "a.unitprice desc";
							}else if(in_compare_key.equals("ra")){
								compare_val = "a.rate desc";
							}
							
							
							String SQL = "select a.*,b.goodscd, b.goodsnm, b.goodsimg1 ,c.* from wishlist a inner join goodsinfo b on a.goodscd = b.goodscd inner join colorinfo c on a.color = c.colorcd where a.userid = ? order by "+ compare_val+" ";
								pstmt = con.prepareStatement(SQL);
								pstmt.setString(1,userid);
								rs = pstmt.executeQuery();
							int cnt = 0;
							int i		= 0;
							while(rs.next()){
								i ++;
								String goodscd		= rs.getString("goodscd");
								String goodsnm		= rs.getString("goodsnm");
								String colornm		= rs.getString("colornm");
								int unitPrice			= rs.getInt("unitprice");
								int idx = rs.getInt("idx");
								String chkYN = rs.getString("chkYN");
								String goodsimg1	= rs.getString("goodsimg1");
								int goodsrate = rs.getInt("rate");



							%>

								<tr align="center">      
									<INPUT type = hidden name = "idx" value = "<%= idx %>">
									<td align="center" bgcolor="#FFFFFF"><INPUT type = checkbox name = "chkName" value = "<%= idx %>" id = "chkId<%= i %>"
										<% if (chkYN.equals("Y")) {
													out.print(" checked ");
													cnt ++;
												}
										%> 
										onClick = "allSelReset()"></td>  
									<td align="center" bgcolor="#FFFFFF"><IMG src="/chap11/images/<%= goodsimg1 %>" height = 50 width = 50></a></td>
									<td align="center" bgcolor="#FFFFFF"><a href="goodsdetail.jsp?pgoodscd=<%=goodscd%>"><%= goodscd%></a></td>
									<td align="center" bgcolor="#FFFFFF"><%= goodsnm%>
										<ul style="padding-left:0px;">
											<li><%= colornm%></li>
										</ul>
									</td>
									<td align="center" bgcolor="#FFFFFF">
										<ul style="padding-left:0px; padding-top:5px;">
											<li>평점<%
													for(int j = 1; j<= goodsrate; j++){
														out.print("★");
													}
											%></li>
										</ul>
									</td>
									
									<td align="center" bgcolor="#FFFFFF"><%= df.format(unitPrice)%></td>
									<INPUT type = "hidden" name = "unitPrice" value = <%=unitPrice%> id = "unitPriceId<%=i%>"></td>
								</tr>
							<tr>
							<%
							}
							if ( i == cnt ){
								out.print("<script type='text/javascript'>");
								out.print("document.frm1.chkAll.checked = true;");
								out.print("</script>");
							}
							%>
					</table>
					</td>
		  	</tr>
				</table></td>
			</tr>

			<tr>
				<td height="25" align="center">
					<input type = "button" id = "button"  value = "선택상품삭제"  onClick = "delChk();"/>
				</td>
			</tr>
			<%@ include file="/chap11/includes/bottom.inc" %>
</table>
<%
if (pstmt  != null) pstmt.close();
if (rs    != null) rs.close();
if (con   != null) con.close();
%>
</FORM>
</BODY>
</html>