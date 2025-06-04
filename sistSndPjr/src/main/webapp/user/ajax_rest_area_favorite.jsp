<%@page import="DTO.LoginDTO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="restarea.detail.RestAreaDetailService"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%
// 1. 현재 즐겨찾기에 추가되어 있는지 확인.
String email = request.getParameter("email");
int area_num = Integer.parseInt(request.getParameter("id"));
int acc_num = ((LoginDTO)session.getAttribute("userData")).getAcc_num();
String restareaName = request.getParameter("originalName");

RestAreaDetailService rads = new RestAreaDetailService();

boolean favoriteChk = rads.searchFavorite(email, area_num);

boolean result = false;

if (!favoriteChk) {
	result = rads.addFavorite(restareaName, acc_num, area_num);
}// end if

// 2. 내일하자
JSONObject jsonObj = new JSONObject();
jsonObj.put("favoriteChk", favoriteChk);
jsonObj.put("result", result);
%>

<%= jsonObj.toJSONString()%>
