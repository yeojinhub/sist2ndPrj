<%@page import="AdminLogin.LoginResultDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
//세션에 존재하는 값 얻기
Object obj = session.getAttribute("userData");

if(obj == null){
	response.sendRedirect("http://localhost/sistSndPjr/admin/login/admin_login.jsp");
	return;
}
LoginResultDTO lDTO = (LoginResultDTO)obj;
%>