<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <link rel="stylesheet" href="../user/common/css/styles.css">
    <script src="script.js"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="logo-container">
                <img src="../user/common/images/logo.png" alt="로고" class="logo">
                <span class="logo-text">모두쉼</span>
            </div>
            
            <div class="admin-info">
                <span class="admin-label">관리자</span>
                <span class="admin-name">김민경님</span>
                <button class="logout-btn">로그아웃</button>
            </div>
            
            <ul class="menu">
                <li class="menu-item">
                    <a href="home.jsp"><i class="fas fa-home"></i> Home</a>
                </li>
                
                <li class="menu-item has-submenu">
                    <a href="#" class="toggle-submenu"><i class="fas fa-users"></i> 계정관리 <i class="fas fa-chevron-down arrow"></i></a>
                    <ul class="submenu">
                        <li><a href="user_accounts.jsp">회원 계정관리</a></li>
                        <li><a href="admin_accounts.jsp">관리자 계정관리</a></li>
                    </ul>
                </li>
                
                <li class="menu-item has-submenu">
                    <a href="#" class="toggle-submenu"><i class="fas fa-clipboard-list"></i> 게시판 관리 <i class="fas fa-chevron-down arrow"></i></a>
                    <ul class="submenu">
                        <li><a href="notice_board.jsp">공지사항 관리</a></li>
                        <li><a href="faq-board.jsp">FaQ 관리</a></li>
                        <li><a href="qna-board.jsp">QaA 관리</a></li>
                    </ul>
                </li>
                
                <li class="menu-item">
                    <a href="inquiries.jsp"><i class="fas fa-question-circle"></i> 문의관리</a>
                </li>
                
                <li class="menu-item">
                    <a href="reviews.jsp"><i class="fas fa-star"></i> 리뷰 조회/신고관리</a>
                </li>
                
                <li class="menu-item">
                    <a href="rest-areas.jsp"><i class="fas fa-map-marker-alt"></i> 휴게소 관리</a>
                </li>
            </ul>
        </div>
        
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
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
                
                <div class="pagination">
                    <a href="#" class="first-page"><i class="fas fa-angle-double-left"></i></a>
                    <a href="#" class="active">1</a>
                    <a href="#" class="last-page"><i class="fas fa-angle-double-right"></i></a>
                </div>
                
                <div class="button-group">
                    <button class="btn btn-primary">등록</button>
                    <button class="btn btn-secondary">수정</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
