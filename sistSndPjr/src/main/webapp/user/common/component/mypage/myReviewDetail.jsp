<%@page import="user.mypage.review.ReviewDTO"%>
<%@page import="user.mypage.review.ReviewService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    int revNum = Integer.parseInt(request.getParameter("rev_num"));
    ReviewService rs = new ReviewService();
    ReviewDTO review = rs.searchReviewByNum(revNum);
%>
<script>
    function deleteReview(revNum){
        window.open("../common/component/mypage/popupDeleteMyReview.jsp?rev_num=" + revNum, "popup", "width=600, height=750, left=700, top=100");
    }

    function modifyReview(revNum){
        if(confirm("리뷰를 수정하시겠습니까?")){
            window.parent.$('.content').load('../common/component/mypage/myReviewModify.jsp?rev_num=' + revNum, function(response, status, xhr) {
                if (status === "error") {
                    console.error("myReviewModify.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
                } else {
                    console.log("myReviewModify.jsp 로드 성공.");
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
	            <td colspan="3"><%= review.getArea_name() %></td>
	        </tr>
	        <tr>
	            <th>작성일</th>
	            <td><%= review.getInput_date() %></td>
	        </tr>
	    </thead>
	    <tbody>
	        <tr>
	            <td colspan="4" style="height: 300px; vertical-align: top; padding: 15px;">
	                <%= review.getContent().replace("\n", "<br>") %>
	            </td>
	        </tr>
	    </tbody>
	</table>
	<div class="button-group">
	    <button class="btn btn-confirm" onclick="modifyReview(<%= review.getRev_num() %>)">수정</button>
	    <button class="btn btn-cancel" onclick="deleteReview(<%= review.getRev_num() %>)">삭제</button>
	</div>
</div>