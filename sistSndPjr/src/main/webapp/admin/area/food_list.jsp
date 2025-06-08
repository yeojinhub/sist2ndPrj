<%@page import="Admin.Area.FoodService.PaginationResult"%>
<%@page import="Pagination.PaginationDTO"%>
<%@page import="Pagination.PaginationUtil"%>
<%@page import="Admin.Area.FoodDTO"%>
<%@page import="java.util.List"%>
<%@page import="Admin.Area.FoodService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//페이지 파라미터를 PaginationUtil로 안전하게 파싱
String pageParam = request.getParameter("page");
int currentPage = PaginationUtil.parsePageParameter(pageParam, 1);

//검색 파라미터 받기
String searchType = request.getParameter("searchType");
String searchKeyword = request.getParameter("searchKeyword");

//검색어를 PaginationUtil로 안전하게 처리
searchKeyword = PaginationUtil.sanitizeSearchKeyword(searchKeyword);

FoodService service = new FoodService();
PaginationResult result;

//검색 조건이 있으면 검색, 없으면 전체 조회
if (searchKeyword != null) {
	result = service.searchAreasWithPagination(searchType, searchKeyword, currentPage);
} else {
	result = service.getAreaListWithPagination(currentPage);
} //end if else

List<FoodDTO> areaList = result.getData();
PaginationDTO pagination = result.getPagination();

request.setAttribute("areaList", areaList);
request.setAttribute("pagination", pagination);
request.setAttribute("searchType", searchType);
request.setAttribute("searchKeyword", searchKeyword);

//페이지 정보 텍스트를 미리 계산해서 request에 저장
String pageInfoText = PaginationUtil.getPageInfoText(pagination);
request.setAttribute("pageInfoText", pageInfoText);
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

</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="/admin/common/jsp/admin_sidebar.jsp" />

		<!-- Main Content -->
		<div class="main-content">
			<div class="header">
				<h1>먹거리 관리</h1>
			</div>

			<!-- 검색 폼 -->
			<div class="search-div">
				<form method="get" action="food_list.jsp">
					<div style="width: 800px; display: flex; align-items: center; padding: 10px 15px; gap: 15px;">
				 		<label style="width: 100px; font-size: 16px; font-weight: bold; white-space: nowrap;">검색 조건</label>
				 		<select name="searchType" class="searchType">
							<option value="route" ${searchType == 'route' ? 'selected' : ''}>노선명</option>
							<option value="name" ${searchType == 'name' ? 'selected' : ''}>휴게소명</option>
						</select>
						<input type="text" name="searchKeyword" class="search-title"
							placeholder="검색어를 입력하세요" value="${searchKeyword}"
							style="margin: 0; flex: 1; height: 30px; padding: 0 10px; border: 1px solid #ccc; border-radius: 4px;" />
						<button type="submit" class="btn-search">검색</button>
					</div>
				</form>
			</div>

			<div class="content">
				<table class="data-table">
					<thead>
						<tr>
							<th>번호</th>
							<th>휴게소명</th>
							<th>노선</th>
							<th>음식개수</th>
							<th>영업시간</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${ empty areaList }">
						<tr>
							<td colspan="10">휴게소 정보가 존재하지 않습니다.</td>
						</tr>
						</c:if>
						<c:forEach var="foodDTO" items="${ areaList }" varStatus="i">
						<tr>
							<td><c:out value="${ pagination.totalCount - ((pagination.currentPage - 1) * pagination.pageSize + i.count) + 1 }" /></td>
							<c:choose>
							<c:when test="${ empty foodDTO.totalFood || foodDTO.totalFood==0 }">
							<td onclick="location.href='food_add_frm.jsp'">
								<c:out value="${ foodDTO.areaName }" />
							</td>
							<td onclick="location.href='food_add_frm.jsp'">
								<c:out value="${ foodDTO.areaRoute }" />
							</td>
							</c:when>
							<c:otherwise>
							<td onclick="location.href='food_detail.jsp?areaNum=${ foodDTO.areaNum }'">
								<c:out value="${ foodDTO.areaName }" />
							</td>
							<td onclick="location.href='food_detail.jsp?areaNum=${ foodDTO.areaNum }'">
								<c:out value="${ foodDTO.areaRoute }" />
							</td>
							</c:otherwise>
							</c:choose>
							<td><c:out value="${ foodDTO.totalFood }" /></td>
							<td><c:out value="${ foodDTO.operationTime }" /></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<!-- 페이지네이션 -->
				<div class="pagination">
					<!-- 첫 페이지로 -->
					<c:if test="${pagination.hasPrevious}">
						<a
							href="?page=1<c:if test='${not empty searchKeyword}'>&searchType=${searchType}&searchKeyword=${searchKeyword}</c:if>"
							class="first-page"> <i class="fas fa-angle-double-left"></i>
						</a>
					</c:if>

					<!-- 이전 페이지 -->
					<c:if test="${pagination.hasPrevious}">
						<a
							href="?page=${pagination.currentPage - 1}<c:if test='${not empty searchKeyword}'>&searchType=${searchType}&searchKeyword=${searchKeyword}</c:if>">
							<i class="fas fa-angle-left"></i>
						</a>
					</c:if>

					<!-- 페이지 번호들 -->
					<c:forEach var="pageNum" begin="${pagination.startPage}"
						end="${pagination.endPage}">
						<c:choose>
							<c:when test="${pageNum == pagination.currentPage}">
								<a href="#" class="active">${pageNum}</a>
							</c:when>
							<c:otherwise>
								<a
									href="?page=${pageNum}<c:if test='${not empty searchKeyword}'>&searchType=${searchType}&searchKeyword=${searchKeyword}</c:if>">${pageNum}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<!-- 다음 페이지 -->
					<c:if test="${pagination.hasNext}">
						<a
							href="?page=${pagination.currentPage + 1}<c:if test='${not empty searchKeyword}'>&searchType=${searchType}&searchKeyword=${searchKeyword}</c:if>">
							<i class="fas fa-angle-right"></i>
						</a>
					</c:if>

					<!-- 마지막 페이지로 -->
					<c:if test="${pagination.hasNext}">
						<a
							href="?page=${pagination.totalPages}<c:if test='${not empty searchKeyword}'>&searchType=${searchType}&searchKeyword=${searchKeyword}</c:if>"
							class="last-page"> <i class="fas fa-angle-double-right"></i>
						</a>
					</c:if>
				</div>
			

				<!-- 페이지 정보 표시 - request attribute 사용 -->
				<div style="text-align: center; margin: 10px 0; color: #666;">
					${pageInfoText}
				</div>

			<div class="button-group">
			</div>
		</div>
	</div>
</body>
</html>
