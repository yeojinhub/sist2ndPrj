<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%

%>
<!DOCTYPE html>
<html>
<jsp:include page="../common/jsp/login_external_file.jsp" />
<script>
var isIdCheck = false;

$(function(){	
	$('#email').keyup((evt)=>{
		emailChk();
	});
	
	$('#domain').keyup((evt)=>{
		emailChk();
	});
	
    $("#btnRigister").click(()=>{
		submit();
    });// click
    
    $("#confirmPassword").keyup((evt)=>{
		if(evt.which == 13) {
			submit();
		};// end if
    });// keyup
    
    $('#emailSelect').change(()=>{
		if ($('#emailSelect').val() == 'myself') {
			$('#domain').removeAttr('readonly');
			$('#domain').val('');
			$('#idCheck').html('');
			return;
		} else {
			$('#domain').attr('readonly', true);
		};// end if-else

		$('#domain').val($('#emailSelect').val());
    	
    	emailChk();
    	
    });
    
    $('#domain').val($('#emailSelect').val());
});// ready

function emailChk() {
	if ($('#email').val() == "") {
		$('#idCheck').html('<span style="color: #FF0000;">이메일을 입력해주세요.</span>');
		$('#email').focus();
		return;
	};// end if
	
	var koreanPattern = /[ㄱ-ㅎㅏ-ㅣ가-힣]/g;
	if (koreanPattern.test($('#email').val().trim())) {
	    $('#idCheck').html('<span style="color: #FF0000;">이메일에는 한글을 입력할 수 없습니다.</span>');
	    $('#email').focus();
	    return;
	}
	
	if ($('#domain').val() == "") {
		$('#idCheck').html('<span style="color: #FF0000;">도메인을 선택해주세요.</span>');
		return;
	};// end if
	
	if (koreanPattern.test($('#domain').val().trim())) {
	    $('#idCheck').html('<span style="color: #FF0000;">도메인에는 한글을 입력할 수 없습니다.</span>');
	    $('#email').focus();
	    return;
	}
	
	if (!$('#domain').val().includes('.')) {
		$('#idCheck').html('<span style="color: #FF0000;">올바른 도메인 형식이 아닙니다.</span>');
		$('#domain').focus();
		return;
	};// end if
	
	if ($('#domain').val() == "") {
		$('#idCheck').html('');
	};//end if
	
	var email = ($('#email').val() + '@' + $('#domain').val()).trim();
	
	var param = { id : email };
	
	$.ajax({
		url: "ajax_register_idcheck.jsp",
		type: "post",
		data: param,
		dataType: "json",
		error: function(xhr) {
			console.log(xhr.status);
		},
		success: function(jsonObj) {
			var color = "#FF0000;";
			var msg = "중복된 이메일이 존재합니다.";
			isIdCheck = jsonObj.isIdCheck;
			
			
			if (jsonObj.isIdCheck) {
				color = "#0000FF;"
				msg = "가입 가능한 이메일입니다.";
			};// end if
			
			var output="<span style='color: " + color +"'>" + msg + "</span>";
			
			$('#idCheck').html(output);
		}
	});
};

