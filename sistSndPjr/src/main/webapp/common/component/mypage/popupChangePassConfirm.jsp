<%@page import="kr.co.sist.cipher.DataEncryption"%>
<%@page import="myPage.InfoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DTO.LoginDTO" %>
<jsp:include page="../../jsp/external_file.jsp"/>

<link rel="stylesheet" href="../../css/style_headerfooter.css">
<link rel="stylesheet" href="../../css/style_main_page.css">
<link rel="stylesheet" href="../../css/style_accessory.css">
<link rel="stylesheet" href="../../css/style_user_menu.css">

<%
    request.setCharacterEncoding("UTF-8");
    LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");
    String newPassword = request.getParameter("newPassword");

    if (lDTO != null && newPassword != null) {
        try {
            String email = lDTO.getUser_email();

          	InfoService is = new InfoService(); // 일반 클래스
            is.changePassword(email, newPassword); // 비밀번호 변경 수행

            String newPw = DataEncryption.messageDigest("SHA-256", newPassword);
       		lDTO.setPass(newPw);
            session.setAttribute("userData", lDTO);
            
        } catch (Exception e) {
            e.printStackTrace();
%>
<script>
    alert("비밀번호 변경 중 오류가 발생했습니다.");
    window.close();
</script>
<%
            return;
        }
    } else {
%>
<script>
    alert("잘못된 접근입니다.");
    window.close();
</script>
<%
        return;
    }
%>

<div>
    <div class="content" style="text-align: center;">
        <img src="../../images/logo251.png" alt="Logo" style="width: 150px; margin-bottom: 50px;">
        <h3 class="section-title">비밀번호 변경</h3>
        <hr class="line_gray" style="width: 500px; margin: 0 auto; margin-bottom: 20px; margin-top: 20px;">
        <div class="content-text" style="font-size: 20px; font-weight: bold; margin-top: 50px;">
            <p>비밀번호가 변경되었습니다.</p>
        </div>
        <div class="button-group">
            <button type="button" class="btn btn-confirm" style="margin-top: 230px;" onclick="window.close()">닫기</button>
        </div>
    </div>
</div>
