<%@page import="java.util.List"%>
<%@page import="DTO.AccountDTO"%>
<%@page import="Service.AdminAccountService"%>
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
    <link rel="stylesheet" href="../common/css/styles.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="script.js"></script>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="admin_sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>회원 계정관리</h1>
            </div>
            
            <div class="content">
            <%
           	AdminAccountService accountService = new AdminAccountService();
            List<AccountDTO> userList = accountService.selectAllUser();
            request.setAttribute("userList", userList);
            %>
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
                        <tr onclick="location.href='user_account_detail.jsp'">
                            <td><c:out value="${ i.count }" /></td>
                            <td><c:out value="${ accountDTO.name }" /></td>
                            <td><c:out value="${ accountDTO.user_email }" /></td>
                            <td><c:out value="${ accountDTO.tel }" /></td>
                            <td><fmt:formatDate value="${ accountDTO.input_date }" pattern="yyyy-MM-dd EEEE HH:mm" /></td>
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
                    <button class="btn btn-add" onclick="location.href='user_account_add.jsp'">등록</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
