<%@page import="user.mypage.review.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="user.mypage.review.ReviewService"%>
<%@page import="user.account.login.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");
    String email = lDTO.getUser_email();

    ReviewService rs = new ReviewService();
    List<ReviewDTO> reviewList = rs.searchReviewsByEmail(email);

    request.setAttribute("reviewList", reviewList);
%>

<style>
.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 16px;
}
.pagination button {
    background: none;
    border: none;
    color: #9ca3af;
    cursor: pointer;
    padding: 0 16px;
}
.pagination span {
    font-size: 14px;
}
</style>

<script>
var $contentDiv = $('.content');
$(function() {
    $('.user_table').on('click', '.review-row', function(e) {
        e.preventDefault();
        const revNum = $(this).data('revnum');

        if (revNum) {
            $('.content').load('../common/component/mypage/myReviewDetail.jsp?rev_num=' + revNum, function(response, status, xhr) {
                if (status === "error") {
                    console.error("리뷰 상세 페이지 로드 오류:", xhr.status, xhr.statusText);
                    $('.content').html("<p style='color:red;'>리뷰 상세 정보를 불러오는 데 실패했습니다.</p>");
                } else {
                    console.log("✅ 상세 페이지 로드 성공! rev_num=" + revNum);
                }
            });
        }
    });
});
</script>

<div style="position: relative;">
    <h3 class="section-title">나의 리뷰</h3>
    <hr class="line_gray">

    <div class="user_table">
        <table>
            <thead>
                <tr>
                    <th>휴게소명</th>
                    <th>내용</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
			    <c:forEach var="review" items="${reviewList}">
			        <tr class="review-row" data-revnum="${review.rev_num}">
					    <td>${review.area_name}</td>
					    <td>${review.content}</td>
					    <td>${review.input_date}</td>
					</tr>
			    </c:forEach>
			</tbody>
        </table>
    </div>

    <div class="pagination">
        <button disabled>◀</button>
        <span style="text-decoration: underline;">1</span>
        <button disabled>▶</button>
    </div>
</div>
