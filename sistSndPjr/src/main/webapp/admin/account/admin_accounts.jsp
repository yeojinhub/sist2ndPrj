<%@page import="Account.AccountDTO"%>
<%@page import="Account.AdminAccountService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <link rel="stylesheet" href="/sistSndPjr/admin/common/css/styles.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="/sistSndPjr/admin/script.js"></script>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="/admin/common/jsp/admin_sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>관리자 계정 관리</h1>
            </div>
            
            <div class="content">
            	<%
            	AdminAccountService accountService = new AdminAccountService();
            	List<AccountDTO> adminList = accountService.selectAllAdmin();
            	request.setAttribute("adminList", adminList);
            	%>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>이름</th>
                            <th>아이디</th>
                            <th>전화번호</th>
                            <th>가입일</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:if test="${ empty adminList }">
                    	<tr>
                    		<td colspan="5">관리자 계정 정보가 없습니다.</td>
                    	</tr>
                    </c:if>
                    <c:forEach var="accountDTO" items="${ adminList }" varStatus="i">
                        <tr onclick="location.href='admin_account_detail.jsp'">
                            <td><c:out value="${ i.count }" /></td>
                            <td><c:out value="${ accountDTO.name }" /></td>
                            <td><c:out value="${ accountDTO.adm_id }" /></td>
                            <td><c:out value="${ accountDTO.tel }" /></td>
                            <td><fmt:formatDate value="${ accountDTO.input_date }" pattern="yyyy-MM-dd" /></td>
                        </tr>
                     </c:forEach>
                    </tbody>
                </table>
                
                <div class="pagination">
                    <a href="#" class="first-page"><i class="fas fa-angle-double-left"></i></a>
                    <a href="#" class="active">1</a>
                    <a href="#" class="last-page"><i class="fas fa-angle-double-right"></i></a>
                </div>
                
                <div class="button-group">
                </div>
            </div>
        </div>
    </div>
</body>
</html>
