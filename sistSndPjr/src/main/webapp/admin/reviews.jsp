<%@page import="Review.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="Review.ReviewService.PaginationResult"%>
<%@page import="Review.ReviewService"%>
<%@page import="AdminLogin.LoginResultDTO"%>
<%@page import="Pagination.PaginationUtil"%>
<%@page import="Pagination.PaginationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	// 로그인 체크
	LoginResultDTO userData = (LoginResultDTO) session.getAttribute("userData");
	if (userData == null) {
	    response.sendRedirect("../admin_login.jsp");
	    return;
	}
	
	String pageParam = request.getParameter("page");
	int currentPage = PaginationUtil.parsePageParameter(pageParam, 1);
	
	String hiddenTypeParam = request.getParameter("hiddenType");
	if (hiddenTypeParam == null) {
	    hiddenTypeParam = "all";
	}
	
	ReviewService service = new ReviewService();
	ReviewService.PaginationResult result;
	
	if ("all".equalsIgnoreCase(hiddenTypeParam)) {
	    result = service.getReviewListWithPagination(currentPage);
	} else {
	    result = service.getFilteredReviewList(hiddenTypeParam, currentPage);
	}
	
	List<ReviewDTO> reviewList = result.getData();
	PaginationDTO pagination = result.getPagination();
	
	request.setAttribute("reviewList", reviewList);
	request.setAttribute("pagination", pagination);
	request.setAttribute("pageInfo", PaginationUtil.getPageInfoText(pagination));
	request.setAttribute("hiddenType", hiddenTypeParam);
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
	font-size: 15px;
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
				<h1>리뷰조회/신고관리</h1>
			</div>
						
			    <form method="get" action="reviews.jsp"  class="search-div">
			        <label>
			            <input type="radio" name="hiddenType" value="all" <%= "all".equals(hiddenTypeParam) ? "checked" : "" %> />
			            전체
			        </label>
			        <label>
			            <input type="radio" name="hiddenType" value="Y" <%= "Y".equals(hiddenTypeParam) ? "checked" : "" %> />
			            숨김 (Y)
			        </label>
			        <label>
			            <input type="radio" name="hiddenType" value="N" <%= "N".equals(hiddenTypeParam) ? "checked" : "" %> />
			            보임 (N)
			        </label>
			        <button type="submit" class="btn-search">검색</button>
			    </form>

			
			<div class="content">
			<form action="review_hidden_multiple_update.jsp" method="post">
				<table class="data-table">
					<thead>
						<tr>
							<th><input type="checkbox" id="selectAll" /></th>
							<th>번호</th>
							<th>휴게소명</th>
							<th>리뷰 내용</th>
							<th>작성자</th>
							<th>숨김표시</th>
							<th>누적신고</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="review" items="${reviewList}">
					    <tr onclick="location.href='review_detail.jsp?revNum=${review.rev_num}'">
					        <td><input type="checkbox" name="rev_nums" value="${review.rev_num}" onclick="event.stopPropagation();" /></td>
					        <td><c:out value="${review.rev_num}" /></td>
					        <td><c:out value="${review.area_name}" /></td>
					        <td><c:out value="${review.content}" /></td>
					        <td><c:out value="${review.name}" /></td>
					        <td><c:out value="${review.hidden_type}" /></td>
					        <td><c:out value="${review.report}" /></td>
					    </tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
             <!-- 페이지네이션 -->  
			<div class="pagination">
			    <a href="?page=1&hiddenType=${hiddenType}" class="first-page"><i class="fas fa-angle-double-left"></i></a>
			    <a href="?page=${pagination.currentPage > 1 ? pagination.currentPage - 1 : 1}&hiddenType=${hiddenType}" class="prev-page">
			        <i class="fas fa-angle-left"></i>
			    </a>
			
			    <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
			        <a href="?page=${i}&hiddenType=${hiddenType}" class="${i == pagination.currentPage ? 'active' : ''}">${i}</a>
			    </c:forEach>
			
			    <a href="?page=${pagination.currentPage < pagination.totalPages ? pagination.currentPage + 1 : pagination.totalPages}&hiddenType=${hiddenType}" class="next-page">
			        <i class="fas fa-angle-right"></i>
			    </a>

			    <a href="?page=${pagination.totalPages}&hiddenType=${hiddenType}" class="last-page"><i class="fas fa-angle-double-right"></i></a>
			</div>

			<div class="button-group">
				<button type="submit" class="btn btn-hidden">숨김</button>
			</div>
		</form>
		</div>
	</div>
</body>
    <script>
    document.getElementById('selectAll').addEventListener('change', function() {
        const checked = this.checked;
        document.querySelectorAll('input[name="rev_nums"]').forEach(cb => cb.checked = checked);
    });
	</script>

</html>
