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

areaDTO.setFeed( request.getParameter("수유실"));
areaDTO.setSleep( request.getParameter("수면실"));
areaDTO.setShower( request.getParameter("샤워실"));
areaDTO.setLaundry( request.getParameter("세탁실"));
areaDTO.setClinic( request.getParameter("병원"));
areaDTO.setPharmacy( request.getParameter("약국"));
areaDTO.setShelter( request.getParameter("쉼터"));
areaDTO.setSalon( request.getParameter("이발소"));
areaDTO.setAgricultural( request.getParameter("농산물판매장"));
areaDTO.setRepair( request.getParameter("경정비소"));
areaDTO.setTruck( request.getParameter("화물차라운지"));
areaDTO.setTemp( request.getParameter("tempText"));

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