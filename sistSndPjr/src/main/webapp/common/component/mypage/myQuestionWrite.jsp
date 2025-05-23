<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
    $(function(){
        $('#writeBtn').on('click', function(e){
            e.preventDefault();
            alert("문의가 작성되었습니다.");
            
            // 부모 페이지의 메뉴 활성화 및 내용 로드
            var $parentMenu = window.parent.$('.menu li a#myquestion');
            $parentMenu.parent().addClass('active');
            window.parent.$('.menu li').not($parentMenu.parent()).removeClass('active');
            
            // 문의내역 내용 로드
            window.parent.$('.content').load('../common/component/mypage/myQuestion.jsp', function(response, status, xhr) {
                if (status === "error") {
                    console.error("myQuestion.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
                }
            });
        });

        $('#cancelBtn').on('click', function(e){
            e.preventDefault();
            window.parent.$('.content').load('../common/component/mypage/myQuestion.jsp', function(response, status, xhr) {
                if (status === "error") {
                    console.error("myQuestion.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
                }
            });
            window.parent.$('#myquestion').addClass('active');
            window.parent.$('#myinfo').removeClass('active');
        });
    });
</script>

<style>
    .user_table input[type="text"],
    .user_table textarea {
        width: 100%;
        height: 100%;
        border: none;
        outline: none;
        padding: 0;
        margin: 0;
        box-sizing: border-box;
    }
    
    .user_table td {
        padding: 0 !important;
    }
    
    .user_table td input[type="text"] {
        padding: 8px;
    }
    
    .user_table td textarea {
        padding: 15px;
        resize: none;
    }
</style>

<div style="position: relative;">
    <h3 class="section-title">문의 작성</h3>
	<hr class="line_gray">
	
	<table class="user_table">
    <thead>
        <tr>
            <th style="width: 25%;">제목</th>
            <td colspan="3"><input type="text" name="title" placeholder="제목을 입력해주세요."></td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th>내용</th>
            <td colspan="4" style="height: 300px; vertical-align: top;">
                <textarea name="content" placeholder="내용을 입력해주세요."></textarea>
            </td>
        </tr>
    </tbody>
</table>
<div class="button-group">
    <button class="btn btn-confirm" id="writeBtn">작성</button>
    <button class="btn btn-cancel" id="cancelBtn">취소</button>
</div>