<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="Admin.Area.AreaService"%>
<%@page import="Admin.Area.AreaDTO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="areaDTO" class="Admin.Area.AreaDTO" scope="page" />
<%
boolean flag = false;
String msg = "";

try {
    String[] nums = request.getParameterValues("chk");
    if (nums != null && nums.length > 0) {
        List<Integer> areaNumList = new ArrayList<>();
        for (String numStr : nums) {
            areaNumList.add(Integer.parseInt(numStr));
        } //end for

        AreaService areaService = new AreaService();
        flag = areaService.removeArea(areaNumList);

        if (!flag) {
            throw new Exception("삭제 실패: 일부 또는 전체 삭제 실패");
        } //end if
    } //end if
} catch(Exception e) {
    msg = "예외 발생: " + e.getMessage();
} //end try catch

JSONObject json = new JSONObject();
json.put("success", flag);
json.put("message", msg);

out.print(json.toJSONString());
%>