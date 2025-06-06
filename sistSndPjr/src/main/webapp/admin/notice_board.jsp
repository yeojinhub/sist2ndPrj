<%@page import="Notice.NoticeService.PaginationResult"%>
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
    LoginResultDTO userData = (LoginResultDTO) session.getAttribute("userData");
%>
<%
/* NoticeService service=new NoticeService();
List<NoticeDTO> noticeList=service.getNoticeList();
request.setAttribute("noticeList", noticeList); */
	String pagePram=request.getParameter("page");
	String searchType=request.getParameter("searchType");
	String searchKeyword=request.getParameter("searchKeyword");
	String statusType=request.getParameter("statusType");
	
	//기본값 설정
	int currentPage=PaginationUtil.parsePageParameter(pagePram, 1);
	NoticeService service=new NoticeService();
	PaginationResult result=null;
	
	//검색조건이 잇는지 확인
	boolean hasSearchConditions=(searchKeyword !=null && !searchKeyword.trim().isEmpty())
							|| (statusType != null && !statusType.trim().isEmpty() && !"all".equals(statusType));
	if (hasSearchConditions){
		result=service.searchNoticeWithPagination(searchType, searchKeyword, statusType, currentPage);
	}else{
		result=service.getNoticeListWithPagination(currentPage);
	}
	request.setAttribute("noticeList", result.getData());
	request.setAttribute("pagination", result.getPagination());
	request.setAttribute("searchType", searchType);
	request.setAttribute("searchKeyword", searchKeyword);
	request.setAttribute("statusType", statusType);
	request.setAttribute("pageInfo", PaginationUtil.getPageInfoText(result.getPagination()));

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
		
		.status-radio {
		  display: flex;
		  gap: 15px;
		  align-items: center;
		}
		
		.status-radio label {
		  font-weight: bold;
		}
		
		.status-radio input[type="radio"] {
		  margin-right: 5px;
		  transform: scale(1.1);
		}  
    </style>
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

			<form method="get" action="notice_board.jsp" class="search-div">
			    <select name="searchType">
			        <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
			        <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
			        <option value="author" ${searchType == 'author' ? 'author' : ''}>작성자</option>
			    </select>
			
			    <input type="text" class="search-title" name="searchKeyword" placeholder="검색어 입력" value="${searchKeyword != null ? searchKeyword : ''}"/>
			
			    <div class="status-radio">
			        <label><input type="radio" name="statusType" value="all" <%= "all".equals(statusType) || statusType == null ? "checked" : "" %>> 전체</label>
			        <label><input type="radio" name="statusType" value="공지" <%= "공지".equals(statusType) ? "checked" : "" %>> 공지</label>
			        <label><input type="radio" name="statusType" value="미공지" <%= "미공지".equals(statusType) ? "checked" : "" %>> 미공지</label>
			    </div>
			
			    <button type="submit" class="btn-search">검색</button>
			</form>

            <div class="content">
            <form action="notice_multiple_delete.jsp" method="post">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="selectAll"/></th>
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
                                <td><input type="checkbox" name="not_nums" value="${notice.not_num}" onclick="event.stopPropagation();"/></td>
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
                <button type="button" class="btn btn-add" onclick="location.href='notice_board_write.jsp'">작성</button>
                <button type="submit" class="btn btn-delete">삭제</button>
            </div>
          </form>  
        </div>
    </div>
</body>

    <script>
    document.getElementById('selectAll').addEventListener('change', function() {
        const checked = this.checked;
        document.querySelectorAll('input[name="not_nums"]').forEach(cb => cb.checked = checked);
    });
	</script>

</html>
