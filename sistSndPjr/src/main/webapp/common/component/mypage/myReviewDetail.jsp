<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
    function deleteReview(){
        window.open("../common/component/mypage/popupDeleteMyReview.jsp", "popup", "width=600, height=750, left=700, top=100");
    }

    function modifyReview(){
        if(confirm("리뷰를 수정하시겠습니까?")){
            window.parent.$('.content').load('../common/component/mypage/myReviewModify.jsp', function(response, status, xhr) {
                if (status === "error") {
                    console.error("myReview.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
                } else {
                    console.log("myReview.jsp 로드 성공.");
                }
            });
        }
    }
</script>

<div style="position: relative;">
    <h3 class="section-title">리뷰 상세페이지</h3>
	<hr class="line_gray">
	
	<table class="user_table">
    <thead>
        <tr>
            <th style="width: 25%;">휴게소명</th>
            <td colspan="3">강릉(인천)</td>
        </tr>
        <tr>
            <th>작성일</th>
            <td>2025-05-05</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="4" style="height: 300px; vertical-align: top; padding: 15px;">
                휴게소분들 너무 친절해서 좋았는데 음식이 너무 짜네요 ㅠㅠ
            </td>
        </tr>
    </tbody>
</table>
<div class="button-group">
    <button class="btn btn-confirm" onclick="modifyReview()">수정</button>
    <button class="btn btn-cancel" onclick="deleteReview()">삭제</button>
</div>