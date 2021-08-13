<%@ page language="java" contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<script language=javascript src="func2.js"></script>
<html>
    <head>
        <link rel= "stylesheet" type="text/css" href="sub_pg.css">
        <title>JOIN</title>
    </head>
<body>
   <div class="wrap">
   <div class="log">
       <h3>Hey!캘린더 회원가입</h3>
       <br>
        <form name= "frml" action="member_join.jsp" method="post">
           ID : <input type="text" name="userid" size="10" maxlength="10"><br>
           PW : <input type="password" name="userpw" size="10" maxlength="10"><br>
           NAME : <input type="text" name="usernm" size="10" maxlength="10"><br>
           PHONE : <input type="text" name="userph" size="10" maxlength="10"><br><br>
            <div align="center">
                <input type="button" value="가입" onclick="valid_check()">
            </div>  
        </form>
  </div><!--log-->
 </div><!--wrap-->
</body>
</html>