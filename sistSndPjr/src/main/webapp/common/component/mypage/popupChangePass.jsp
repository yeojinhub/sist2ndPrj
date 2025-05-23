<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../../jsp/external_file.jsp"/>

<link rel="stylesheet" href="../../css/style_headerfooter.css">
<link rel="stylesheet" href="../../css/style_main_page.css">
<link rel="stylesheet" href="../../css/style_accessory.css">
<link rel="stylesheet" href="../../css/style_user_menu.css">

<div>
    <div class="content" style="text-align: center;">
        <img src="../../images/logo251.png" alt="Logo" style="width: 150px; margin-bottom: 50px;">
        <h3 class="section-title">비밀번호 변경</h3>
	    <hr class="line_gray" style="width: 500px; margin: 0 auto; margin-bottom: 20px; margin-top: 20px;">
        <form id="changePassForm" method="post" action="popupChangePassConfirm.jsp" style="width: 400px; margin: 0 auto; text-align: left;">
            <div style="margin-bottom: 15px;">
                <p class="text"><strong>현재 비밀번호</strong></p>
                <input type="password" name="password" class="pass" style="width: 400px;"/><br>
            </div>
            <div style="margin-bottom: 15px;">
                <p class="text"><strong>새로운 비밀번호</strong></p>
                <input type="password" name="password" class="pass" style="width: 400px;"/><br>
            </div>
            <div style="margin-bottom: 25px;">
                <p class="text"><strong>비밀번호 확인</strong></p>
                <input type="password" name="password" class="pass" style="width: 400px;"/><br>
            </div>
            <div class="button-group" style="text-align: center;">
                <button type="submit" class="btn btn-confirm" style="width: 150px;">변경</button>
            </div>
        </form>
    </div>
</div>


