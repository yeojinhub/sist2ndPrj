<%@page import="restarea.detail.RestAreaDetailReviewService"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<% 
int revNum = Integer.parseInt(request.getParameter("revNum"));

RestAreaDetailReviewService radrs = new RestAreaDetailReviewService();

boolean successChk = radrs.modifyReviewReport(revNum);

// 무한 신고 방지위해 30분간 신고금지 session 생성
if (successChk) {
	session.setAttribute("reportBlock", true);
}// end if

JSONObject jsonObj = new JSONObject();
jsonObj.put("successChk", successChk);
%>
<%= jsonObj.toJSONString()%>