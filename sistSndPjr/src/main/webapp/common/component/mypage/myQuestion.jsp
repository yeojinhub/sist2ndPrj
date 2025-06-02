<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="myPage.QuestionService" %>
<%@ page import="DTO.QuestionDTO" %>
<%@ page import="DTO.LoginDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    request.setCharacterEncoding("UTF-8");

    LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");
    String email = lDTO.getUser_email();

    QuestionService qs = new QuestionService();
    List<QuestionDTO> questionList = qs.searchQuestionByEmail(email);
    request.setAttribute("questionList", questionList);
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
</style>

<script>
    var $contentDiv = $('.content');

    $(function() {
        // 상세페이지 로드
        $('tbody').on('click', 'tr.question-row', function(e){
            e.preventDefault();
            const inqNum = $(this).data('inqnum');
            if (inqNum) {
                $contentDiv.load('../common/component/mypage/myQuestionDetail.jsp?inq_num=' + inqNum, function(response, status, xhr){
                    if(status === 'error'){
                        console.error("myQuestionDetail.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
                        $contentDiv.html("<p style='color:red;'>문의 상세 정보를 불러올 수 없습니다.</p>");
                    }
                });
            }
        });

        // 문의 작성 페이지 로드
        $('#writeBtn').on('click', function(e){
            e.preventDefault();
            $contentDiv.load('../common/component/mypage/myQuestionWrite.jsp', function(response, status, xhr){
                if(status === 'error'){
                    console.error("myQuestionWrite.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
                    $contentDiv.html("<p style='color:red;'>문의 작성 페이지를 불러올 수 없습니다.</p>");
                }
            });
        });
    });
</script>

<div style="position: relative;">
    <h3 class="section-title">문의내역</h3>
    <hr class="line_gray">

    <div class="board-content">

        <!-- 검색 영역 -->
        <div class="search-container">
            <div class="search-box" >
                <select>
                    <option>제목</option>
                    <option>내용</option>
                </select>
                <input type="text" class="searchText"placeholder="검색어를 입력해주세요"/>
                <button class="btn btn-confirm">검색</button>
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
                            <td>${loop.index + 1}</td>
                            <td>${question.title}</td>
                            <td>${question.status}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
            <button disabled>◀</button>
            <span style="text-decoration: underline;">1</span>
            <button disabled>▶</button>
        </div>

        <!-- 작성 버튼 -->
        <div class="button-group" style="text-align: center;">
            <button class="btn btn-confirm" id="writeBtn">작성</button>
        </div>
    </div>
</div>
