<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../../jsp/external_file.jsp"/>

<link rel="stylesheet" href="../../css/style_headerfooter.css">
<link rel="stylesheet" href="../../css/style_main_page.css">
<link rel="stylesheet" href="../../css/style_accessory.css">
<link rel="stylesheet" href="../../css/style_user_menu.css">

<script>
    $(function(){
        $('#deleteBtn').on('click', function(e){
            e.preventDefault();
            alert("문의가 삭제되었습니다.");
            window.opener.$('.content').load('../common/component/mypage/myQuestion.jsp', function(response, status, xhr) {
                if (status === "error") {
                    console.error("myQuestion.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
                }
            });
            window.opener.$('#myquestion').addClass('active');
            window.opener.$('#myinfo').removeClass('active');
            window.close();
        });
    });
</script>

<div>
    <div class="content" style="text-align: center;">
        <img src="../../images/logo251.png" alt="Logo" style="width: 150px; margin-bottom: 50px;">
        <h3 class="section-title">문의 삭제</h3>
	    <hr class="line_gray" style="width: 500px; margin: 0 auto; margin-bottom: 20px; margin-top: 20px;">
        <form id="changePassForm" method="post" action="popupDeleteAccountConfirm.jsp" style="width: 400px; margin: 0 auto; text-align: left;">
            <div style="margin-bottom: 15px; text-align: center; margin-top: 50px;">
                <p class="text" style="font-size: 20px;"><strong>문의를 삭제하시겠습니까?</strong></p>
                <p class="text" style="font-size: 20px;"><strong>삭제 후 복구가 불가능합니다.</strong></p>
            </div>
            <div class="button-group" style="text-align: center; margin-top: 100px;">
                <button type="button" class="btn btn-danger" style="width: 150px;" id="deleteBtn">삭제</button>
                <button type="button" class="btn btn-secondary" style="width: 150px;" onclick="window.close()">취소</button>
            </div>
        </form>
    </div>
</div>