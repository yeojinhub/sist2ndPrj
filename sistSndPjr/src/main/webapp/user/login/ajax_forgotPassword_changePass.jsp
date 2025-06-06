<%@page import="user.account.forgot.ForgotService"%>
<%@page import="kr.co.sist.cipher.DataEncryption"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" info=""%>
<%
// 1. 사용자에게 받은 비밀번호(파라미터) 변수 저장
String pass = request.getParameter("pass");

// 2. 사용자에게 받은 이메일(파라미터) 변수 저장
String email = request.getParameter("email");

// 3. Service 객체 생성
ForgotService fs = new ForgotService();

// 4. changeChk 결과값 받기
boolean changeChk = fs.modifyPass(email, pass);

// 5. JSON에 changeChk 결과값 넣기
JSONObject jsonObj = new JSONObject();
jsonObj.put("changeChk", changeChk);
%>
<%= jsonObj.toJSONString() %>