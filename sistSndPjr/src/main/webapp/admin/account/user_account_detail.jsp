<%@page import="Account.AccountDTO"%>
<%@page import="Account.AdminAccountService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/jsp/login_chk.jsp" %>
<%
String paramNum=request.getParameter("acc_num");

int num=0;
try{
num=Integer.parseInt(paramNum);
}catch (NumberFormatException nfe){
	response.sendRedirect("user_account_manage.jsp");
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
                <h1>회원 계정 수정</h1>
            </div>
            
            <form name="editFrm" id="editFrm" method="post">
            	<div class="content">
            		<input type="hidden" name="num" id="num" value="${ userDTO.acc_num }" />
            		<table class="account-table account-content">
            			<tbody>
            				<tr>
            					<td>이름</td>
            					<td><input type="text" name="name" id="name" value="${ userDTO.name }" /></td>
            				</tr>
            				<tr>
            					<td>이메일</td>
            					<td><input type="text" name="email" id="email" value="${ userDTO.user_email }" readonly="readonly" /></td>
            				</tr>
            				<tr>
            					<td>비밀번호</td>
            					<td><input type="password" name="pass" id="pass" value="${ userDTO.pass }" readonly="readonly" /></td>
            				</tr>
            				<tr>
            					<td>전화번호</td>
            					<td><input type="text" name="tel" id="tel" value="${ userDTO.tel }" /></td>
            				</tr>
            				<tr>
            					<td>가입일</td>
            					<td><input type="text" name="inputDate" id="inputDate" value="${ userDTO.input_date }" readonly="readonly" /></td>
            				</tr>
            			</tbody>
            		</table>
            	</div>
            
            	<div class="button-group">
            		<input type="button" class="btn btn-edit" id="btnUserModify" value="수정" />
            		<input type="button" class="btn btn-remove" id="btnUserRemove" value="삭제" />
					<input type="button" class="btn btn-back" id="btnUserBack" value="뒤로" />
            	</div>
            </form>
        </div>
    </div>
</body>
</html>
