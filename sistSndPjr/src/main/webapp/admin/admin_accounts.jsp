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
                <h1>관리자 계정 관리</h1>
            </div>
            
            <div class="content">
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
                        <tr onclick="location.href='admin_account_detail.jsp'">
                            <td>3</td>
                            <td>김민경</td>
                            <td>admin01</td>
                            <td>010-1234-5678</td>
                            <td>2025-05-22</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>유명규</td>
                            <td>admin02</td>
                            <td>010-1114-6321</td>
                            <td>2025-05-19</td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>이대웅</td>
                            <td>admin03</td>
                            <td>010-8123-8700</td>
                            <td>2025-05-05</td>
                        </tr>
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
