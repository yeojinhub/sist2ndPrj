<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DTO.QuestionDTO" %>
<%@ page import="myPage.QuestionService" %>

<%
    request.setCharacterEncoding("UTF-8");

    int inqNum = Integer.parseInt(request.getParameter("inq_num"));
    QuestionService qs = new QuestionService();
    QuestionDTO qDTO = qs.searchQuestionDetail(inqNum);

    if (qDTO == null) {
%>
    <script>
        alert("해당 문의 정보를 불러오지 못했습니다.");
        window.parent.$('.content').load('../common/component/mypage/myQuestion.jsp');
    </script>
<%
        return;
    }
%>

<script>
    $(function() {
        $('#deleteBtn').on('click', function(e) {
            window.open("../common/component/mypage/popupDeleteMyQuestion.jsp?inq_num=<%= qDTO.getInq_num() %>",
                "popup", "width=600, height=750, left=700, top=100");
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
                <td colspan="3"><%= qDTO.getTitle() %></td>
            </tr>
            <tr>
                <th>작성일</th>
                <td><%= qDTO.getInput_date() %></td>
                <th>답변여부</th>
                <td><%= qDTO.getStatus() %></td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>문의 내용</th>
                <td colspan="4" style="height: 300px; vertical-align: top; padding: 15px; text-align: left;">
                    <%= qDTO.getContent() %>
                </td>
            </tr>
            <tr>
                <th>답변 내용</th>
                <td colspan="4" style="height: 300px; vertical-align: top; padding: 15px; text-align: left;">
                    <%= qDTO.getAnswer_content() == null ? "아직 답변이 등록되지 않았습니다." : qDTO.getAnswer_content() %>
                </td>
            </tr>
        </tbody>
    </table>

    <div class="button-group">
        <button class="btn btn-confirm" onclick="goToList()">목록</button>
        <button class="btn btn-cancel" id="deleteBtn">삭제</button>
    </div>
</div>
