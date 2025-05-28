<%@page import="org.json.simple.JSONObject"%>
<%@page import="kr.co.sist.cipher.DataEncryption"%>
<%@page import="kr.co.sist.cipher.DataDecryption"%>
<%@page import="Account.LoginService"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<jsp:useBean id="lDTO" class="DTO.LoginDTO" scope="page"/>
<jsp:setProperty name="lDTO" property="*"/>
<%
LoginService ls = new LoginService();

lDTO = ls.searchLogin(lDTO.getUser_email(), lDTO.getPass());

// 로그인 결과 flag, 성공시 session에 LoginDTO(이름, 아이디, 패스워드, 전화번호) 저장
boolean flag = false;
if (lDTO != null) {
	flag = true;
	session.setAttribute("userData", lDTO);
}// end if

// json 작업
JSONObject jsonObj = new JSONObject();
jsonObj.put("loginFlag", flag);
%>

<%= jsonObj.toJSONString()%>