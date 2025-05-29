<%@page import="kr.co.sist.cipher.DataDecryption"%>
<%@page import="DTO.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");
    DataDecryption dd = new DataDecryption("asdf1234asdf1234");

    String name = dd.decrypt(lDTO.getName());
    String email = dd.decrypt(lDTO.getUser_email());
    String tel = dd.decrypt(lDTO.getTel());

    pageContext.setAttribute("name", name);
    pageContext.setAttribute("email", email);
    pageContext.setAttribute("tel", tel);
    
    System.out.println("🧾 세션 내 이름: " + lDTO.getName());
    System.out.println("🔓 복호화한 이름: " + name);
%>

<script>
    function changePass() {
        var width = 600;
        var height = 750;
        var left = 700;
        var top = 100;
        window.open("../common/component/mypage/popupChangePass.jsp", "popup", "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top);
    }

    function deleteUser() {
        var width = 600;
        var height = 750;
        var left = 700;
        var top = 100;
        window.open("../common/component/mypage/popupDeleteAccount.jsp", "popup", "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top);
    }
    
    function toggleEditMode(btn) {
        const form = document.getElementById("infoForm");
        const nameInput = form.querySelector('input[name="name"]');
        const telInput = form.querySelector('input[name="tel"]');

        const isEditing = btn.dataset.editing === "true";

        if (isEditing) {
            // 확인 누른 상태 → form 제출
            form.submit();
        } else {
            // 수정 누른 상태 → 입력 가능하게
            nameInput.removeAttribute("readonly");
            telInput.removeAttribute("readonly");
            btn.textContent = "확인";
            btn.dataset.editing = "true";
        }
    }
</script>

<form id="infoForm" method="post" action="../common/component/mypage/updateUserInfo.jsp">
    <div style="position: relative;">
        <h3 class="section-title">내 정보</h3>
        <button type="button" class="btn btn-secondary" style="position: absolute; right: 10px; top: -10px;" onclick="deleteUser()">탈퇴</button>
        <hr class="line_gray">

        <p class="text"><strong>이름</strong></p>
        <input type="text" name="name" value="${name}" class="pass" readonly /><br>

        <p class="text"><strong>이메일</strong></p>
        <input type="text" name="email" value="${email}" class="pass" readonly /><br>

        <p class="text"><strong>전화번호</strong></p>
        <input type="text" name="tel" value="${tel}" class="pass" readonly /><br>

        <div class="button-group">
            <button type="button" class="btn btn-confirm" onclick="toggleEditMode(this)" data-editing="false">수정</button>
            <button type="button" class="btn btn-cancel" onclick="changePass()">비밀번호 변경</button>
        </div>
    </div>
</form>