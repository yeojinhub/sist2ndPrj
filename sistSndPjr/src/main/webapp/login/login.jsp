<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="../common/jsp/login_external_file.jsp"/>
<script>
    $(function(){
        
    });

    function login() {
        alert("로그인이 완료되었습니다.");
        location.href = "../user/user_main_page.jsp";
    }
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
            <h1>로그인</h1>
            <p>계정 정보를 입력하여 로그인하세요.</p>
            
            <form action="loginProcess.jsp" method="post">
                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" placeholder="이메일" required>
                </div>
                
                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" placeholder="비밀번호" required>
                </div>
                
                <div class="form-footer">
                    <div class="remember-me">
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember">아이디 기억하기</label>
                    </div>
                    
                    <a href="forgotPassword.jsp" class="forgot-password">비밀번호 찾기</a>
                </div>
                
                <button type="button" class="btn btn-confirm" onclick="login()">로그인</button>
            </form>
            
            <a href="register.jsp" class="btn btn-cancel">회원가입</a>
        </div>
    </div>
</body>
</html>
