<%@page import="Faq.FaqService.PaginationResult"%>
<%@page import="Pagination.PaginationUtil"%>
<%@page import="AdminLogin.LoginResultDTO"%>
<%@page import="AdminLogin.LoginResultDTO"%>
<%@page import="Faq.FaqDTO"%>
<%@page import="java.util.List"%>
<%@page import="Faq.FaqService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../common/jsp/login_chk.jsp" %>
<%
    LoginResultDTO userData = (LoginResultDTO) session.getAttribute("userData");
%>
<%
/* NoticeService service=new NoticeService();
List<NoticeDTO> noticeList=service.getNoticeList();
request.setAttribute("noticeList", noticeList); */
	String pagePram=request.getParameter("page");
	String searchType=request.getParameter("searchType");
	String searchKeyword=request.getParameter("searchKeyword");

	
	//기본값 설정
	int currentPage=PaginationUtil.parsePageParameter(pagePram, 1);
	FaqService service=new FaqService();
	PaginationResult result=null;
	
	//검색조건이 잇는지 확인
	boolean hasSearchConditions=(searchKeyword !=null && !searchKeyword.trim().isEmpty());
	if (hasSearchConditions){
		result=service.searchFaqWithPagination(searchType, searchKeyword, currentPage);
	}else{
		result=service.getFaqListWithPagination(currentPage);
	}
	request.setAttribute("faqList", result.getData());
	request.setAttribute("pagination", result.getPagination());
	request.setAttribute("searchType", searchType);
	request.setAttribute("searchKeyword", searchKeyword);
	request.setAttribute("pageInfo", PaginationUtil.getPageInfoText(result.getPagination()));

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <link rel="stylesheet" href="../../common/css/styles.css">
 	<script src="/sistSndPjr/admin/script.js"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
		/* 검색 영역 */
		.search-div {
		  width: 60%;
		  display: flex;
		  align-items: center;
		  justify-content: center;
		  margin: 50px auto 30px auto; /* 아래 테이블과 간격 포함 */
		  gap: 10px;
		}
		
		.search-div select,
		.search-div input[type="text"],
		.search-div button {
		  height: 30px;
		  font-size: 16px;
		  border-radius: 4px;
		  border: 1px solid #C4C4C4;
		}
		
		.search-div select {
		  width: 100px;
		  font-weight: bold;
		  color: #000;
		}
		
		.search-div input[type="text"].search-title {
		  width: 50%;
		  padding: 0 8px;
		  text-align: center;
		}
		
		.btn-search {
		  padding: 0 15px;
		  width: 80px;
		  font-size: 10px;
		  font-weight: bold;
		  background-color: #D9D9D9;
		  border: none;
		  cursor: pointer;
		  color:#ffffff;
		  background-color: #96b1ad;
		}   
    </style>
    
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

			<form method="get" action="faq_board.jsp" class="search-div">
			    <select name="searchType">
			        <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
			        <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
			        <option value="author" ${searchType == 'author' ? 'selected' : ''}>작성자</option>
			    </select>
			
			    <input type="text" class="search-title" name="searchKeyword" placeholder="검색어 입력" value="${searchKeyword != null ? searchKeyword : ''}"/>
			
			    <button type="submit" class="btn-search">검색</button>
			</form>

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
                        <c:forEach var="faq" items="${faqList}">
                            <tr>
                                <td><input type="checkbox" /></td>
                                <td><c:out value="${faq.faq_num}" /></td>
                                <td class="onclickbtn" onclick="location.href='faq_board_detail.jsp?faq_num=${faq.faq_num}'"><c:out value="${faq.title}" /></td>
                                <td><c:out value="${faq.name}" /></td>
                                <td><fmt:formatDate value="${faq.input_date}" pattern="yyyy-MM-dd" /></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
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
                    <button class="btn btn-add" onclick="location.href='faq_board_write.jsp'">작성</button>
                    <button class="btn btn-delete">삭제</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
