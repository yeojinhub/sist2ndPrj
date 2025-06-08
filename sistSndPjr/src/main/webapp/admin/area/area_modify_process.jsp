<%@page import="org.json.simple.JSONObject"%>
<%@page import="Admin.Area.AreaService"%>
<%@page import="Admin.Area.AreaDTO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="areaDTO" class="Admin.Area.AreaDTO" scope="page" />
<jsp:setProperty name="areaDTO" property="*" />
<%
boolean flag = false;
String msg = "";

areaDTO.setTemp( request.getParameter("tempChk"));

try {
	areaDTO.setArea_num(Integer.parseInt(request.getParameter("num")));
	AreaService areaService = new AreaService();
	flag = areaService.modifyArea(areaDTO);
} catch(Exception e) {
	msg = "예외 발생: " + e.getMessage();
} // end try catch

JSONObject json = new JSONObject();
json.put("success", flag);
json.put("message", msg);

out.print(json.toString());
%>