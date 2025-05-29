<%@page import="org.json.simple.JSONObject"%>
<%@page import="kr.co.sist.cipher.DataEncryption"%>
<%@page import="DTO.LoginDTO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%
    request.setCharacterEncoding("UTF-8");

    String inputPass = request.getParameter("password");
    boolean result = false;

    LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");

    if (lDTO != null && inputPass != null) {
        String encryptedInput = DataEncryption.messageDigest("SHA-256",inputPass); // 🔐 입력값 암호화
        String sessionPassword = lDTO.getPass(); // 세션에 저장된 암호화된 비밀번호

        if (encryptedInput.equals(sessionPassword)) {
            result = true; // 비밀번호 일치
        }
    }
    
    JSONObject jsonObject = new JSONObject();
    jsonObject.put("match", result);
%>

<%= jsonObject.toJSONString()%>