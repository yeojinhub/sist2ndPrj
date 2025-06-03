<%@page import="org.json.simple.JSONObject"%>
<%@page import="restarea.detail.RestAreaDetailService"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%
// 1. 현재 즐겨찾기에 추가되어 있는지 확인.
String email = request.getParameter("email");
int area_num = Integer.parseInt(request.getParameter("id"));

RestAreaDetailService rads = new RestAreaDetailService();

boolean favoriteChk = rads.searchFavorite(email, area_num);

System.out.println(favoriteChk);

// 2. 내일하자
JSONObject jsonObj = new JSONObject();
jsonObj.put("favoriteChk", favoriteChk);

%>

<%= jsonObj.toJSONString()%>
