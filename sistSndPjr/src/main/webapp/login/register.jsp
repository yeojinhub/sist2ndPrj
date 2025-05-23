<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="../common/jsp/login_external_file.jsp"/>
<script>
$(function(){
    
});

function register() {
    alert("회원가입이 완료되었습니다.\n로그인 페이지로 이동합니다.");
    location.href = "../user/user_main_page.jsp";
}
</script>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모두쉼 - 회원가입</title>
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
            <h1>회원가입</h1>
            <p>아래 정보를 입력하여 계정을 만드세요.</p>
            
            <form action="registerProcess.jsp" method="post">
                <div class="form-group">
                    <label for="name">이름</label>
                    <input type="text" id="name" name="name" placeholder="이름" required>
                </div>
                
                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" placeholder="이메일" required>
                </div>
                
                <div class="form-group">
                    <label for="phone">전화번호</label>
                    <input type="tel" id="phone" name="phone" placeholder="010-0000-0000" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" required>
                    <small>형식: 010-0000-0000</small>
                </div>

                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" placeholder="비밀번호" required>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">비밀번호 확인</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인" required>
                </div>
                
                <button type="button" class="btn btn-confirm" onclick="register()">회원가입</button>
                
                <div class="text-center" style="margin-top: 16px;">
                    <a href="login.jsp" class="link">이미 계정이 있으신가요? 로그인</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
