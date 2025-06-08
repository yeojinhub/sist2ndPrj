<%@page import="user.mypage.review.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="user.util.PaginationDTO2"%>
<%@page import="user.mypage.review.ReviewService"%>
<%@page import="user.account.login.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    request.setCharacterEncoding("UTF-8");

    LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");
    String email = lDTO.getUser_email();

    String pageParam = request.getParameter("page");
    int currentPage = 1;
    if (pageParam != null && !pageParam.isEmpty()) {
        try {
            currentPage = Integer.parseInt(pageParam);
        } catch (NumberFormatException e) {
            currentPage = 1;
        }
    }

    int pageSize = 10;

    ReviewService rs = new ReviewService();
    int totalCount = rs.getTotalCnt(email);
    PaginationDTO2 paging = new PaginationDTO2(currentPage, pageSize, totalCount);
    List<ReviewDTO> reviewList = rs.searchReviewsByEmailWithPaging(email, paging);

    request.setAttribute("reviewList", reviewList);
    request.setAttribute("paging", paging);
%>

<style>
.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 16px;
    font-family: sans-serif;
}
.pagination a, .pagination span {
    margin: 0 6px;
    font-size: 18px;
    text-decoration: none;
    color: black;
    cursor: pointer;
}
.pagination span {
    font-weight: bold;
    text-decoration: underline;
}
.pagination a.disabled {
    color: #ccc;
    pointer-events: none;
    cursor: default;
}

.user_table {
    width: 100%;
    overflow-x: auto;
}
.user_table table {
    width: 100%;
    border-collapse: collapse;
}
.user_table th, .user_table td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid #ccc;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function() {
    $('.user_table').on('click', '.review-row', function(e) {
        e.preventDefault();
        const revNum = $(this).data('revnum');

        if (revNum) {
            $('.content').load('../common/component/mypage/myReviewDetail.jsp?rev_num=' + revNum, function(response, status, xhr) {
                if (status === "error") {
                    console.error("리뷰 상세 페이지 로드 오류:", xhr.status, xhr.statusText);
                    $('.content').html("<p style='color:red;'>리뷰 상세 정보를 불러오는 데 실패했습니다.</p>");
                }
            });
        }
    });

    $('.pagination').on('click', 'a', function(e) {
        e.preventDefault();
        const url = $(this).attr('href');
        $('.content').load(url);
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
        <c:choose>
            <c:when test="${paging.page > 1}">
                <a href="../common/component/mypage/myReview.jsp?page=${paging.page - 1}">◀</a>
            </c:when>
            <c:otherwise>
                <a class="disabled">◀</a>
            </c:otherwise>
        </c:choose>

        <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
            <c:choose>
                <c:when test="${i == paging.page}">
                    <span>${i}</span>
                </c:when>
                <c:otherwise>
                    <a href="../common/component/mypage/myReview.jsp?page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:choose>
            <c:when test="${paging.page < paging.totalPage}">
                <a href="../common/component/mypage/myReview.jsp?page=${paging.page + 1}">▶</a>
            </c:when>
            <c:otherwise>
                <a class="disabled">▶</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
