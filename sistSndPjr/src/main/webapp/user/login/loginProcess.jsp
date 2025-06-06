<%@page import="org.json.simple.JSONObject"%>
<%@page import="kr.co.sist.cipher.DataEncryption"%>
<%@page import="kr.co.sist.cipher.DataDecryption"%>
<%@page import="user.account.login.LoginService"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<jsp:useBean id="lDTO" class="user.account.login.LoginDTO" scope="page" />
<jsp:setProperty name="lDTO" property="*" />
<%
LoginService ls = new LoginService();

String originalEmail = lDTO.getUser_email();

lDTO = ls.searchLogin(lDTO.getUser_email(), lDTO.getPass());

// 로그인 결과 flag, 성공시 session에 LoginDTO(이름, 아이디, 패스워드, 전화번호) 저장
boolean flag = false;
boolean withdraw = false;
if (lDTO != null) {
	flag = true;

	// 탈퇴회원 여부
	withdraw = ls.searchCheckWithdraw(originalEmail);
} // end if

// 탈퇴회원이 아닐경우 세션에 LoginDTO 데이터 만듬.
if (!withdraw) {
	session.setAttribute("userData", lDTO);
} // end if

//"아이디 기억하기" 체크 여부
boolean rememberFlag = Boolean.valueOf(request.getParameter("remember"));

// "아이디 기억하기" 쿠키 생성
Cookie emailCookie = null;

// flag가 true, withdraw가 false 일 경우 (정상적인 로그인일 경우)
if (flag && !withdraw) {
	
	// true = 쿠키 생성, false = 쿠키 제거
	if (rememberFlag) {
		// 쿠키 생성
		emailCookie = new Cookie("user_email", lDTO.getUser_email());
		
		emailCookie.setMaxAge(60*60*24*365); // 365일 유지
		emailCookie.setPath("/");
		response.addCookie(emailCookie);
		
	} else {
		emailCookie = new Cookie("user_email", "");
		
		emailCookie.setMaxAge(0);
		emailCookie.setPath("/");
		response.addCookie(emailCookie);
		
	}// end if-else
	
} // end if

// json 작업
JSONObject jsonObj = new JSONObject();
jsonObj.put("loginFlag", flag);
jsonObj.put("withdraw", withdraw);
%>

<%=jsonObj.toJSONString()%>