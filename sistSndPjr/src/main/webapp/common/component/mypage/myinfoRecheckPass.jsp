<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
$(function(){
	// --- MyInfo 로딩 스크립트 시작 ---
        var $contentDiv = $('.content');

        // 비밀번호 확인 섹션의 '확인' 버튼 클릭 이벤트
        $('#confirm').on('click', function(e) {
            // 이 버튼이 비밀번호 확인 섹션 내의 버튼인지 확인 (myinfo.jsp 내의 버튼과 구분)
            if ($(this).closest('div.button-group').prevAll('input.pass').length > 0) {
                e.preventDefault(); // 기본 동작 방지

                // 지금은 비밀번호 확인이 성공했다고 가정합니다.
                console.log("비밀번호 확인 성공 (시뮬레이션)");

                // myinfo.jsp 내용을 .content div에 로드합니다.
                // 경로가 웹 애플리케이션 루트를 기준으로 정확한지 확인하세요.
                $contentDiv.load('../common/component/mypage/myinfo.jsp', function(response, status, xhr) {
                    if (status === "error") {
                        console.error("myinfo.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
                        $contentDiv.html("<p style='color:red;'>오류: '내 정보' 페이지를 불러올 수 없습니다. 경로를 확인해주세요.</p>");
                    } else {
                        console.log("myinfo.jsp 로드 성공.");
                    }
                });
            }
        });
        // --- MyInfo 로딩 스크립트 끝 ---
});

</script>

<h3 class="section-title">내 정보 - 본인 확인</h3>
	<hr class="line_gray">
	<p class="text">비밀번호를 다시 한 번 입력해 주세요.</p>
	<input type="password" name="password" class="pass"/><br>
	<div class="button-group">
	<button type="button" class="btn btn-confirm" id="confirm">확인</button>
	<button type="button" class=" btn btn-cancel" onclick="history.back()">취소</button>
	</div>