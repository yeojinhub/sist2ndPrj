<%@page import="Pagination.PaginationUtil"%>
<%@page import="Pagination.PaginationDTO"%>
<%@page import="AdminLogin.LoginResultDTO"%>
<%@page import="Notice.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@page import="Notice.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
NoticeService service = new NoticeService();
List<NoticeDTO> noticeList = service.getNoticeList();
request.setAttribute("noticeList", noticeList);
%>
<%
    LoginResultDTO userData = (LoginResultDTO) session.getAttribute("userData");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <link rel="stylesheet" href="../common/css/styles.css">
    <script src="script.js"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="container-">
        <!-- Sidebar -->
        <jsp:include page="admin_sidebar.jsp" />

        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>공지사항 관리</h1>
            </div>

            <div class="search-div">
                <textarea class="search-title" rows="" cols=""></textarea>
                <input type="button" class="btn-search" value="검색"/>

                <textarea class="search-date" rows="" cols=""></textarea>
                <span class="search-tilde">~</span>
                <textarea class="search-date" rows="" cols=""></textarea>
                <input type="button" class="btn-search" value="검색"/>
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
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="notice" items="${noticeList}">
                            <tr onclick="location.href='notice_board_detail.jsp?not_num=${notice.not_num}'">
                                <td><input type="checkbox" /></td>
                                <td><c:out value="${notice.not_num}" /></td>
                                <td><c:out value="${notice.title}" /></td>
                                <td><c:out value="${notice.name}" /></td>
                                <td><fmt:formatDate value="${notice.input_date}" pattern="yyyy-MM-dd" /></td>
                                <td><c:out value="${notice.status_type}" /></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- 페이지네이션 -->
            <div class="pagination">
                <!-- 첫 페이지로 이동 -->
                <a href="?page=1&searchType=${searchType}&searchKeyword=${searchKeyword}&statusType=${statusType}" class="first-page"><i class="fas fa-angle-double-left"></i></a>

                <!-- 페이지 번호 표시 -->
                <c:forEach var="i" begin="1" end="${pagination.totalPages}">
                    <a href="?page=${i}&searchType=${searchType}&searchKeyword=${searchKeyword}&statusType=${statusType}" class="<c:if test='${i == pagination.currentPage}'>active</c:if>">${i}</a>
                </c:forEach>

                <!-- 마지막 페이지로 이동 -->
                <a href="?page=${pagination.totalPages}&searchType=${searchType}&searchKeyword=${searchKeyword}&statusType=${statusType}" class="last-page"><i class="fas fa-angle-double-right"></i></a>
            </div>

            <div class="button-group">
                <button class="btn btn-add" onclick="location.href='notice_board_write.jsp'">작성</button>
                <button class="btn btn-delete">삭제</button>
            </div>
        </div>
    </div>
</body>
</html>
