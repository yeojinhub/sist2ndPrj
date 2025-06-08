<%@page import="user.mypage.question.QuestionDTO"%>
<%@page import="user.util.PaginationDTO2"%>
<%@page import="user.mypage.question.QuestionService"%>
<%@page import="user.account.login.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    request.setCharacterEncoding("UTF-8");

    LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");
    String email = lDTO == null ? "" : lDTO.getUser_email();

    String type = request.getParameter("type");
    String keyword = request.getParameter("keyword");

    String pageParam = request.getParameter("page");
    int currentpage = 1;
    if (pageParam != null && !pageParam.isEmpty()) {
        try {
            currentpage = Integer.parseInt(pageParam);
        } catch (NumberFormatException e) {
            currentpage = 1;
        }
    }

    int pageSize = 10;

    QuestionService qs = new QuestionService();
    int totalCount = qs.getTotalCount(email, type, keyword);
    PaginationDTO2 paging = new PaginationDTO2(currentpage, pageSize, totalCount); // 내부에서 pageBlock = 5 처리

    List<QuestionDTO> questionList = qs.searchQuestionByEmailWithPaging(email, type, keyword, paging);

    request.setAttribute("questionList", questionList);
    request.setAttribute("paging", paging);
    request.setAttribute("type", type);
    request.setAttribute("keyword", keyword);
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
    cursor: default;
    pointer-events: none;
}

.search-container {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
    width: 100%;
}

.search-box {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    max-width: 700px;
    width: 100%;
    justify-content: center;
}

.search-box select {
    padding: 8px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.search-box .searchText {
    flex: 1;
    min-width: 180px;
    max-width: 400px;
    width: 100%;
    padding: 8px 12px;
    font-size: 14px;
    border-radius: 4px;
    border: 1px solid #ccc;
}

.search-box .btn {
    white-space: nowrap;
    padding: 8px 20px;
    font-size: 14px;
}

@media (max-width: 500px) {
    .search-box {
        flex-direction: column;
        align-items: stretch;
    }
    .search-box .btn {
        width: 100%;
    }
}

.user_table {
    width: 100%;
    overflow-x: auto;
}

.user_table table {
    width: 100%;
    max-width: 100%;
    table-layout: fixed;
    border-collapse: collapse;
    margin: 0 auto;
}

.user_table th, .user_table td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid #ccc;
    word-wrap: break-word;
}

.user_table th:nth-child(1),
.user_table td:nth-child(1) {
    width: 10%;
}
.user_table th:nth-child(2),
.user_table td:nth-child(2) {
    width: 70%;
}
.user_table th:nth-child(3),
.user_table td:nth-child(3) {
    width: 20%;
}

@media (max-width: 768px) {
    .user_table table {
        font-size: 12px;
    }
}

</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function () {
    const $contentDiv = $('.content');

    $('#searchForm').on('submit', function(e) {
        e.preventDefault();
        const type = $('#typeSelect').val();
        const keyword = $('#searchInput').val().trim();
        if (!keyword) {
            alert('검색어를 입력해주세요.');
            return;
        }
        const url = '../common/component/mypage/myQuestion.jsp?type=' + encodeURIComponent(type) + '&keyword=' + encodeURIComponent(keyword);
        $contentDiv.load(url);
    });

    $('tbody').on('click', 'tr.question-row', function(e){
        e.preventDefault();
        const inqNum = $(this).data('inqnum');
        if (inqNum) {
            $contentDiv.load('../common/component/mypage/myQuestionDetail.jsp?inq_num=' + inqNum);
        }
    });

    $('#writeBtn').on('click', function(e){
        e.preventDefault();
        $contentDiv.load('../common/component/mypage/myQuestionWrite.jsp');
    });

    $('.pagination').on('click', 'a', function(e) {
        e.preventDefault();
        const url = $(this).attr('href');
        if (!$(this).hasClass('disabled')) {
            $contentDiv.load(url);
        }
    });
});
</script>

<div style="position: relative;">
    <h3 class="section-title">문의내역</h3>
    <hr class="line_gray">

    <div class="board-content">

        <!-- 검색 영역 -->
        <div class="search-container">
            <div class="search-box">
                <form id="searchForm">
                    <select name="type" id="typeSelect">
                        <option value="제목" <c:if test="${type eq '제목'}">selected</c:if>>제목</option>
                        <option value="내용" <c:if test="${type eq '내용'}">selected</c:if>>내용</option>
                    </select>
                    <input type="text" name="keyword" id="searchInput" class="searchText" placeholder="검색어를 입력해주세요" value="${keyword}" />
                    <button type="submit" class="btn btn-confirm">검색</button>
                </form>
            </div>
        </div>

        <!-- 문의 목록 -->
        <div class="user_table">
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>답변여부</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="question" items="${questionList}" varStatus="loop">
                        <tr class="question-row" data-inqnum="${question.inq_num}">
                            <td>${(paging.totalCount - ((paging.page - 1) * paging.pageSize)) - loop.index}</td>
                            <td>${question.title}</td>
                            <td>${question.status}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

       	<div class="pagination">
		    <!-- ◀ 왼쪽 화살표: 현재 페이지 - 1 -->
			<c:choose>
			    <c:when test="${paging.page > 1}">
			        <a href="../common/component/mypage/myQuestion.jsp?page=${paging.page - 1}&type=${type}&keyword=${keyword}">◀</a>
			    </c:when>
			    <c:otherwise>
			        <a class="disabled">◀</a>
			    </c:otherwise>
			</c:choose>
			
			<!-- 번호 출력은 블럭단위 유지 -->
			<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
			    <c:choose>
			        <c:when test="${i == paging.page}">
			            <span>${i}</span>
			        </c:when>
			        <c:otherwise>
			            <a href="../common/component/mypage/myQuestion.jsp?page=${i}&type=${type}&keyword=${keyword}">${i}</a>
			        </c:otherwise>
			    </c:choose>
			</c:forEach>
			
			<!-- ▶ 오른쪽 화살표: 현재 페이지 + 1 -->
			<c:choose>
			    <c:when test="${paging.page < paging.totalPage}">
			        <a href="../common/component/mypage/myQuestion.jsp?page=${paging.page + 1}&type=${type}&keyword=${keyword}">▶</a>
			    </c:when>
			    <c:otherwise>
			        <a class="disabled">▶</a>
			    </c:otherwise>
			</c:choose>
</div>
</div>







