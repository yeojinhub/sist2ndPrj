<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../../jsp/external_file.jsp"/>

<link rel="stylesheet" href="../../css/style_headerfooter.css">
<link rel="stylesheet" href="../../css/style_main_page.css">
<link rel="stylesheet" href="../../css/style_accessory.css">
<link rel="stylesheet" href="../../css/style_user_menu.css">

<div>
    <div class="content" style="text-align: center;">
        <img src="../../images/logo251.png" alt="Logo" style="width: 150px; margin-bottom: 50px;">
        <h3 class="section-title">회원 탈퇴</h3>
	    <hr class="line_gray" style="width: 500px; margin: 0 auto; margin-bottom: 20px; margin-top: 20px;">
        <form id="changePassForm" method="post" action="popupDeleteAccountConfirm.jsp" style="width: 400px; margin: 0 auto; text-align: left;">
            <div style="margin-bottom: 15px; text-align: center; margin-top: 50px;">
                <p class="text" style="font-size: 20px;"><strong>회원 탈퇴시 모든 정보가 삭제됩니다.</strong></p>
                <p class="text" style="font-size: 20px;"><strong>탈퇴를 위해서는 비밀번호 확인이 필요합니다.</strong></p>
            </div>
            <div style="margin-bottom: 15px; margin-top: 80px;">
                <p class="text" style="font-size: 20px;"><strong>비밀번호 확인</strong></p>
                <input type="password" name="password" class="pass" style="width: 400px;"/><br>
            </div>
            <div class="button-group" style="text-align: center; margin-top: 100px;">
                <button type="submit" class="btn btn-confirm" style="width: 150px;">탈퇴</button>
            </div>
        </form>
    </div>
</div>