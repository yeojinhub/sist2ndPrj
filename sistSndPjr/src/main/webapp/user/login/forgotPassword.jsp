<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<jsp:include page="../common/jsp/login_external_file.jsp"/>
<script>
$(function(){
	// 구글 SMTP를 이용한 비밀번호 찾기 기능 구현
	// 1. 사용자가 입력한 이메일
	
	
	// 2. click 이벤트로 유효성검사 후 파라미터(POST방식) 전송
	$('#btnSend').click(()=>{
		var email = $('#email').val();
		
		// 2-1. 입력한 이메일이 없을때.
		if (email == '') {
			alert('이메일을 입력해주세요.');
			$('#email').focus();
			return;
		};//end if
		
		// 2-2. 입력한 이메일의 형식이 이메일형식이 아닐때.
		console.log('[2-2.입력한 이메일의 형식이 이메일형식이 아닐때.] 유효성 검사 미구현');
		
		// 3. 이메일 유무 확인 및 SMTP이용한 이메일 전송 처리
		$.ajax({
			url:'ajax_forgotPassword_emailChk.jsp',
			type:'post',
			data: { email : email },
			dataType:'json',
			error:function(xhr) {
				console.log(xhr.status + ' / ' + xhr.statusText);
			},
			success:function(jsonObj) {
				// 3-1. 존재하지 않는 이메일일 경우 얼리 리턴
				if (!jsonObj.emailChk) {
					alert('존재하지 않는 이메일입니다.\n메인화면으로 돌아갑니다.');
					location.href = '../main/user_main_page.jsp';
					return;
				};//end if
				
				if (jsonObj.sendChk) {
					location.href = 'forgotPasswordSuccess.jsp';
					return;
				};//end if
				
				alert('이메일 전송에 실패하였습니다.\n잠시 후 재시도 해주세요.')
			}
		});//ajax
		
	});//click
	
});//ready
</script>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모두쉼 - 비밀번호 찾기</title>
</head>
<body>
    <div>
        <img src="../common/images/main_pic.png" alt="배경 이미지" class="background-image">
        <a href="../main/user_main_page.jsp" class="logo-container">
            <img src="../common/images/logo251.png" alt="모두쉼 로고" class="logo-image">
        </a>
        <a href="../main/user_main_page.jsp" class="mobile-logo">
            <img src="../common/images/logo251.png" alt="모두쉼 로고" class="logo-image">
        </a>
        
        <div class="id-form-container">
            <h1>비밀번호 찾기</h1>
            <p>가입한 이메일을 입력하시면</p>
            <p>비밀번호 재설정 링크를 보내드립니다.</p>  
            <form action="forgotPasswordSuccess.jsp" method="post">
                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" placeholder="이메일" required>
                </div>
                <input type="button" class="btn btn-confirm" value="비밀번호 재설정 링크 받기" id="btnSend"/>
                <div class="text-center" style="margin-top: 16px;">
                    <a href="login.jsp" class="link">로그인으로 돌아가기</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
