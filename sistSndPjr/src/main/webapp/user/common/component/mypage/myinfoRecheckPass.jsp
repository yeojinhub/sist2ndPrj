<%@page import="kr.co.sist.cipher.DataEncryption"%>
<%@page import="kr.co.sist.cipher.DataDecryption"%>
<%@page import="user.account.login.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
$(function(){
    $('#confirm').on('click', function(){
        var inputPass = $('#pass').val();

        if (inputPass==null||inputPass == "") {
            alert("비밀번호를 입력해주세요.");
            return;
        }

        $.ajax({
            url: '../common/component/mypage/checkPassProcess.jsp', // 위치 맞게 조정
            method: 'POST',
            data: { password: inputPass },
            dataType: 'json',
            success: function(response) {
                if (response.match === true) {
                	alert("비밀번호가 확인되었습니다.");
                    $('.content').load('../common/component/mypage/myinfo.jsp');
                } else {
                    alert("비밀번호가 일치하지 않습니다.");
                    $('#pass').val('').focus();
                }
            },
            error: function(xhr, status, error) {
                console.error("비밀번호 확인 중 오류:", error);
                alert("서버 오류가 발생했습니다.");
                console.log(xhr.status);
            }
        });
    });
});

</script>

<h3 class="section-title">내 정보 - 본인 확인</h3>
	<hr class="line_gray">
	<p class="text">비밀번호를 다시 한 번 입력해 주세요.</p>
	<form id="passChk_frm" action="user_mypage.jsp">
	<input type="password" name="password" id="pass" class="pass"/><br>
	<div class="button-group">
	<button type="button" class="btn btn-confirm" id="confirm">확인</button>
	<button type="button" class=" btn btn-cancel" onclick="history.back()">취소</button>
	</div>
	</form>