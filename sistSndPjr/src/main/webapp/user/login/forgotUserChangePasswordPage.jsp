<%@page import="kr.co.sist.cipher.DataEncryption"%>
<%@page import="kr.co.sist.cipher.DataDecryption"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String myKey = "asdf1234asdf1234";
DataEncryption de = new DataEncryption(myKey);
DataDecryption dd = new DataDecryption(myKey);

// 1. 잘못된 접근 방지 위해 sessionID를 체크하자.
// 1-1. QueryString으로 받아온 sessionId 변수.
String sessionId = request.getParameter("si");

// 2. 접속한 sessionID와 일치 여부 확인.
boolean sessionChk = false;
String nowSessionId = de.encrypt(request.getSession().getId());
if (!nowSessionId.equals(sessionId)) {
	sessionChk = true;
} // end if

// 3. EL문 사용을 위한 setAttribute
pageContext.setAttribute("sessionChk", sessionChk);

// 4. 사용자에게 입력받은 이메일과 비밀번호 재설정을 요청한 이메일이 일치하는지 확인하기 위해 이메일 파라미터값 setAttribute
// 4-1. 암호화된 이메일파라미터 복호화
pageContext.setAttribute("email", request.getParameter("e"));
pageContext.setAttribute("originalEmail", dd.decrypt(request.getParameter("e")));
%>
<!DOCTYPE html>
<html>
<jsp:include page="../common/jsp/login_external_file.jsp" />
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모두쉼 - 비밀번호 재설정</title>
</head>
<script>
$(function() {
	var email = '${originalEmail}';
	
	$('#btnChange').click(()=>{
		// 1. 유효성 검사
		// 1-1. 이메일 입력란 공란 체크
		if ($('#email').val() == "") {
			alert('이메일을 입력해주세요.');
			$('#email').focus();
			return;
		};//end if
		
		// 1-2. 새비밀번호 입력란 공란 체크
		if ($('#pass').val() == "") {
			alert('새로운 비밀번호를 입력해주세요.');
			$('#pass').focus();
			return;
		};//end if
		
		// 1-3. 비밀번호 재설정을 신청한 이메일과 입력받은 이메일이 일치한지 체크
		if (email != $('#email').val()) {
			alert('비밀번호 재설정을 신청한 이메일과 일치하지 않습니다.\n확인하고 다시 입력해주세요.');
			$('#email').val('');
			$('#email').focus();
			return;
		};//end if
		
		// 1-4. 새로운 비밀번호 길이 체크
	    if ($('#pass').val().length < 8 || $('#pass').val().length > 20) {
	        alert('비밀번호는 8자 이상 20자 이하로 입력해야 합니다.');
	        $('#pass').val('');
	        $('#pass').focus();
	        return;
	    };// end if
	    
	    // 1-5. 비밀번호 영문자, 숫자, 특수문자 포함 여부 체크
	    const hasLetter = /[a-zA-Z]/.test($('#pass').val());
	    const hasNumber = /[0-9]/.test($('#pass').val());
	    const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test($('#pass').val());

	    if (!(hasLetter && hasNumber && hasSpecialChar)) {
	        alert('비밀번호는 영문자, 숫자, 특수문자를 모두 포함해야 합니다.');
	        $('#pass').val('');
	        $('#pass').focus();
	        return;
	    };// end if
	    
	    // 2. ajax로 비밀번호 변경 후 JSON으로 결과 받기
	    var pass = $('#pass').val();
	    
	    $.ajax({
			url:'ajax_forgotPassword_changePass.jsp',
			type:'post',
			data:{ pass : pass , email : '${email}' },
			dataType:'json',
			error:function(xhr) {
				console.log(xhr.status + ' / ' + xhr.statusText)
			},
			success:function(jsonObj) {
				if(jsonObj.changeChk) {
					alert('비밀번호가 변경되었습니다.\n로그인화면으로 이동합니다.')
					location.href = 'login.jsp';
					return;
				};//end if
				
				alert('비밀번호 변경에 실패하였습니다.\n다시 시도 해주세요.');
			}
	    });//ajax
		
	});//click
	
});//ready
</script>
<body style="margin-top: 100px;">
	<div class="success-container" style="width: 300vh; height: 500px;">
		<img src="../common/images/main_pic.png" alt="배경 이미지"
			class="background-image">
		<c:choose>
			<c:when test="${sessionChk }">
				<div class="success-icon">⚠️</div>
				<h1>비정상적인 접근</h1>
				<p style="margin-top: 80px; margin-bottom: 120px; font-size: 20px;">
					비정상적인 접근이 감지되었습니다.<br>다시 접속해 주시기 바랍니다.
				</p>
				<input type="button" class="btn btn-success" value="메인화면으로 가기"
					onclick="location.href='../main/user_main_page.jsp'" />
			</c:when>
			<c:otherwise>
				<div class="success-icon">✓</div>
				<h1>비밀번호 재설정</h1>
				<p>본인의 이메일과 새로운 비밀번호를 입력해주세요.</p>
				<div id="id-form-container">
					<div class="form-group" style="text-align: left;">
						<label for="email">이메일</label> <input type="email" id="email"
							name="email" placeholder="이메일" required>
					</div>
					<div class="form-group"
						style="text-align: left; margin-top: 20px; margin-bottom: 40px;">
						<label for="pass">새로운 비밀번호</label> <input type="password"
							id="pass" name="pass" placeholder="새로운 비밀번호" required>
					</div>

					<input type="button" class="btn btn-confirm" id="btnChange" value="비밀번호 재설정" />
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>