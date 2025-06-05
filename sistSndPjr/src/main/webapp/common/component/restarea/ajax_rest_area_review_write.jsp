<%@page import="restarea.detail.RestAreaDetailReviewService"%>
<%@page import="DTO.LoginDTO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<% 
String msg = request.getParameter("msg");
int area_num = Integer.parseInt(request.getParameter("id"));
LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");

RestAreaDetailReviewService radrs = new RestAreaDetailReviewService();

boolean successChk = radrs.addReview(area_num, msg, lDTO);

JSONObject jsonObj = new JSONObject();
jsonObj.put("successChk", successChk);
%>
<%= jsonObj.toJSONString()%>