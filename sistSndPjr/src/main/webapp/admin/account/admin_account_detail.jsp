<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <link rel="stylesheet" href="/sistSndPjr/admin/common/css/styles.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <script src="/sistSndPjr/admin/script.js">
    </script>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="/admin/common/jsp/admin_sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>관리자 계정 수정</h1>
            </div>
            
            <div class="content">
            	<form name="modifyFrm" id="modifyFrm" action="user_account_modify_proccess.jsp" method="post">
            		<table class="account-table account-content">
            			<tbody>
            				<tr>
            					<td>이름</td>
            					<td><input type="text" value="${ userDTO.name }" readonly="readonly" /></td>
            				</tr>
            				<tr>
            					<td>아이디</td>
            					<td><input type="text" value="${ userDTO.adm_id }" readonly="readonly" /></td>
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
            	</form>
            </div>
            
            <div class="button-group">
            	<button class="btn btn-edit">수정</button>
            	<button class="btn btn-back" onclick="location.href='admin_account_list.jsp'">뒤로</button>
            </div>

        </div>
    </div>
</body>
</html>
