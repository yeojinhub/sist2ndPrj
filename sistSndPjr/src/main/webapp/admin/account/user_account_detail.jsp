<%@page import="Account.AccountDTO"%>
<%@page import="Account.AdminAccountService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String paramNum=request.getParameter("acc_num");

int num=0;
try{
num=Integer.parseInt(paramNum);
}catch (NumberFormatException nfe){
	response.sendRedirect("user_accounts.jsp");
}//end catch

AdminAccountService userService = new AdminAccountService();
request.setAttribute("userDTO", userService.searchOneUser(num));
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    
    <!-- 사용자 정의 css 로드 -->
    <link rel="stylesheet" href="/sistSndPjr/admin/common/css/styles.css">
    
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- jQuery 로드 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- 사용자 정의 JS 로드 -->
    <script src="/sistSndPjr/admin/common/js/user_account_add.js"></script>
    
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="/admin/common/jsp/admin_sidebar.jsp" />
           
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>회원 계정 수정</h1>
            </div>
            
            <div class="content">
            	<div>
            		<table class="account-table account-content">
            			<tbody>
            				<tr>
            					<td>이름</td>
            					<td><input type="text" value="${ userDTO.name }" readonly="readonly" /></td>
            				</tr>
            				<tr>
            					<td>이메일</td>
            					<td><input type="text" value="${ userDTO.user_email }" /></td>
            				</tr>
            				<tr>
            					<td>비밀번호</td>
            					<td><input type="password" value="${ userDTO.pass }" /></td>
            				</tr>
            				<tr>
            					<td>전화번호</td>
            					<td><input type="text" value="${ userDTO.tel }" /></td>
            				</tr>
            				<tr>
            					<td>가입일</td>
            					<td><input type="text" value="${ userDTO.input_date }" readonly="readonly" /></td>
            				</tr>
            			</tbody>
            		</table>
            	</div>
            </div>
            
            <div class="button-group">
            	<button class="btn btn-edit" id="btnUserEdit">수정</button>
            	<button class="btn btn-delete" id="btnUserDelete">삭제</button>
            	<button class="btn btn-back" id="btnBack">뒤로</button>
            </div>

        </div>
    </div>
</body>
</html>
