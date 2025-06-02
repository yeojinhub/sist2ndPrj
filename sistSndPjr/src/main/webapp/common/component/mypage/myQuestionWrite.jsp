<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
    $(function(){
        $('#writeForm').on('submit', function(e){
            e.preventDefault(); // 기본 제출 방지

            // 유효성 검사 (선택 사항)
            const title = $('input[name="title"]').val().trim();
            const content = $('textarea[name="content"]').val().trim();

            if (!title || !content) {
                alert("제목과 내용을 모두 입력해주세요.");
                return;
            }

            // 폼 데이터 전송
            $.post("../common/component/mypage/insertQuestion.jsp", {
                title: title,
                content: content
            }, function(response) {
                alert("문의가 작성되었습니다.");

                // 부모 프레임 메뉴 상태 및 페이지 이동
                var $parent = window.parent;
                $parent.$('#myquestion').addClass('active');
                $parent.$('#myinfo').removeClass('active');
                $parent.$('.content').load('../common/component/mypage/myQuestion.jsp');
            }).fail(function(xhr, status, error) {
                console.error("작성 실패:", error);
                alert("작성 중 문제가 발생했습니다.");
            });
        });

        $('#cancelBtn').on('click', function(e){
            e.preventDefault();
            window.parent.$('#myquestion').addClass('active');
            window.parent.$('#myinfo').removeClass('active');
            window.parent.$('.content').load('../common/component/mypage/myQuestion.jsp');
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

    <form id="writeForm" method="post">
        <table class="user_table">
            <thead>
                <tr>
                    <th style="width: 25%;">제목</th>
                    <td colspan="3">
                        <input type="text" name="title" placeholder="제목을 입력해주세요.">
                    </td>
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
            <button type="submit" class="btn btn-confirm" id="writeBtn">작성</button>
            <button type="button" class="btn btn-cancel" id="cancelBtn">취소</button>
        </div>
    </form>
</div>

