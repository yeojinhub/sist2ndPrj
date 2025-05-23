<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="../common/jsp/login_external_file.jsp"/>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모두쉼 - 비밀번호 찾기</title>
</head>
<body>
    <div>
        <img src="../common/images/main_pic.png" alt="배경 이미지" class="background-image">
        <a href="../../../index.html" class="logo-container">
            <img src="../common/images/logo251.png" alt="모두쉼 로고" class="logo-image">
        </a>
        <a href="../../../index.html" class="mobile-logo">
            <img src="../common/images/logo251.png" alt="모두쉼 로고" class="logo-image">
        </a>
        
        <div class="id-form-container">
            <h1>비밀번호 찾기</h1>
            <p>가입한 이메일을 입력하시면</p>
            <p>비밀번호 재설정 링크를 보내드립니다.</p>  
            
            <% 
            // 에러 메시지 표시
            String error = request.getParameter("error");
            if (error != null) {
                if (error.equals("1")) {
            %>
                <div class="error-message">
                    등록되지 않은 이메일입니다. 다시 확인해주세요.
                </div>
            <% 
                } else if (error.equals("2")) {
            %>
                <div class="error-message">
                    시스템 오류가 발생했습니다. 잠시 후 다시 시도해주세요.
                </div>
            <% 
                }
            }
            %>
            
            <form action="forgotPasswordSuccess.jsp" method="post">
                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" placeholder="이메일" required>
                </div>
                
                <button type="submit" class="btn btn-confirm">비밀번호 재설정 링크 받기</button>
                
                <div class="text-center" style="margin-top: 16px;">
                    <a href="login.jsp" class="link">로그인으로 돌아가기</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
