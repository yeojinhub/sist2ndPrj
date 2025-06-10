<%@page import="kr.co.sist.cipher.DataDecryption"%>
<%@page import="Pagination.PaginationDTO"%>
<%@page import="Account.AdminAccountService.PaginationResult"%>
<%@page import="Pagination.PaginationUtil"%>
<%@page import="Account.AdminAccountService"%>
<%@page import="Account.AccountDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/jsp/login_chk.jsp" %>
<%
// 페이지 파라미터를 PaginationUtil로 안전하게 파싱
String pageParam = request.getParameter("page");
int currentPage = PaginationUtil.parsePageParameter(pageParam, 1);

// 검색 파라미터 받기
String searchType = request.getParameter("searchType");
String searchKeyword = request.getParameter("searchKeyword");

// 검색어를 PaginationUtil로 안전하게 처리
searchKeyword = PaginationUtil.sanitizeSearchKeyword(searchKeyword);

AdminAccountService accountService = new AdminAccountService();
PaginationResult result;

// 검색 조건이 있으면 검색, 없으면 전체 조회
if (searchKeyword != null) {
	result = accountService.searchUsersWithPagination(searchType, searchKeyword, currentPage);
} else {
	result = accountService.getUserListWithPagination(currentPage);
}

List<AccountDTO> userList = result.getData();
PaginationDTO pagination = result.getPagination();

//복호화
DataDecryption dd = new DataDecryption("asdf1234asdf1234");
for (AccountDTO item : userList) {
	try {
		item.setName(dd.decrypt(item.getName()));
		item.setUser_email(dd.decrypt(item.getUser_email()));
		item.setTel(dd.decrypt(item.getTel()));
	} catch (Exception e) {
		System.err.println("복호화 실패 사유 : " + e.getMessage() + " / 원본 : " + item.getName() + " / " + item.getUser_email() + " / " + item.getTel());
	}// end try-catch
}// end for

request.setAttribute("userList", userList);
request.setAttribute("pagination", pagination);
request.setAttribute("searchType", searchType);
request.setAttribute("searchKeyword", searchKeyword);

// 페이지 정보 텍스트를 미리 계산해서 request에 저장
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
<script src="/sistSndPjr/admin/common/js/user_account_manage.js"></script>

</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="/admin/common/jsp/admin_sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>회원 계정관리</h1>
            </div>
            
            <div class="content">
            	<!-- 검색 폼 -->
				<div class="search-div">
					<form style="display: flex; width: 100%;" method="get"
						action="user_account_list.jsp">
						<div
							style="width: 800px; display: flex; align-items: center; padding: 10px 15px; gap: 15px;">
							<label
								style="width: 100px; font-size: 16px; font-weight: bold; white-space: nowrap;">
								검색 조건 </label> 
							<select name="searchType" class="searchType">
								<option value="name" ${searchType == 'name' ? 'selected' : ''}>이름</option>
								<option value="email" ${searchType == 'email' ? 'selected' : ''}>이메일</option>
								<option value="tel" ${searchType == 'tel' ? 'selected' : ''}>전화번호</option>
							</select> 
							<input type="text" name="searchKeyword" class="search-title"
								placeholder="검색어를 입력하세요" value="${searchKeyword}"
								style="margin: 0; flex: 1; height: 30px; padding: 0 10px; border: 1px solid #ccc; border-radius: 4px;" />
							<button type="submit" class="btn-search">검색</button>
						</div>
					</form>
				</div>
            
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>전화번호</th>
                            <th>가입일</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:if test="${ empty userList }">
                    	<tr>
                    		<td colspan="5">사용자 회원 정보가 존재하지 않습니다.</td>
                    	</tr>
                    </c:if>
                    <c:forEach var="accountDTO" items="${ userList }" varStatus="i">
                        <tr>
                            <td><c:out value="${ pagination.totalCount - ((pagination.currentPage - 1) * pagination.pageSize + i.count) + 1 }" /></td>
                            <td class="onclickbtn" onclick="location.href='user_account_detail.jsp?acc_num=${ accountDTO.acc_num }'">
                            	<c:out value="${ accountDTO.name }" />
                            </td>
                            <td class="onclickbtn" onclick="location.href='user_account_detail.jsp?acc_num=${ accountDTO.acc_num }'">
                            	<c:out value="${ accountDTO.user_email }" />
                            </td>
                            <td ><c:out value="${ accountDTO.tel }" /></td>
                            <td><fmt:formatDate value="${ accountDTO.input_date }" pattern="yyyy-MM-dd" /></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                
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
					<button class="btn btn-add" id="btnUserAddFrm">등록</button>
				</div>
            </div>
        </div>
    </div>
</body>
</html>
