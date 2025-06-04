<%@page import="Board.FaqDTO"%>
<%@page import="java.util.List"%>
<%@page import="Board.FaqService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
FaqService faqService = new FaqService();
List<FaqDTO> faqList = faqService.searchAllFaq();
request.setAttribute("faqList", faqList);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 대시보드</title>

<!-- 사용자 정의 css 로드 -->
<link rel="stylesheet" href="/sistSndPjr/admin/common/css/styles.css">

<!-- Font Awesome for icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- jQuery 로드 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 사용자 정의 JS 로드 -->
<script src="/sistSndPjr/admin/script.js"></script>
<script src="/sistSndPjr/admin/common/js/faq_board_manage.js"></script>

</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="/admin/common/jsp/admin_sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="main-content">
			<div class="header">
				<h1>FAQ 관리</h1>
			</div>

			<div class="search-div">
				<textarea class="search-title" rows="" cols=""></textarea>
				<input type="button" class="btn-search" value="검색" />

				<textarea class="search-date" rows="" cols=""></textarea>
				<span class="search-tilde">~</span>
				<textarea class="search-date" rows="" cols=""></textarea>
				<input type="button" class="btn-search" value="검색" />
			</div>

			<div class="content">
                <table class="data-table">
                    <thead>
                        <tr>
                        	<th><input type="checkbox" /></th>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:if test="${ empty faqList }">
                    	<tr>
                    		<td colspan="5">FAQ 게시판 정보가 존재하지 않습니다.</td>
                    	</tr>
                   	</c:if>
                   	<c:forEach var="faqDTO" items="${ faqList }" varStatus="i">
                        <tr>
                        	<td><input type="checkbox" /></td>
                            <td><c:out value="${ i.count }" /></td>
                            <td class="onclickbtn" onclick="location.href='faq_board_detail.jsp?faq_num=${ faqDTO.faq_num }'">
                            	<c:out value="${ faqDTO.title }" />
                            </td>
                            <td class="onclickbtn" onclick="location.href='faq_board_detail.jsp?faq_num=${ faqDTO.faq_num }'">
                            	<c:out value="${ faqDTO.name }" />
                            </td>
                            <td><fmt:formatDate value="${ faqDTO.input_date }" pattern="yyyy-MM-dd" /> </td>
                        </tr>
                   	</c:forEach>
                    </tbody>
                </table>
                
                <div class="pagination">
                    <a href="#" class="first-page"><i class="fas fa-angle-double-left"></i></a>
                    <a href="#" class="active">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">4</a>
                    <a href="#">5</a>
                    <a href="#" class="last-page"><i class="fas fa-angle-double-right"></i></a>
                </div>
                
                <div class="button-group">
                    <button class="btn btn-add" id="btnFaqWriteFrm">작성</button>
                    <button class="btn btn-remove" id="btnFaqRemove">삭제</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
