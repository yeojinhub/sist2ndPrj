<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <link rel="stylesheet" href="../common/css/styles.css">
    <script src="script.js"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="admin_sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>관리자 계정 수정</h1>
            </div>
            
            <div class="content">
            	<div>
            		<table class="account-table account-content">
            			<tbody>
            				<tr>
            					<td>이름</td>
            					<td><input type="text" value="김민경" readonly="readonly" /></td>
            				</tr>
            				<tr>
            					<td>아이디</td>
            					<td><input type="text" value="admin01" readonly="readonly" /></td>
            				</tr>
            				<tr>
            					<td>비밀번호</td>
            					<td><input type="password" value="admin1234" /></td>
            				</tr>
            				<tr>
            					<td>전화번호</td>
            					<td><input type="text" value="010-2390-5309" /></td>
            				</tr>
            				<tr>
            					<td>가입일</td>
            					<td><input type="text" value="2025-05-07" readonly="readonly" /></td>
            				</tr>
            			</tbody>
            		</table>
            	</div>
            </div>
            
            <div class="button-group">
            	<button class="btn btn-edit">수정</button>
            	<button class="btn btn-back" onclick="location.href='admin_accounts.jsp'">취소</button>
            </div>

        </div>
    </div>
</body>
</html>
