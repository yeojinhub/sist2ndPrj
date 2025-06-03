<%@page import="org.json.simple.JSONObject"%>
<%@page import="Account.AdminAccountService"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="adminDTO" class="Account.AccountDTO" scope="page" />
<jsp:setProperty name="adminDTO" property="*" />
<%
boolean flag = false;
String msg = "";

adminDTO.setName(request.getParameter("name"));
adminDTO.setTel(request.getParameter("tel"));

try {
	adminDTO.setAcc_num(Integer.parseInt(request.getParameter("num")));
	AdminAccountService accountService = new AdminAccountService();
	flag = accountService.modifyAdmin(adminDTO);
} catch(Exception e) {
	msg = "예외 발생: " + e.getMessage();
} // end try catch

JSONObject json = new JSONObject();
json.put("success", flag);
json.put("message", msg);

out.print(json.toString());
%>