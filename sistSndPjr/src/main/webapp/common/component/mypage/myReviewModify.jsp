<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
    $(function(){
        $('#modifyBtn').on('click', function(e){
            e.preventDefault();
            alert("리뷰가 수정되었습니다.");
            window.parent.$('.content').load('../common/component/mypage/myReview.jsp', function(response, status, xhr) {
                if (status === "error") {
                    console.error("myReview.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
                }
            });
        });
    });
</script>

<div style="position: relative;">
    <h3 class="section-title">리뷰 수정</h3>
	<hr class="line_gray">
	
	<table class="user_table">
    <thead>
        <tr>
            <th style="width: 25%;">휴게소명</th>
            <td colspan="3">강릉(인천)</td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>홍길동</td>
            <th>작성일</th>
            <td>2025-05-05</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="4" style="height: 300px; vertical-align: top; padding: 15px;">
                <textarea name="content" id="content" style="width: 100%; height: 100%; border: none; outline: none; padding: 0; margin: 0; box-sizing: border-box;">
                    휴게소분들 너무 친절해서 좋았는데 음식이 너무 짜네요 ㅠㅠ
                </textarea>
            </td>
        </tr>
    </tbody>
</table>
<div class="button-group">
    <button class="btn btn-confirm" id="modifyBtn">수정</button>
</div>