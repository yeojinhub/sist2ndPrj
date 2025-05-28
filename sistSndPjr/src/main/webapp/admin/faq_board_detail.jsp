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
        <div class="sidebar">
            <div class="logo-container">
                <img src="../common/images/logo.png" alt="로고" class="logo">
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
                <h1>FAQ 수정</h1>
            </div>
            <div class="content">
            	<div class="notice-content">
            		<table class="notice-table">
            			<tbody>
            				<tr>
            					<td>작성자</td>
            					<td><input type="text" value="admin03" /></td>
            					<td>작성일</td>
            					<td><input type="text" value="2025-05-08" /></td>
            				</tr>
            				<tr>
            					<td>제목</td>
            					<td colspan="3"><input type="text" value="전기/수소차 충전소 정보 제공 안내" /></td>
            				</tr>
            				<tr>
            					<td>내용</td>
            					<td colspan="3"><input type="text" value="전기 충전소는 공공데이터 연계로 3~4분 정도 지연이 있으며, 갱신 주기는 5분입니다. 수소 충전소는 정보 확인 시 지연 시간 없이 제공하고 있습니다. *한국환경공단 전기자동차 충전소 정보 등 활용" /></td>
            				</tr>
            				<tr>
            				</tr>
            			</tbody>
            		</table>
            	</div>
            </div>
            
            <div class="button-group">
            	<button class="btn btn-primary">수정</button>
            	<button class="btn btn-secondary">삭제</button>
            	<button class="btn btn-secondary">취소</button>
            </div>

        </div>
    </div>
</body>
</html>
