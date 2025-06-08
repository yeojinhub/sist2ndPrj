<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="../common/jsp/login_external_file.jsp"/>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모두쉼 - 비밀번호 찾기 성공</title>
</head>
<body style="margin-top: 100px;">
    <div class="success-container" style="height: 400px;">
        <img src="../common/images/main_pic.png" alt="배경 이미지" class="background-image">
        <div class="success-icon">✓</div>
        <h1>비밀번호 재설정 이메일 발송 완료</h1>
        <p class="success-message">비밀번호 재설정 링크가 이메일로 발송되었습니다.</p>
        <p>이메일을 확인하여 비밀번호 재설정 링크를 클릭해주세요.</p>
        <p>이메일이 도착하지 않았다면 스팸함을 확인하거나 다시 시도해주세요.</p>
        <a href="login.jsp" class="btn btn-confirm btn-sm">로그인 페이지로 돌아가기</a>
    </div>
</body>
</html>
