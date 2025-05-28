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
                        <li><a href="faq_board.jsp">FaQ 관리</a></li>
                        <li><a href="qna_board.jsp">QaA 관리</a></li>
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
                <h1>공지사항 수정</h1>
            </div>
            <div class="content">
            	<div class="notice-content">
            		<table class="notice-table">
            			<tbody>
            				<tr>
            					<td>작성자</td>
            					<td><input type="text" value="admin03" /></td>
            					<td>작성일</td>
            					<td><input type="text" value="2025-05-03" /></td>
            				</tr>
            				<tr>
            					<td>제목</td>
            					<td colspan="3"><input type="text" value="[고속도로 교통상황] 오후 4~5시 정체 절정...영동선, 서해안선 혼잡" /></td>
            				</tr>
            				<tr>
            					<td>내용</td>
            					<td colspan="3"><input type="text" value="5월 어린이날 연휴 마지막날인 6일 화요일은 교통량이 평소 주말 및 화요일 보다는 감소하지만 서울 방향은 다소 혼잡할 것으로 전망된다.
한국도로 공사에 따르면 이날 전국 고속도록 교통량은 516만대로 예상된다. 수도권에서 지방으로 빠져나가는 차량은 36만대, 지방에서 수도권으로 진입하는 차량은 50만대로 예측된다.
지방방향은 비교적 원활하지만, 서울 방향은 영동선과 서해안선을 위주로 오후 4시께 가장 혼잡할 것으로 보인다.
시간대별로 오전 9시~10시 정체가 시작돼 오후 4시~5시 절정에 이르다 오후 10시~11시 헤소될 것으로 보인다." /></td>
            				</tr>
            				<tr>
            				</tr>
            			</tbody>
            		</table>
            	</div>
            </div>
            
            <div class="button-group">
            	<button class="btn btn-primary">수정</button>
            	<button class="btn btn-secondary">취소</button>
            </div>

        </div>
    </div>
</body>
</html>
