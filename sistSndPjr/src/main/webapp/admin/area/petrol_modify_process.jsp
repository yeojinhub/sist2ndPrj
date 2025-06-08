<%@page import="org.json.simple.JSONObject"%>
<%@page import="Admin.Area.PetrolService"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="petDTO" class="Admin.Area.PetrolDTO" scope="page" />
<jsp:setProperty name="petDTO" property="*" />
<%
boolean flag = false;
String msg = "";

petDTO.setGasoline(request.getParameter("gasoline"));
petDTO.setDiesel(request.getParameter("diesel"));
petDTO.setLpg(request.getParameter("lpg"));
petDTO.setElect(request.getParameter("elect"));
petDTO.setHydro(request.getParameter("hydro"));

try {
	petDTO.setPetNum(Integer.parseInt(request.getParameter("num")));
	PetrolService petservice = new PetrolService();
	flag = petservice.modifyPetrol(petDTO);
} catch(Exception e) {
	msg = "예외 발생: " + e.getMessage();
} // end try catch

JSONObject json = new JSONObject();
json.put("success", flag);
json.put("message", msg);

out.print(json.toString());
%>