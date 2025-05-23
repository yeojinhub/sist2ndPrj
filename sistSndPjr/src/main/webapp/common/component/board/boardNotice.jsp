<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
var $contentDiv = $('.content');

$(function(){
    $('.user_table tr').on('click', function(e){
        e.preventDefault();
        $contentDiv.load('../common/component/board/boardNoticeDetail.jsp', function(response, status, xhr) {
                if (status === "error") {
                    console.error("boardNoticeDetail.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
                    $contentDiv.html("<p style='color:red;'>오류: '내 정보' 페이지를 불러올 수 없습니다. 경로를 확인해주세요.</p>");
                } else {
                    console.log("boardNoticeDetail.jsp 로드 성공.");
                }
            });
    });
});
</script>

<h3 class="section-title">공지사항</h3>
<hr class="line_gray">
<div class="search-box">
	<select>
		<option>제목</option>
		<option>내용</option>
	</select> <input type="text" />

	<button class="btn btn-confirm">검색</button>
</div>
<div>
	<table class="user_table">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성일</th>

			</tr>
		</thead>
		<tbody>
			<tr>
				<td>1</td>
				<td>모두쉼 홈페이지 론칭 이벤트</td>
				<td>2025-05-05</td>

			</tr>
			<tr>
				<td>1</td>
				<td>모두쉼 홈페이지 론칭 이벤트</td>
				<td>2025-05-05</td>
			</tr>
			<tr>
				<td>1</td>
				<td>모두쉼 홈페이지 론칭 이벤트</td>
				<td>2025-05-05</td>
			</tr>
		</tbody>
	</table>

</div>