function submit() {
	// 입력 체크
	// 1. 이름을 입력해주세요
	if ($('#name').val() == "") {
		alert('이름을 입력해주세요.');
		$('#name').focus();
		return;
	};// end if 
	
	// 2. 이메일을 입력해주세요.
	if ($('#email').val() == "") {
		alert('이메일을 입력해주세요.');
		$('#email').focus();
		return;
	};// end if
	
	// 3. 전화번호를 입력해주세요.
	if ($('#phone').val() == "") {
		alert('전화번호를 입력해주세요.');
		$('#phone').focus();
		return;
	};// end if
	
	// 4. 전화번호 패턴 체크
    const phonePattern = /^\d{3}-\d{4}-\d{4}$/;
    
    if (!phonePattern.test($('#phone').val())) {
        alert('전화번호 형식이 올바르지 않습니다. 예: 010-1234-5678');
        $('#phone').focus();
        return;
    };// end if
    
 	// 5. 비밀번호를 입력해주세요.
	if ($('#pass').val() == "") {
		alert('비밀번호를 입력해주세요.');
		$('#pass').focus();
		return;
	};// end if 
	
	// 5-1. 비밀번호 길이 체크
    if ($('#pass').val().length < 8 || $('#pass').val().length > 20) {
        alert('비밀번호는 8자 이상 20자 이하로 입력해야 합니다.');
        $('#pass').focus();
        return;
    };// end if
    
    // 5-2. 비밀번호 영문자, 숫자, 특수문자 포함 여부 체크
    const hasLetter = /[a-zA-Z]/.test($('#pass').val());
    const hasNumber = /[0-9]/.test($('#pass').val());
    const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test($('#pass').val());

    if (!(hasLetter && hasNumber && hasSpecialChar)) {
        alert('비밀번호는 영문자, 숫자, 특수문자를 모두 포함해야 합니다.');
        $('#pass').focus();
        return;
    };// end if
	
 	// 6. 비밀번호 확인을 입력해주세요.
	if ($('#confirmPassword').val() == "") {
		alert('비밀번호 확인을 입력해주세요.');
		$('#confirmPassword').focus();
		return;
	};// end if 
	
	// 7. 비밀번호 확인 체크
	if ($('#pass').val() != $('#confirmPassword').val()) {
		alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.\n다시 입력해주세요.');
		$('#pass').val('');
		$('#confirmPassword').val('');
		$('#pass').focus();
		return;
	};// end if
	
	if (isIdCheck) {
    	$('#frmRigister').submit();
	} else {
		alert('입력하신 정보를 확인해주세요.');
	};//end if
	
};// submit
</script>
<style>
#emailSelect {
	padding: 10px 12px;
	border: 1px solid #e2e8f0;
	border-radius: 6px;
	font-size: 1rem;
	height: 45px;
}

#email {
	padding: 10px 12px;
	border: 1px solid #e2e8f0;
	border-radius: 6px;
	font-size: 1rem;
}

#domain {
	padding: 10px 12px;
	border: 1px solid #e2e8f0;
	border-radius: 6px;
	font-size: 1rem;
}
</style>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모두쉼 - 회원가입</title>
</head>
<body>

	<div>
		<img src="../common/images/main_pic.png" alt="배경 이미지"
			class="background-image"> <a href="../user/user_main_page.jsp"
			class="logo-container"> <img src="../common/images/logo251.png"
			alt="모두쉼 로고" class="logo-image">
		</a> <a href="../user/user_main_page.jsp" class="mobile-logo"> <img
			src="../common/images/logo251.png" alt="모두쉼 로고" class="logo-image">
		</a>

		<div class="id-form-container">
			<h1>회원가입</h1>
			<p>아래 정보를 입력하여 계정을 만드세요.</p>

			<form action="registerProcess.jsp" method="post" id="frmRigister"
				name="frmRigister">
				<div class="form-group">
					<label for="name">이름</label> <input type="text" id="name"
						name="name" placeholder="이름" required>
				</div>

				<label for="email">이메일</label>
				<div class="form-group" style="display: flex; align-items: center;">
					<input type="text" id="email" name="email" placeholder="이메일"
						style="width: 160px;" required> <span>@</span>
					<div id="selectDiv" style="flex: 0;">
						<select id="emailSelect" style="width: 150px;">
							<option value="">[이메일 선택]</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="daum.net">daum.net</option>
							<option value="hanmail.com">hanmail.com</option>
							<option value="yahoo.kr">yahoo.kr</option>
							<option value="myself">직접 입력</option>
						</select>
					</div>
					<input type="text" id="domain" name="domain" style="width: 160px;"
						readonly="readonly" />
				</div>
				<small style="padding-bottom: 10px;">이메일은 비밀번호 분실시 사용되므로 신중하게 작성해야합니다.</small>
				<div id="idCheck" style="margin-bottom: 10px;"></div>

				<div class="form-group">
					<label for="phone">전화번호</label> <input type="tel" id="phone"
						name="tel" placeholder="010-0000-0000"
						pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" required> 
						<small>형식: 010-0000-0000</small>
				</div>

				<div class="form-group">
					<label for="pass">비밀번호</label> <input type="password" id="pass"
						name="pass" placeholder="비밀번호" required>
				</div>

				<div class="form-group">
					<label for="confirmPassword">비밀번호 확인</label> <input type="password"
						id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인"
						required>
					<small>비밀번호의 길이가 8~20자가 되어야 합니다.</small>
					<small>비밀번호는 영문자, 숫자, 특수문자를 모두 포함해야 합니다.</small>
				</div>

				<button type="button" class="btn btn-confirm" id="btnRigister">회원가입</button>

				<div class="text-center" style="margin-top: 16px;">
					<a href="login.jsp" class="link">이미 계정이 있으신가요? 로그인</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
