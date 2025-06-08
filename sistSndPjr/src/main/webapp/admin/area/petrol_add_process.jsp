<%@page import="Admin.Area.PetrolService"%>
<%@page import="Admin.Area.PetrolDTO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="petDTO" class="Admin.Area.PetrolDTO" scope="page" />
<jsp:setProperty name="petDTO" property="*" />
<%
boolean flag = false;
String msg = "";

if ("POST".equals(request.getMethod().toUpperCase())) {

	petDTO.setAreaName(request.getParameter("name"));
	petDTO.setAreaRoute(request.getParameter("route"));
	petDTO.setAreaTel(request.getParameter("tel"));
	petDTO.setOperationTime(request.getParameter("operationTime"));
	petDTO.setAreaAddr(request.getParameter("addr"));
	petDTO.setAreaLat(request.getParameter("lat"));
	petDTO.setAreaLng(request.getParameter("lng"));
	petDTO.setGasoline(request.getParameter("gasoline"));
	petDTO.setDiesel(request.getParameter("diesel"));
	petDTO.setLpg(request.getParameter("lpg"));
	petDTO.setHydro(request.getParameter("hydro"));
	petDTO.setElect(request.getParameter("elect"));
	
} //end if

try {
	PetrolService petService = new PetrolService();
	flag = petService.addPetrol(petDTO);
} catch (Exception e) {
	msg = "예외 발생: " + e.getMessage();
} // end try catch
 
JSONObject json = new JSONObject();
json.put("success", flag);
json.put("message", msg);

out.print(json.toString());
%>