<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<% 
String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
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
<script src="/sistSndPjr/admin/common/js/user_account_add.js"></script>

</head>
<body>
	<div class="container">
		<!-- Sidebar -->
		<jsp:include page="/admin/common/jsp/admin_sidebar.jsp" />

		<!-- Main Content -->
		<div class="main-content">
			<div class="header">
				<h1>회원 계정 등록</h1>
			</div>

			<div class="content">
				<form name="addFrm" id="addFrm" action="user_account_add_proccess.jsp" method="post">
				<table class="account-table account-content">
					<tbody>
						<tr>
							<td>이름</td>
							<td><input type="text" name="name" id="name" /></td>
						</tr>
						<tr>
							<td>이메일</td>
							<td><input type="text" name="email" id="email" /></td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td><input type="password" name="pass" id="pass" /></td>
						</tr>
						<tr>
							<td>비밀번호확인</td>
							<td><input type="password" name="passchk" id="passchk" /></td>
						</tr>
						<tr>
							<td>전화번호</td>
							<td><input type="text" name="tel" id="tel" /></td>
						</tr>
						<tr>
							<td>가입일</td>
							<td><input type="text" name="inputDate" id="inputDate"
								value="<%= today %>" readonly="readonly"/></td>
						</tr>
					</tbody>
				</table>
				</form>
			</div>

			<div class="button-group">
				<button class="btn btn-add" id="btnUserAdd">등록</button>
				<button class="btn btn-back" id="btnBack">뒤로</button>
			</div>

		</div>
	</div>
</body>
</html>
