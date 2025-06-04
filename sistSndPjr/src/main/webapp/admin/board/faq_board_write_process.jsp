<%@page import="Board.FaqService"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="faqDTO" class="Board.FaqDTO" scope="page" />
<jsp:setProperty name="faqDTO" property="*" />
<%
boolean flag = false;
if("POST".equals(request.getMethod().toUpperCase())) {
	faqDTO.setName(request.getParameter("name"));
	faqDTO.setTitle(request.getParameter("title"));
	faqDTO.setContent(request.getParameter("content"));
	faqDTO.setInput_date(Date.valueOf(request.getParameter("inputDate")));
	
	FaqService faqService = new FaqService();
	flag = faqService.addFaq(faqDTO);
	pageContext.setAttribute("addFlag", flag);
	out.print("{ \"addFlag\" : " + flag + " }");
} // end if
%>