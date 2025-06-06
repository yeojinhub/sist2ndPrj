<%@page import="user.account.login.LoginDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
boolean loginChk3 = false;

if (session.getAttribute("userData") != null) {
	LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");
	loginChk3 = true;
} // end if

pageContext.setAttribute("loginChk", loginChk3);
%>
<style>
#reportConfirmPopup {
	position: fixed;
	top: 30%;
	left: 50%;
	transform: translateX(-50%);
	width: 320px;
	background-color: white;
	border: 1px solid #ccc;
	padding: 20px 30px;
	z-index: 999;
	text-align: center;
	border-radius: 8px;
	display: none;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
	font-family: 'Noto Sans KR', sans-serif;
}

#reportConfirmPopup .logo {
	width: 80px;
	margin-bottom: 8px;
}

#reportConfirmPopup .popup-title {
	font-size: 13px;
	font-weight: 500;
	text-align: left;
	border-bottom: 1px solid #aaa;
	padding-bottom: 4px;
	margin-bottom: 16px;
}

#reportConfirmPopup .popup-content {
	font-weight: bold;
	margin: 10px 0 20px;
	font-size: 15px;
}

#reportConfirmPopup .popup-buttons {
	display: flex;
	justify-content: center;
	gap: 10px;
}

#reportConfirmPopup .popup-buttons button {
	padding: 6px 18px;
	font-size: 14px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

#reportConfirmPopup .popup-confirm {
	background-color: #2c3eeb;
	color: white;
}

#reportConfirmPopup .popup-cancel {
	background-color: #ccc;
	color: #333;
}
</style>

<div class="popup" id="reportConfirmPopup">
	<img src="../common/images/logo251.png" alt="로고" class="logo">

	<c:choose>
		<c:when test="${loginChk }">
			<div class="popup-title">리뷰 신고</div>
			<div class="popup-content">리뷰를 신고 하시겠습니까?</div>
			<div class="popup-buttons">
				<button class="popup-confirm" id="btnConfirm">확인</button>
				<button class="popup-cancel" id="btnCancel">취소</button>
			</div>
		</c:when>
		<c:otherwise>
			<div class="popup-title">로그인 확인</div>
			<div class="popup-content">
				로그인이 필요합니다.<br>로그인페이지로 이동하시겠습니까?
			</div>
			<div class="popup-buttons">
				<button class="popup-confirm" id="btnLogin">로그인</button>
			</div>
		</c:otherwise>
	</c:choose>

</div>



