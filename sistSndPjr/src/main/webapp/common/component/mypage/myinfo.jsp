<%@page import="kr.co.sist.cipher.DataDecryption"%>
<%@page import="DTO.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
LoginDTO lDTO = (LoginDTO)session.getAttribute("userData");

DataDecryption dd = new DataDecryption("asdf1234asdf1234");

String name = lDTO.getName();
String email = lDTO.getUser_email();
String tel = lDTO.getTel();

name = dd.decrypt(name);
email = dd.decrypt(email);
tel = dd.decrypt(tel);

pageContext.setAttribute("name", name);
pageContext.setAttribute("email", email);
pageContext.setAttribute("tel", tel);

%>

<script>
    	function changePass() {
		var width = 600;
		var height = 750;
		var left = 700;
		var top = 100;
		window.open("../common/component/mypage/popupChangePass.jsp", "popup", "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top);
	}

	function deleteUser(flag) {
		var width = 600;
		var height = 750;
		var left = 700;
		var top = 100;
		window.open("../common/component/mypage/popupDeleteAccount.jsp", "popup", "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top);
	}
</script>

<div style="position: relative;">
    <h3 class="section-title">내 정보</h3>
	<button type="button" class="btn btn-secondary" style="position: absolute; right: 10px; top: -10px;" onclick="deleteUser(true)">탈퇴</button>
	<hr class="line_gray">
	<p class="text"><strong>이름</strong></p>
	<input type="text" name="name" value=${name} class="pass"/><br>
	<p class="text"><strong>이메일</strong></p>
	<input type="text" name="email" value=${email} class="pass"/><br>
	<p class="text"><strong>전화번호</strong></p>
	<input type="text" name="tel" value=${tel} class="pass"/><br>
	<div class="button-group">
	<button type="submit" class="btn btn-confirm">수정</button>
	<button type="button" class="btn btn-cancel" onclick="changePass()">비밀번호 변경</button>
</div>