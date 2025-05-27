<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<jsp:include page="../common/jsp/login_external_file.jsp"/>
<script>
    $(function(){
        $('#btnLogin').click(()=>{
			var email = $('#user_email').val();
			var pass = $('#pass').val();
			var param = {user_email : email, pass : pass};
        	
        	$.ajax({
				url: 'loginProcess.jsp',
				type: 'post',
				data: param,
				dataType: 'json',
				error:function(xhr) {
					console.log(xhr.status + ' / ' + xhr.statusText);
				},
				success:function(jsonObj) {
					if (!jsonObj.loginFlag) {
						alert("로그인 실패\n아이디와 비밀번호를 확인해주세요.");
						return;
					};// end if
					
					alert("로그인 성공!\n메인화면으로 넘어갑니다.");
					location.href = "../user/user_main_page.jsp";
				}
        	});// ajax
        });// click
    });// ready
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
            
            <form action="loginProcess.jsp" method="post" id="frmLogin" name="frmLogin">
                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" id="user_email" name="user_email" placeholder="이메일" required>
                </div>
                
                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="pass" name="pass" placeholder="비밀번호" required>
                </div>
                
                <div class="form-footer">
                    <div class="remember-me">
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember">아이디 기억하기</label>
                    </div>
                    
                    <a href="forgotPassword.jsp" class="forgot-password">비밀번호 찾기</a>
                </div>
                
                <button type="button" class="btn btn-confirm" id="btnLogin">로그인</button>
            </form>
            
            <a href="register.jsp" class="btn btn-cancel">회원가입</a>
        </div>
    </div>
</body>
</html>
