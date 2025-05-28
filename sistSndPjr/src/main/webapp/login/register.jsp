<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%




%>
<!DOCTYPE html>
<html>
<jsp:include page="../common/jsp/login_external_file.jsp"/>
<script>
var isIdCheck = false;

$(function(){
	$('#email').keyup((evt)=>{
		var email = $('#email').val();
		
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
			/* $('#domain') */
		};
    });
    
    $('#domain').val($('#emailSelect').val());
});// ready

function submit() {
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
            
            <form action="registerProcess.jsp" method="post" id="frmRigister" name="frmRigister">
                <div class="form-group">
                    <label for="name">이름</label>
                    <input type="text" id="name" name="name" placeholder="이름" required>
                </div>
                
                <label for="email">이메일</label>
                <div class="form-group" style="display: flex; align-items: center;">
                    <input type="text" id="email" name="user_email" placeholder="이메일" style="width: 160px;" required>
                    <span>@</span>	                  
                    <div id="selectDiv" style="flex: 0;">
	                    <select id="emailSelect" style="width: 150px;">
	                    	<option value="naver.com">naver.com</option>
	                    	<option value="gmail.com">gmail.com</option>
	                    	<option value="daum.net">daum.net</option>
	                    	<option value="hanmail.com">hanmail.com</option>
	                    	<option value="yahoo.kr">yahoo.kr</option>
	                    	<option value="myself">직접 입력</option>
	                    </select>
                    </div>
                    <input type="text" id="domain" style="width: 160px;" readonly="readonly"/>
                    <div id="idCheck" style="margin-top: 10px;"></div>
                </div>
                
                <div class="form-group">
                    <label for="phone">전화번호</label>
                    <input type="tel" id="phone" name="tel" placeholder="010-0000-0000" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" required>
                    <small>형식: 010-0000-0000</small>
                </div>

                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="pass" name="pass" placeholder="비밀번호" required>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">비밀번호 확인</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인" required>
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
