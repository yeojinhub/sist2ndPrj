<%@page import="java.sql.Date"%>
<%@page import="Account.AdminAccountService"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="userDTO" class="Account.AccountDTO" scope="page" />
<jsp:setProperty name="userDTO" property="*" />
<%
boolean flag = false;
if("POST".equals(request.getMethod().toUpperCase())) {
	userDTO.setName(request.getParameter("name"));
	userDTO.setUser_email(request.getParameter("email"));
	userDTO.setPass(request.getParameter("pass"));
	userDTO.setInput_date(Date.valueOf(request.getParameter("inputDate")));
	
	AdminAccountService accountService = new AdminAccountService();
	flag = accountService.addUser(userDTO);
	pageContext.setAttribute("addFlag", flag);
	out.print("{ \"addFlag\" : " + flag + " }");
} // end if
%>