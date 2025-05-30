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
        const telInput = form.querySelector('input[name="tel"]');
        const hintText = document.getElementById("editHint");

        const isEditing = btn.dataset.editing === "true";

        if (isEditing) {
        	const phonePattern = /^\d{3}-\d{4}-\d{4}$/;
            
            if (!phonePattern.test($('#tel').val())) {
                alert('전화번호 형식이 올바르지 않습니다. 예: 010-1234-5678');
                $('#tel').focus();
                return;
            };// end if
            form.submit();
        } else {
            // 이름은 수정 불가니까 tel만 editable 처리
            telInput.removeAttribute("readonly");
            telInput.focus();

            btn.textContent = "확인";
            btn.dataset.editing = "true";
            btn.classList.add("editing");

            hintText.style.display = "block";
        }
    }
</script>
<style>
input.pass[readonly] {
    background-color: #f0f0f0;
    color: #555;
    border: 1px solid #ccc;
}

input.pass:not([readonly]) {
    background-color: #ffffff;
    color: #000;
    border: 1px solid #4CAF50;
}

button.btn-confirm.editing {
    background-color: #4CAF50; /* 초록색 */
    color: white;
    font-weight: bold;
}
</style>
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
        <input type="text" name="tel" value="${tel}" id="tel" class="pass" readonly /><br>

        <div class="button-group">
            <button type="button" class="btn btn-confirm" onclick="toggleEditMode(this)" data-editing="false">수정</button>
            <button type="button" class="btn btn-cancel" onclick="changePass()">비밀번호 변경</button>
        </div>
    </div>
</form>