<%@page import="Account.RegisterService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="aDTO" class="DTO.AccountDTO" scope="page"/>
<jsp:setProperty name="aDTO" property="*"/>
<%
// Service 객체 생성
RegisterService rs = new RegisterService();

boolean flag = rs.addAccount(aDTO);

pageContext.setAttribute("registerFlag", flag);

%>
<!DOCTYPE html>
<html>
<jsp:include page="../common/jsp/login_external_file.jsp" />
<script>
	$(function() {

	});// ready
</script>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모두쉼 - 회원가입</title>
</head>
<body>

	<div>
		<img src="../common/images/main_pic.png" alt="배경 이미지"
			class="background-image"> <a href="../user/user_main_page.jsp"
			class="logo-container"> <img src="../common/images/logo251.png"
			alt="모두쉼 로고" class="logo-image">
		</a> <a href="../user/user_main_page.jsp" class="mobile-logo"> <img
			src="../common/images/logo251.png" alt="모두쉼 로고" class="logo-image">
		</a>

		<div class="id-form-container">
			<c:choose>
				<c:when test="${registerFlag }">
					<div style="text-align: center; font-size: 30px;">
						<h1>회원가입</h1>
						<p>회원가입이 완료되었습니다.</p>
						<p>메인화면으로 이동합니다.</p>
						<meta http-equiv="refresh" content="2;../user/user_main_page.jsp" />
					</div>
				</c:when>
				<c:otherwise>
					<div style="text-align: center; font-size: 30px;">
						<h1>회원가입</h1>
						<p>회원가입을 실패하였습니다.</p>
						<p>메인화면으로 이동합니다.</p>
						<meta http-equiv="refresh" content="2;../user/user_main_page.jsp" />
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>
