<%@page import="org.json.simple.JSONObject"%>
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
String msg = "";
String numStr = request.getParameter("num");

try {
	int num = Integer.parseInt(numStr);
	AdminAccountService accountService = new AdminAccountService();
	flag = accountService.removeUser(num);
} catch(Exception e) {
	msg = "예외 발생: " + e.getMessage();
}

JSONObject json = new JSONObject();
json.put("success", flag);
json.put("message", msg);

out.print(json.toString());
%>