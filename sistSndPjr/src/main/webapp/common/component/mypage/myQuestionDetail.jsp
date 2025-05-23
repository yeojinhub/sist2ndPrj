<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<script>
$(function() {
    $('#deleteBtn').on('click', function(e) {
        window.open("../common/component/mypage/popupDeleteMyQuestion.jsp", "popup", "width=600, height=750, left=700, top=100");
    });
});


function goToList() {
    window.parent.$('.content').load('../common/component/mypage/myQuestion.jsp', function(response, status, xhr) {
        if (status === "error") {
            console.error("myQuestion.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
        }
    });
    window.parent.$('#myquestion').addClass('active');
    window.parent.$('#myinfo').removeClass('active');
}
</script>

<div style="position: relative;">
    <h3 class="section-title">문의 상세페이지</h3>
	<hr class="line_gray">
	
	<table class="user_table">
    <thead>
        <tr>
            <th style="width: 25%;">제목</th>
            <td colspan="3">회원탈퇴 어떻게 해요?</td>
        </tr>
        <tr>
            <th>작성일</th>
            <td>2025-05-05</td>
            <th>답변여부</th>
            <td>답변완료</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th>문의 내용</th>
            <td colspan="4" style="height: 300px; vertical-align: top; padding: 15px; text-align: left;">
                휴게소분들 너무 친절해서 좋았는데 음식이 너무 짜네요 ㅠㅠ
            </td>
        </tr>
        <tr>
            <th>답변 내용</th>
            <td colspan="4" style="height: 300px; vertical-align: top; padding: 15px; text-align: left;">
                휴게소분들 너무 친절해서 좋았는데 음식이 너무 짜네요 ㅠㅠ
            </td>
        </tr>
    </tbody>
</table>
<div class="button-group">
    <button class="btn btn-confirm" onclick="goToList()">목록</button>
    <button class="btn btn-cancel" id="deleteBtn">삭제</button>
</div>