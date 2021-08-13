<%@ page language="java" contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@page import="java.sql.*"%>
<%

    session.invalidate();
    response.sendRedirect("login_main.jsp");
%>
    