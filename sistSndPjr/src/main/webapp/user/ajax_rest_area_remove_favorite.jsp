<%@page import="restarea.detail.RestAreaDetailService"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%
RestAreaDetailService rads = new RestAreaDetailService();

int acc_num = Integer.parseInt(request.getParameter("accNum"));
int area_num = Integer.parseInt(request.getParameter("id"));

boolean result = rads.removeFavorite(acc_num, area_num);

JSONObject jsonObj = new JSONObject();
jsonObj.put("result", result);
%>

<%= jsonObj.toJSONString() %>