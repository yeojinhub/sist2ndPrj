<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
// 1. 잘못된 접근 방지 위해 sessionID를 체크하자.
// 1-1. QueryString으로 받아온 sessionId 변수.
String sessionId = request.getParameter("si");

// 2. 접속한 sessionID와 일치 여부 확인.
boolean sessionChk = false;
if (!request.getSession().getId().equals(sessionId)) {
	sessionChk = true;
}// end if

// 3. EL문 사용을 위한 setAttribute
pageContext.setAttribute("sessionChk", sessionChk);


String email = request.getParameter("e");
%>
<!DOCTYPE html>
<html>
<jsp:include page="../common/jsp/login_external_file.jsp" />
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모두쉼 - 비밀번호 재설정</title>
</head>
<body style="margin-top: 100px;">
	<div class="success-container" style="width: 300vh; height: 500px;">
		<img src="../common/images/main_pic.png" alt="배경 이미지"
			class="background-image">
		<div class="success-icon">✓</div>
		<c:choose>
			<c:when test="${sessionChk }">
				<h1>비정상적인 접근</h1>
				<p style="margin-top: 200px;">비정상적인 접근입니다.</p>
				<input type="" class="btn btn-success" value="메인화면으로 가기"/>
			</c:when>
			<c:otherwise>
				<h1>비밀번호 재설정</h1>
				<p>본인의 이메일과 새로운 비밀번호를 입력해주세요.</p>
				<div id="id-form-container">
					<form action="forgotPasswordSuccess.jsp" method="post">
						<div class="form-group" style="text-align: left;">
						<label for="email">이메일</label> <input type="email" id="email"
						name="email" placeholder="이메일" required>
						</div>
						<div class="form-group" style="text-align: left; margin-top: 20px; margin-bottom: 40px;">
						<label for="pass">새로운 비밀번호</label> <input type="password" id="pass"
						name="pass" placeholder="새로운 비밀번호" required>
						</div>

						<button type="submit" class="btn btn-confirm">비밀번호 재설정</button>
					</form>
				</div>
			</c:otherwise>
		</c:choose>
		
		
		
	</div>
</body>
</html>