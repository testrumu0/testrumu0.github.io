<%@ page language="java" contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@page import="java.sql.*"%>

    <%
          
         Connection con=null;
         try{
         Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
         String connectionURL = "jdbc:sqlserver://localhost:1433;" + "databaseName = CSR_cal;user=PPP;password=11";
         con = DriverManager.getConnection(connectionURL);
         PreparedStatement pstmt = null;
         
         String suserid = request.getParameter("userid"); 
         String suserpw = request.getParameter("userpw");
         
         if(suserid.equals("") || suserpw.equals("")){
    %>
             <script>
                alert('아이디와 패스워드를 모두 입력하세요');
                history.back();
             </script>
         
    <%
         }else{ //로그인
            String SQL = "select * from member where userid = ?"; 
            pstmt = con.prepareStatement(SQL);
              
            pstmt.setString(1,suserid);
            ResultSet rs = pstmt.executeQuery();
            String password;
            String id;
            rs.next();
            password = rs.getString("userpw");
            id = rs.getString("userid");
            
            if(password.equals(suserpw) && id.equals(suserid)){
                session.setAttribute("userid",suserid);
    %> 
                <script>
                    alert('로그인 되었습니다. 환영합니다:)')
                    location.href='calendar.jsp'           
                </script> 
    <%
               response.sendRedirect("../calendar.jsp");
            }else{ 
    %> 
                 <script>
                    alert('아이디 또는 패스워드가 일치하지 않습니다.')
                    history.back();           
                 </script> 
    <%                           
            }
            
            pstmt.close();
            con.close();
            rs.close();
           
          }//copy

         
         }catch(Exception e){
            out.print("<script>alert('정보없음.');location.href='login_main.jsp'</script>");
            e.printStackTrace();
       
       
     }

%>
