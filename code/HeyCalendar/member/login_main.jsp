<%@ page language="java" contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
    <head>
        <link rel= "stylesheet" type="text/css" href="sub_pg.css">
        <meta content="text/html; charset=UTF-8">
        <title>LOGIN</title>
    </head>
    <body>
      <div class="wrap">
          <div class="log">
           <h3>"Hey!캘린더"</h3><br>
            <form action="login.jsp" method="post">
                    ID : <input type="text" name="userid" size="10" maxlength="10"><br><br>
                    PW : <input type="password" name="userpw" size="10" maxlength="10"><br><br>
                    <input type="submit" value="로그인">
                    <input type="button" value="회원가입" onclick="location.href='member_join_form.jsp' ">
            </form>
            
       </div>
      </div>
       
        
    </body>
</html>