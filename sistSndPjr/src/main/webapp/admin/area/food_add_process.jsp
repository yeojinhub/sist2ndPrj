<%@page import="org.json.simple.JSONObject"%>
<%@page import="Admin.Area.FoodService"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="foodDTO" class="Admin.Area.FoodDTO" scope="page" />
<jsp:setProperty name="foodDTO" property="*" />
<%
boolean flag = false;
String msg = "";

if ("POST".equals(request.getMethod().toUpperCase())) {
	foodDTO.setFoodName(request.getParameter("foodName"));
	foodDTO.setFoodPrice(request.getParameter("price"));
	
	System.out.println(foodDTO);
	System.out.println(Integer.parseInt(request.getParameter("areaNum")));
	
	try {
		foodDTO.setAreaNum(Integer.parseInt(request.getParameter("areaNum")));
		FoodService service = new FoodService();
		flag = service.addFood(foodDTO);
	} catch (Exception e) {
		msg = "예외 발생: " + e.getMessage();
	} // end try catch
} //end if

JSONObject json = new JSONObject();
json.put("success", flag);
json.put("message", msg);

out.print(json.toString());
%>