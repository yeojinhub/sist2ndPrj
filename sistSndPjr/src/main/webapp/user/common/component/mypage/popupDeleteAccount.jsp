<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.account.login.LoginDTO" %>
<%@ page import="kr.co.sist.cipher.DataEncryption" %>
<jsp:include page="../../jsp/external_file.jsp"/>

<link rel="stylesheet" href="../../css/style_headerfooter.css">
<link rel="stylesheet" href="../../css/style_main_page.css">
<link rel="stylesheet" href="../../css/style_accessory.css">
<link rel="stylesheet" href="../../css/style_user_menu.css">

<%
    request.setCharacterEncoding("UTF-8");
    String jsCode = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String inputPass = request.getParameter("password");
        LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");

        if (lDTO != null && inputPass != null) {
            // 입력받은 비밀번호를 암호화해서 세션값과 비교 (복호화 X)
            String encryptedInput =
            DataEncryption.messageDigest("SHA-256", inputPass);
            String sessionPass = lDTO.getPass();

            if (encryptedInput.equals(sessionPass)) {
                jsCode = "alert('비밀번호가 확인되었습니다.'); location.href='popupDeleteAccountConfirm.jsp';";
            } else {
                jsCode = "alert('비밀번호가 일치하지 않습니다.');";
            }
        } else {
            jsCode = "alert('잘못된 요청입니다.');";
        }
    }
%>

<div>
    <div class="content" style="text-align: center;">
        <img src="../../images/logo251.png" alt="Logo" style="width: 150px; margin-bottom: 50px;">
        <h3 class="section-title">회원 탈퇴</h3>
        <hr class="line_gray" style="width: 500px; margin: 0 auto; margin-bottom: 20px; margin-top: 20px;">
        <form method="post" style="width: 400px; margin: 0 auto; text-align: left;">
            <div style="margin-bottom: 15px; text-align: center; margin-top: 50px;">
                <p class="text" style="font-size: 20px;"><strong>회원 탈퇴시 모든 정보가 삭제됩니다.</strong></p>
                <p class="text" style="font-size: 20px;"><strong>탈퇴를 위해서는 비밀번호 확인이 필요합니다.</strong></p>
            </div>
            <div style="margin-bottom: 15px; margin-top: 80px;">
                <p class="text" style="font-size: 20px;"><strong>비밀번호 확인</strong></p>
                <input type="password" name="password" class="pass" style="width: 400px;" required /><br>
            </div>
            <div class="button-group" style="text-align: center; margin-top: 100px;">
                <button type="submit" class="btn btn-confirm" style="width: 150px;">탈퇴</button>
            </div>
        </form>
    </div>
</div>

<% if (!"".equals(jsCode)) { %>
<script>
    <%= jsCode %>
</script>
<% } %>
