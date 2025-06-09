<%@page import="Inquiry.InquiryService"%>
<%@page import="Inquiry.InquiryService.PaginationResult"%>
<%@page import="Inquiry.InquiryDTO"%>
<%@page import="java.util.List"%>
<%@page import="Pagination.PaginationUtil"%>
<%@page import="AdminLogin.LoginResultDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");

    LoginResultDTO userData = (LoginResultDTO) session.getAttribute("userData");
%>
<%
/* InquiryService service=new InquiryService();
List<InquiryDTO> inquiryList=service.getInquiryList();
request.setAttribute("inquiryList", inquiryList); */
 	String pagePram=request.getParameter("page");
	String searchType=request.getParameter("searchType");
	String searchKeyword=request.getParameter("searchKeyword");
	String statusType=request.getParameter("statusType");
	int pageSize = PaginationUtil.DEFAULT_PAGE_SIZE; 
	//기본값 설정
	int currentPage=PaginationUtil.parsePageParameter(pagePram, 1);
	InquiryService service=new InquiryService();
	PaginationResult result=null;
	
	//검색조건이 잇는지 확인
	boolean hasSearchConditions=(searchKeyword !=null && !searchKeyword.trim().isEmpty())
							|| (statusType != null && !statusType.trim().isEmpty() && !"all".equals(statusType));
	if (hasSearchConditions){
		result=service.searchInquiryWithPagination(searchType, searchKeyword, statusType, currentPage, pageSize);
	}else{
		result=service.getInquiryListWithPagination(currentPage);
	}
	request.setAttribute("inquiryList", result.getData());
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
		
		.search-div label {
		  font-weight: bold;
		  font-size: 14px;
		  margin-right: 30px;
		}
		
		.search-div button {
		  height: 30px;
		  font-size: 16px;
		  border-radius: 4px;
		  border: 1px solid #C4C4C4;
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
		
		.pagination a.active {
		font-weight: bold;
		color: white;
		background-color: #6a9c99;
		padding: 5px 10px;
		border-radius: 5px;
	}  
    </style>
</head>
<body>
	<div class="container">
        <!-- Sidebar -->
        <jsp:include page="admin_sidebar.jsp" />

		<!-- Main Content -->
		<div class="main-content">
			<div class="header">
				<h1>문의 관리</h1>
			</div>
			
			<form method="get" action="inquiries.jsp" class="search-div">
			    <div class="status-radio">
			        <label><input type="radio" name="statusType" value="all" <%= "all".equals(statusType) || statusType == null ? "checked" : "" %>> 전체</label>
			        <label><input type="radio" name="statusType" value="대기" <%= "대기".equals(statusType) ? "checked" : "" %>> 대기</label>
			        <label><input type="radio" name="statusType" value="답변완료" <%= "답변완료".equals(statusType) ? "checked" : "" %>> 답변완료</label>
			    </div>
			    <%-- <input type="text" class="search-title" name="searchKeyword" placeholder="검색어 입력" value="${searchKeyword != null ? searchKeyword : ''}"/> --%>
			    <button type="submit" class="btn-search">검색</button>
			</form>

			<div class="content">
			<form action="inquiry_multiple_delete.jsp" method="post">
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
					<c:forEach var="inquiry" items="${inquiryList}">
						<tr onclick="location.href='inquiry_detail.jsp?inq_num=${inquiry.inq_num}'">
         					<td><input type="checkbox"  name="inq_nums" value="${inquiry.inq_num}" onclick="event.stopPropagation();" /></td>
                            <td><c:out value="${inquiry.inq_num}" /></td>
                            <td><c:out value="${inquiry.title}" /></td>
                            <td><c:out value="${inquiry.name}" /></td>
                            <td><fmt:formatDate value="${inquiry.input_date}" pattern="yyyy-MM-dd" /></td>
                            <td><c:out value="${inquiry.status_type}" /></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
              <!-- 페이지네이션 -->  
			<div class="pagination">
			    <a href="?page=1&searchType=${searchType}&searchKeyword=${searchKeyword}&statusType=${statusType}">
			        <i class="fas fa-angle-double-left"></i>
			    </a>
			
			    <c:choose>
			        <c:when test="${pagination.currentPage > 1}">
			            <a href="?page=${pagination.currentPage - 1}&searchType=${searchType}&searchKeyword=${searchKeyword}&statusType=${statusType}">
			                <i class="fas fa-angle-left"></i>
			            </a>
			        </c:when>
			        <c:otherwise>
			            <a class="disabled">
			                <i class="fas fa-angle-left"></i>
			            </a>
			        </c:otherwise>
			    </c:choose>
			
			    <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
			        <a href="?page=${i}&searchType=${searchType}&searchKeyword=${searchKeyword}&statusType=${statusType}"
			           class="${i == pagination.currentPage ? 'active' : ''}">${i}</a>
			    </c:forEach>
			
			    <c:choose>
			        <c:when test="${pagination.currentPage < pagination.totalPages}">
			            <a href="?page=${pagination.currentPage + 1}&searchType=${searchType}&searchKeyword=${searchKeyword}&statusType=${statusType}">
			                <i class="fas fa-angle-right"></i>
			            </a>
			        </c:when>
			        <c:otherwise>
			            <a class="disabled">
			                <i class="fas fa-angle-right"></i>
			            </a>
			        </c:otherwise>
			    </c:choose>
			
			    <!-- 마지막 페이지로 이동 -->
			    <a href="?page=${pagination.totalPages}&searchType=${searchType}&searchKeyword=${searchKeyword}&statusType=${statusType}">
			        <i class="fas fa-angle-double-right"></i>
			    </a>
			</div>

			<div class="button-group">
				<button  type="submit" class="btn btn-delete">삭제</button>
			</div>
			</form>
		</div>
	</div>
</body>

    <script>
    document.getElementById('selectAll').addEventListener('change', function() {
        const checked = this.checked;
        document.querySelectorAll('input[name="inq_nums"]').forEach(cb => cb.checked = checked);
    });
	</script>


</html>
