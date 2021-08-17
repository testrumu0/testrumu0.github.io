<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.util.*" import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %> <!--인코딩-->

<!doctype html>

<%

		String in_userid = (String)session.getAttribute("G_ID");

			
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			
			String connectionURL = "jdbc:sqlserver://localhost:1433;databaseName=CSR_Book; user=CSR; password=00";
			Connection con = DriverManager.getConnection(connectionURL);
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			String SQL = "select * from members where userid = ?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1,in_userid);
			rs = pstmt.executeQuery();
			
			if(rs.next()==false){
				out.print("등록되지 않은 회원입니다.");
			}else{
				String usernm =  rs.getString("usernm");
				String jumin =  rs.getString("jumin");
				String jumin1 =  "";
				String jumin2 =  "";
				if(jumin != null){
					jumin1 = jumin.substring(0,6);
					jumin2 = jumin.substring(6);
				}
				String mailrcv =  rs.getString("mailrcv");
				if(mailrcv==null)mailrcv="N";
				String gender = rs.getString("gender");
				if(gender==null) gender="";
				String job = rs.getString("jobcd");
				if(job==null)job="";
				String intro = rs.getString("intro");
				String pict  = rs.getString("pict");
				if(pict==null) pict="";
	%>
<html>
    <head>
        <meta charset="utf-8">
        <title>회원 정보 변경</title>
    </head>
    <script language=javascript src="func2.js"></script>
    <body>
			<h3>회원 정보 변경</h3>
            <form name="frm1" action="mem_upd3_1_ok.jsp" method="post" enctype="multipart/form-data">
			<table width = "500" border = "1" cellpadding = "0" cellspacing="0">
				<tr>
					<td width="40%" align = "left">아이디</td>
					<td width="60%" align = "left"><input type="text" name="userid" value="<%=in_userid%>" size=15  maxlength=10></td>
				</tr>	
                <tr>
					<td width="40%" align = "left">이름 </td>
					<td width="60%" align = "left">
					<input type="text" name="usernm" value="<%=usernm%>" size=10  maxlength=10>
					</td>
				</tr>
                <tr> 
					<td width="40%" align = "left">비밀번호 </td>
					<td width="60%" align = "left">
					<input type="password" name="passwd" size=10  maxlength=10></td>
				</tr>
                <tr>
					<td width="40%" align = "left">비밀번호 확인  </td>
					<td width="60%" align = "left">
					<input type="password" name="passwd2" size=10  maxlength=10></td>
				</tr>
                <tr>
					<td width="40%" align = "left">주민번호 </td>
					<td width="60%" align = "left">
					<input type="text" name="jumin1" value="<%=jumin1%>" size=6  maxlength=6 onKeyDown="KeyNumber()" onKeyUp="cursor_move(1)">-
					<input type="text" name="jumin2" value="<%=jumin2%>" size=7  maxlength=7 onKeyDown="KeyNumber()" onKeyUp="cursor_move(2)">
					</td>
				</tr>
				<tr>
					<td width="40%" align = "left">메일수신여부 </td>
					<td width="60%" align = "left">
						동의함 <input type="checkbox" name="mailrcv" <%if(mailrcv.equals("Y")) out.print("checked");%>>
					</td>
				</tr>
                <tr>
					<td width="40%" align = "left"> </td>
					<td width="60%" align = "left">
							   남<input type="radio" name="gender"  value="1" <%if(gender.equals("1")) out.print("checked");%>>
							   여 <input type="radio" name="gender" value="2" <%if(gender.equals("2")) out.print("checked");%> >
					</td>
				</tr>
                <tr>
					<td width="40%" align = "left">직업 : </td>
					<td width="60%" align = "left">
					<select name="job" size =5>
								<option value="">==직업을 선택하세요==</option>
								<option value="1" <%if(job.equals("1")) out.print("selected");%>>학생</option>
								<option value="2" <%if(job.equals("2")) out.print("selected");%>>회사원</option>
								<option value="3" <%if(job.equals("3")) out.print("selected");%>>군인</option>
								<option value="4" <%if(job.equals("4")) out.print("selected");%>>운동선수</option>
								<option value="5" <%if(job.equals("5")) out.print("selected");%>>가수</option>
								<option value="6" <%if(job.equals("6")) out.print("selected");%>>유튜버</option>
								<option value="9" <%if(job.equals("9")) out.print("selected");%>>기타</option>
					</select>
					</td>
				</tr>
				<tr>
					<td width="40%" align = "left">자기소개 : </td>
					<td width="60%" align = "left">
					<textarea name="intro" rows=5 cols=50 ><%=intro%></textarea>
					</td>
				</tr>
				<tr>
					<td width="40%" align = "left">현재 등록 사진</td>
					<td width="60%" align = "left">
					<img src="/image/<%=pict%>" height=100 width=150>
					</td>
				</tr>
				<tr>
					<td width="40%" align = "left">변경할 사진</td>
					<td width="60%" align = "left">
					<input type="file" name="pict" size=40>
					</td>
				</tr>
				<tr>
					<td width="100%" align = "center" colspan= "2">
					<input type="button" value="변경" onclick="valid_check()"></td>
				</tr>
			</table>
            </form>


    </body>
	<%
			}

	%>
</html>