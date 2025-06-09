<%@page import="org.json.simple.JSONObject"%>
<%@page import="Admin.Area.FoodService"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="foodDTO" class="Admin.Area.FoodDTO" scope="page" />
<jsp:setProperty name="foodDTO" property="*" />
<%
boolean flag = false;
String msg = "";

foodDTO.setFoodName(request.getParameter("foodName"));
foodDTO.setFoodPrice(request.getParameter("price"));

out.println("process에서의 저장된 dto 값 : "+foodDTO);

try {
	foodDTO.setFoodNum(Integer.parseInt(request.getParameter("foodNum")));
	out.println(Integer.parseInt(request.getParameter("foodNum")));
	FoodService service = new FoodService();
	flag = service.modifyFood(foodDTO);
} catch(Exception e) {
	msg = "예외 발생: " + e.getMessage();
} // end try catch

out.println("process에서의 저장된 dto 값 : "+foodDTO);

JSONObject json = new JSONObject();
json.put("success", flag);
json.put("message", msg);

out.print(json.toString());
%>