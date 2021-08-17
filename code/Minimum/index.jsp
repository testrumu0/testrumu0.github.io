<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>쇼핑몰 모형</title>

<link href="/chap11/includes/all.css" rel="stylesheet" type="text/css" />

</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
		<table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="/chap11/includes/top.inc" %>
      <tr>
        <td height="284"><img src="/chap11/icons/main.jpg" width="815" height="284" alt="메인" /></td>
      </tr>
			<%
				ResultSet rs = null;
				Statement stmt  = con.createStatement();

				String SQL = "select * from goodsinfo a where a.best_YN = 'Y'";
				rs = stmt.executeQuery(SQL);
			%>
      <tr>
        <td height="239" align="center" valign="top">
					<table width="800" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="45" align="left" class="new_tit">추천상품</td>
            <td height="45" colspan="3" align="right" class="new_tit"><a href="goodsdisplayAll.jsp">more</a></td><!---ROOMS로 이동--->
          </tr>
          <tr>
					<%
						int cnt = 0;
						while (rs.next()){
							String goodscd		= rs.getString("goodscd");
							String goodsnm		= rs.getString("goodsnm");

							int unitprice			= rs.getInt("unitprice");
							String goodsimg1	= rs.getString("goodsimg1");
					%>
            <td width="200" align="center" valign="top">
						<table width="190" border="0" cellspacing="0" cellpadding="0"><!-- table4-->
              <tr>
                <td align="center"><a href="goodsdetail.jsp?pgoodscd=<%= goodscd %>"><img src="/chap11/images/<%= goodsimg1 %>" width="170" height="170" border="0" /></a></td>
              </tr>
              <tr>
                <td height="50" align="center"><a href="/chap11/goodsdetail.jsp?pgoodscd=<%= goodscd %>"><%= goodsnm %><br />
								<% 		
										DecimalFormat df = new DecimalFormat("###,###,##0"); 
										out.println(df.format(unitprice));	
								%>
                  원</a></td>
              </tr>
						</table>
						</td>
					<%
						cnt ++;      // 

						if (cnt == 3)
							out.print("</TR><TR>");
						}

						if (cnt != 3)
							out.print("</TR>");
						if (stmt  != null) stmt.close();
						if (rs    != null) rs.close();
						if (con   != null) con.close();
					%>
					</table>
			</tr>
			<%@ include file="/chap11/includes/bottom.inc" %>
	</table> 
</body>
</html>