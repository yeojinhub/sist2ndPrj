<%@page import="Util.PaginationUtil"%>
<%@page import="DTO.PaginationDTO"%>
<%@page import="DTO.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@page import="Notice.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="rDTO" class="DTO.RangeDTO" scope="page" />
<jsp:setProperty name="rDTO" property="*" />
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

int totalCount = 0;//총 게시물의 수
totalCount = ns.totalCount( rDTO );
int pageScale = 0;//한화면에 보여줄 게시물의수
pageScale = ns.pageScale();

int totalPage = 0;// 총 페이지수
totalPage= ns.totalPage(totalCount, pageScale);

//String tempPage = request.getParameter("currentPage");
//System.out.println(tempPage);

int startNum = 1; //시작번호
startNum = ns.startNum(pageScale, rDTO);

int endNum = 0; //끝번호
endNum = ns.endNum(pageScale, rDTO);

/* List<NoticeDTO> NoticeList = ns.searchAllNotice(rDTO); */

pageContext.setAttribute("totalPage", totalPage);
pageContext.setAttribute("totalCount", totalCount);
pageContext.setAttribute("pageScale", pageScale);
pageContext.setAttribute("startNum", startNum);
pageContext.setAttribute("endNum", rDTO.getEndNum());
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

<div id="pageinationDiv">

<%
PaginationDTO pDTO = new PaginationDTO(3,rDTO.getCurrentPage(),totalPage,"boardNotice.jsp",null,null,null,null,null,null,null,null);
%>
<%= PaginationUtil.pagination(pDTO) %>
</div>
</div>