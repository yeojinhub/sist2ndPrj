<%@page import="org.json.simple.JSONObject"%>
<%@page import="Admin.Area.AreaService"%>
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

if ("POST".equals(request.getMethod().toUpperCase())) {
	areaDTO.setName(request.getParameter("name"));
	areaDTO.setAddr(request.getParameter("addr"));
	areaDTO.setTel(request.getParameter("tel"));
	areaDTO.setRoute(request.getParameter("route"));
	areaDTO.setLat(request.getParameter("lat"));
	areaDTO.setLng(request.getParameter("lng"));
	areaDTO.setOperation_time(request.getParameter("operationTime"));
	areaDTO.setFeed(request.getParameter("feed"));
	areaDTO.setSleep(request.getParameter("sleep"));
	areaDTO.setShower(request.getParameter("shower"));
	areaDTO.setLaundry(request.getParameter("laundry"));
	areaDTO.setClinic(request.getParameter("clinic"));
	areaDTO.setPharmacy(request.getParameter("pharmacy"));
	areaDTO.setShelter(request.getParameter("shelter"));
	areaDTO.setSalon(request.getParameter("salon"));
	areaDTO.setAgricultural(request.getParameter("agricultural"));
	areaDTO.setRepair(request.getParameter("repair"));
	areaDTO.setTruck(request.getParameter("truck"));
	areaDTO.setTemp(request.getParameter("tempText"));
} //end if

try {
	AreaService areaService = new AreaService();
	flag = areaService.addArea(areaDTO);
} catch (Exception e) {
	msg = "예외 발생: " + e.getMessage();
} // end try catch

JSONObject json = new JSONObject();
json.put("success", flag);
json.put("message", msg);

out.print(json.toString());
%>