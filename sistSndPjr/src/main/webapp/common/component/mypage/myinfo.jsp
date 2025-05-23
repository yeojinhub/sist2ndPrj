<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<input type="text" name="name" class="pass"/><br>
	<p class="text"><strong>이메일</strong></p>
	<input type="text" name="name" class="pass"/><br>
	<p class="text"><strong>전화번호</strong></p>
	<input type="text" name="name" class="pass"/><br>
	<div class="button-group">
	<button type="submit" class="btn btn-confirm">수정</button>
	<button type="button" class="btn btn-cancel" onclick="changePass()">비밀번호 변경</button>
</div>