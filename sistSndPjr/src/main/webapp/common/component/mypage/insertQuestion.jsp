<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="myPage.QuestionService" %>
<%@ page import="DTO.LoginDTO" %>

<%
    request.setCharacterEncoding("UTF-8");

    LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");

    if (lDTO == null) {
        response.setStatus(401); // Unauthorized
        out.print("LOGIN_REQUIRED");
        return;
    }

    String email = lDTO.getUser_email();
    String name = lDTO.getName();
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    // 유효성 검사
    if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
        response.setStatus(400); // Bad Request
        out.print("MISSING_FIELDS");
        return;
    }

    try {
        QuestionService qs = new QuestionService();
        qs.addQuestion(email, name, title, content);
        response.setStatus(200); // OK
        out.print("OK");
    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(500); // Internal Server Error
        out.print("ERROR");
    }
%>


