<%@page import="Notice.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
var $contentDiv = $('.content');

$(function(){
    $('.user_table tr').on('click', function(e){
        e.preventDefault();
        const num = $(this).data('num');
        $contentDiv.load('../common/component/board/boardNoticeDetail.jsp?num='+num, function(response, status, xhr) {
                if (status === "error") {
                    console.error("boardNoticeDetail.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
                    $contentDiv.html("<p style='color:red;'>오류: '내 정보' 페이지를 불러올 수 없습니다. 경로를 확인해주세요.</p>");
                } else {
                    console.log("boardNoticeDetail.jsp 로드 성공."+num);
                }
            });
    });
});
</script>
<%
NoticeService ns = new NoticeService();
pageContext.setAttribute("noticeList", ns.searchAllNotice());
%>
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
			<c:if test="${ empty noticeList }">
				<tr>
					<td colspan="3">공지사항이 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="nDTO" items="${ noticeList }" varStatus="i">
			<tr data-num="${nDTO.not_num}">
				<td><c:out value="${ nDTO.not_num }"/> </td>
				<td><c:out value="${ nDTO.title }"/> </td>
				<td><fmt:formatDate value="${ nDTO.input_date }" pattern="yyyy-MM-dd EEEE HH:mm"/> </td>
			</tr>
			</c:forEach>
		</tbody>
	</table>

</div>