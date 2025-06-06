<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<jsp:include page="../../user/common/jsp/login_external_file.jsp"/>
<script>
$(function(){
    $('#admin_loginForm').submit(function(e){
        e.preventDefault();
        
        var id = $('#admin_id').val();
        var pass = $('#admin_pass').val();
        
        $.ajax({
            url: 'admin_loginProcess.jsp',
            type: 'post',
            data: { admin_id: id, admin_pass: pass },
            dataType: 'json',
            error: function(xhr) {
                console.log(xhr.status + ' / ' + xhr.statusText);
                alert("서버 에러가 발생했습니다.");
            },
            success: function(jsonObj) {
                if (!jsonObj.loginFlag) {
                    alert("로그인 실패\n아이디와 비밀번호를 확인해주세요.");
                    $('#admin_id').val('');
                    $('#admin_pass').val('');
                    $('#admin_id').focus();
                    return;
                }//if

                if (jsonObj.withdraw) {
                    alert('탈퇴한 계정입니다.\n계정 복구는 고객센터로 문의주세요.');
                    $('#admin_id').val('');
                    $('#admin_pass').val('');
                    $('#admin_id').focus();
                    return;
                }//if
                
                alert("로그인 성공!\n메인화면으로 이동합니다.");
                location.href = "../home.jsp";
            }
        });
    });
});
</script>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모두쉼 - 로그인</title>
</head>
<body>
    <div>
        <img src="../common/images/main_pic.png" alt="배경 이미지" class="background-image">    
        <a href="../user/user_main_page.jsp" class="logo-container">
            <img src="../common/images/logo251.png" alt="모두쉼 로고" class="logo-image">
        </a>
        <a href="../user/user_main_page.jsp" class="mobile-logo">
            <img src="../common/images/logo251.png" alt="모두쉼 로고" class="logo-image">
        </a>
        
        <div class="id-form-container">
            <h1>관리자 로그인</h1>
            <p>계정 정보를 입력하여 로그인하세요.</p>
            
            <form id="admin_loginForm" action="admin_loginProcess.jsp" method="post">
                <div class="form-group">
                    <label for="id">아이디</label>
                    <input type="text" id="admin_id" name="admin_id" placeholder="아이디" required>
                </div>
                
                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="admin_pass" name="admin_pass" placeholder="비밀번호" required>
                </div>
                <button type="submit" class="btn btn-confirm">로그인</button>
            </form>
        </div>
    </div>
</body>
</html>
