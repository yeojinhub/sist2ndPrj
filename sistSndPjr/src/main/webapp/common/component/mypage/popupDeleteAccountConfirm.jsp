<%@page import="myPage.InfoService"%>
<%@page import="DTO.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../../jsp/external_file.jsp"/>

<link rel="stylesheet" href="../../css/style_headerfooter.css">
<link rel="stylesheet" href="../../css/style_main_page.css">
<link rel="stylesheet" href="../../css/style_accessory.css">
<link rel="stylesheet" href="../../css/style_user_menu.css">

<%
    LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");

    if (lDTO != null) {
        try {
            String email = lDTO.getUser_email();
            InfoService infoService = new InfoService();
            infoService.deleteUser(email); // 실제 탈퇴 처리
            session.invalidate(); // 로그아웃 처리
        } catch (Exception e) {
            e.printStackTrace();
%>
<script>
    alert("탈퇴 처리 중 오류가 발생했습니다.");
    window.close();
</script>
<%
            return;
        }
    } else {
%>
<script>
    alert("로그인 정보가 없습니다.");
    window.close();
</script>
<%
        return;
    }
%>

<script>
    function reloadPage() {
        window.opener.location.href = '../../../user/user_main_page.jsp';
        window.close();
    }
</script>

<div>
    <div class="content" style="text-align: center;">
        <img src="../../images/logo251.png" alt="Logo" style="width: 150px; margin-bottom: 50px;">
        <h3 class="section-title">회원 탈퇴</h3>
	    <hr class="line_gray" style="width: 500px; margin: 0 auto; margin-bottom: 20px; margin-top: 20px;">
        <div class="content-text" style="font-size: 20px; font-weight: bold; margin-top: 50px;">
            <p class="text" style="margin-bottom: 20px; font-size: 25px;">회원 탈퇴가 완료되었습니다.</p>
            <p class="text" style="margin-bottom: 20px; font-size: 20px;">그동안 이용해주셔서 감사합니다.</p>
        </div>
        <div class="button-group">
            <button type="button" class="btn btn-confirm" style="margin-top: 230px;" onclick="reloadPage()">닫기</button>
        </div>
    </div>
</div>