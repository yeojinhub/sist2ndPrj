<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DTO.LoginDTO" %>
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
        String currentPw = request.getParameter("password");
        String newPw = request.getParameter("newPassword");
        String chkPw = request.getParameter("chkPassword");

        LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");

        if (lDTO != null && currentPw != null && newPw != null && chkPw != null) {
            String encryptedCurrent = DataEncryption.messageDigest("SHA-256", currentPw);
            String sessionPw = lDTO.getPass(); // 세션에 저장된 암호화된 비밀번호
         

            if (!encryptedCurrent.equals(sessionPw)) {
                jsCode = "alert('현재 비밀번호가 일치하지 않습니다.');";
            }else if (!newPw.equals(chkPw)) {
                jsCode = "alert('새 비밀번호와 비밀번호 확인이 일치하지 않습니다.');";
            } else if(newPw.length() < 8 || newPw.length() > 20){
            	jsCode = "alert('비밀번호는 8자 이상 20자 이하로 입력해야 합니다.');";
            } else if (!newPw.matches("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{8,20}$")) {
                jsCode = "alert('새 비밀번호는 영문, 숫자, 특수문자를 모두 포함해야 합니다.');";
            } else if (newPw.contains(" ")) {
                jsCode = "alert('비밀번호에 공백은 사용할 수 없습니다.');";
            }else {
                String encryptedNewPw = DataEncryption.messageDigest("SHA-256", newPw);
                if (encryptedNewPw.equals(sessionPw)) {
                    jsCode = "alert('현재 비밀번호와 다른 비밀번호를 입력해주세요.');";
                } else {
                    // 모든 조건 통과 → 다음 페이지로 전달
%>
<jsp:forward page="popupChangePassConfirm.jsp">
    <jsp:param name="newPassword" value="<%= newPw %>" />
</jsp:forward>
<%
                    return;
                }
            }
        } else {
            jsCode = "alert('입력값이 부족합니다.');";
        }
    }
%>

<div>
    <div class="content" style="text-align: center;">
        <img src="../../images/logo251.png" alt="Logo" style="width: 150px; margin-bottom: 50px;">
        <h3 class="section-title">비밀번호 변경</h3>
	    <hr class="line_gray" style="width: 500px; margin: 0 auto; margin-bottom: 20px; margin-top: 20px;">
        <form method="post" style="width: 400px; margin: 0 auto; text-align: left;">
		    <div style="margin-bottom: 15px;">
		        <p class="text"><strong>현재 비밀번호</strong></p>
		        <input type="password" name="password" class="pass" style="width: 400px;" required /><br>
		    </div>
		    <div style="margin-bottom: 15px;">
		        <p class="text"><strong>새로운 비밀번호</strong></p>
		        <input type="password" name="newPassword" class="pass" style="width: 400px;" required /><br>
		        <small style="color: #666;">비밀번호는 8~20자 이내이어야 합니다.</small><br>
		        <small style="color: #666;">비밀번호는 영문, 숫자, 특수기호를 모두 포함하여야 합니다.</small>
		    </div>
		    <div style="margin-bottom: 25px;">
		        <p class="text"><strong>비밀번호 확인</strong></p>
		        <input type="password" name="chkPassword" class="pass" style="width: 400px;" required /><br>
		    </div>
		    <div class="button-group" style="text-align: center;">
		        <button type="submit" class="btn btn-confirm" style="width: 150px;">변경</button>
		    </div>
		</form>
    </div>
</div>

<% if (!"".equals(jsCode)) { %>
<script>
    <%= jsCode %>
</script>
<% } %>


