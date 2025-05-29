<%@page import="org.json.simple.JSONObject"%>
<%@page import="Account.RegisterService"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%

String id = request.getParameter("id").trim().toLowerCase();

RegisterService rs = new RegisterService();

boolean isIdCheck = !rs.searchIdCheck(id);

JSONObject jsonObj = new JSONObject();

jsonObj.put("isIdCheck", isIdCheck);

%>

<%= jsonObj.toJSONString()%>