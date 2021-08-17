<%@ page contentType="text/html; charset=utf-8" language="java"  %>
      <tr>
        <td height="67"><table width="815" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="223" height="67" rowspan="2" align="center"><a href="index.jsp"><img src="/chap11/icons/logo.gif" width="223" height="67" border="0" /></a></td>
            <td width="592" height="30" align="right">
	    
<%
		String id = (String)session.getAttribute("G_ID");
		String nm = (String)session.getAttribute("G_NM");

		if (id == null)	
		{
%>
		    <a href="./../../mem_join6_1.jsp">회원가입</a>| <a href="login.jsp">로그인</a>
<%
		}
		else
		{
%>
			<a href="mem_upd3_1.jsp">회원정보변경</a> | <%= nm %> 님 환영합니다. | <a href="logout.jsp">로그아웃</a>
<%			
		}
%>
	    
	    
	    | <a href="../chap11/goodsCart.jsp">장바구니</a> | <a href="../chap11/goodsOrderPageC.jsp">주문배송조회</a>
		| <a href="../chap11/mypage.jsp">마이페이지</a>
		|<a href="/chap11/admin/admin_login.jsp">관리자페이지</a></td>
          </tr>
          <tr>
            <td>
            <ul class="ul">
             <li class="list">│<a href="goodsdisplay.jsp?pcat1=B" class="navi">BEDROOM</a></li>
             <li class="list" style="margin-left:15px;">│<a href="goodsdisplay.jsp?pcat1=O" class="navi">LIVING</a></li>
             <li class="list">│<a href="goodsdisplay.jsp?pcat1=T" class="navi">DINING</a></li>
			 <li class="list">│<a href="goodsdisplay.jsp?pcat1=K" class="navi">KIDS</a></li>
			 <li class="list">│<a href="goodsdisplay.jsp?pcat1=L" class="navi">LIBRARY</a></li>
			 <li class="list"  style="margin-left:15px;">│<a href="boardClist.jsp" class="navi">QnA</a></li>
			 </ul>
          </td>
          </tr>
        </table></td>
      </tr>