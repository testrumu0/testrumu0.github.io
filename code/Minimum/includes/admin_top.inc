<%@ page contentType="text/html; charset=utf-8" language="java"  %>
      <tr>
        <td height="67"><table width="830" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="223" height="67" rowspan="2" align="center"><a href="admin_index.jsp"><img src="/chap11/icons/logo.gif" width="223" height="67" border="0" /></a></td>
          </tr>
          <tr>
            <td>
            <ul class="ul">
             <li class="admin_list">| <a href="goodslist.jsp" class="navi">상품리스트</a></li>
             <li class="admin_list">| <a href="goodsinfo_insert1.jsp" class="navi">상품등록</a></li>
			 <li class="admin_list">| <a href="deliverylist.jsp" class="navi">주문배송관리</a></li>
             <li class="admin_list">| 
	     
	    <%
		String admin_id = (String)session.getAttribute("G_ADMIN_ID");
		if (admin_id == null)	
			out.print("<a href = \"admin_login.jsp\"  class = \"navi\">로그인</a></li>");
		else
			out.print("<a href = \"admin_logout.jsp\" class = \"navi\">로그아웃</a></li>");
	    %>
          </td>
          </tr>
        </table></td>
      </tr>