<%@page import="Answer.AnswerService"%>
<%@page import="Answer.AnswerDTO"%>
<%@page import="AdminLogin.LoginResultDTO"%>
<%@page import="java.sql.SQLException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<%
LoginResultDTO userData = (LoginResultDTO) session.getAttribute("userData");
if (userData == null) {
    response.sendRedirect("../login/admin_login.jsp");
    return;
}

String inqNumStr = request.getParameter("inq_num");
String content = request.getParameter("answerContent");
String writer = userData.getName();

int inqNum = 0;
if (inqNumStr != null && !inqNumStr.trim().isEmpty()) {
    inqNum = Integer.parseInt(inqNumStr);
}

AnswerService answerService = AnswerService.getInstance();
AnswerDTO newAnswer = null;
boolean writeFlag = false;

try {
    newAnswer = answerService.insertAnswer(inqNum, content, writer);
    writeFlag = (newAnswer != null);
} catch (SQLException e) {
    e.printStackTrace();
}

request.setAttribute("writeFlag", writeFlag);
request.setAttribute("inqNum", inqNum);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>답변 등록 결과</title>
</head>
<body>
<c:choose>
    <c:when test="${writeFlag}">
        <script>
            alert("답변 등록이 완료되었습니다.");
            location.href = "inquiries.jsp";
        </script>
    </c:when>
    <c:otherwise>
        <script>
            alert("답변 등록에 실패했습니다.");
            history.back();
        </script>
    </c:otherwise>
</c:choose>
</body>
</html>
