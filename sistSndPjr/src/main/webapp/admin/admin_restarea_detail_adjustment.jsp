<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 대시보드</title>
<link rel="stylesheet" href="../common/css/styles.css">
<script src="script.js"></script>
<!-- Font Awesome for icons -->
<link rel="stylesheet"
	href="http://localhost/restarea_prj/common/css/style.css">
</head>
<body>
	<div class="container">
		<!-- Sidebar -->
		<div class="sidebar">
			<div class="logo-container">
				<img src="../common/images/logo.png" alt="로고" class="logo"> <span
					class="logo-text">모두쉼</span>
			</div>

			<div class="admin-info">
				<span class="admin-label">관리자</span> <span class="admin-name">김민경님</span>
				<button class="logout-btn">로그아웃</button>
			</div>

			<ul class="menu">
				<li class="menu-item"><a href="home.jsp"><i
						class="fas fa-home"></i> Home</a></li>

				<li class="menu-item has-submenu"><a href="#"
					class="toggle-submenu"><i class="fas fa-users"></i> 계정관리 <i
						class="fas fa-chevron-down arrow"></i></a>
					<ul class="submenu">
						<li><a href="user_accounts.jsp">회원 계정관리</a></li>
						<li><a href="admin_accounts.jsp">관리자 계정관리</a></li>
					</ul></li>

				<li class="menu-item has-submenu"><a href="#"
					class="toggle-submenu"><i class="fas fa-clipboard-list"></i>
						게시판 관리 <i class="fas fa-chevron-down arrow"></i></a>
					<ul class="submenu">
						<li><a href="notice_board.jsp">공지사항 관리</a></li>
						<li><a href="faq_board.jsp">FaQ 관리</a></li>
						<li><a href="qna_board.jsp">QaA 관리</a></li>
					</ul></li>

				<li class="menu-item"><a href="inquiries.jsp"><i
						class="fas fa-question-circle"></i> 문의관리</a></li>

				<li class="menu-item"><a href="reviews.jsp"><i
						class="fas fa-star"></i> 리뷰 조회/신고관리</a></li>

				<li class="menu-item"><a href="rest-areas.jsp"><i
						class="fas fa-map-marker-alt"></i> 휴게소 관리</a></li>
			</ul>
		</div>

		<!-- Main Content -->
		<div class="main-content">
			<div class="header">
				<h1>휴게소 상세정보 수정</h1>
			</div>
			<div class="content">
			
				<div class="top-section">
					<div class="left-area">
						<!-- 기본 정보 -->
						<div class="info-section">
							<h3 style="margin-left: 20px;">상세정보</h3>
							<hr style="border: 1px solid #ccc;">
							<div class="input-row">
								<label class="info-label">휴게소명</label> <input type="text"
									readonly>
							</div>

							<div class="input-row">
								<label class="info-label">주소</label> <input type="text" readonly>
							</div>

							<div class="input-row">
								<label class="info-label">전화번호</label> <input type="text"
									class="small-input" readonly> <label
									class="info-label route-label">노선</label> <input type="text"
									class="small-input" readonly>
							</div>

							<div class="input-row">
								<label class="info-label">위도</label> <input type="text"
									class="small-input" readonly> <label
									class="info-label route-label">경도</label> <input type="text"
									class="small-input" readonly>
							</div>

							<div class="input-row">
								<label class="info-label">영업시간</label> <input type="text"
									readonly>
							</div>
						</div>
					</div>

					<!-- 편의시설 -->
					<div class="right-area">
						<div class="facility-section">
							<h3 style="margin-left: 20px;">편의시설</h3>
							<hr style="border: 1px solid #ccc;">
							<div class="checkbox-group">
								<label class="facility-label"><input type="checkbox" class="label-checkbox"> 수유실</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox"> 쉼터</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox"> 수면실</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox"> 이발소</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox"> 샤워실</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox"> 경정비소</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox"> 세탁실</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox"> 세차장</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox"> 병원</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox"> 약국</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox"> 화물차라운지</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox"><input type="text"></label>
							</div>
						</div>
					</div>
				</div>

			</div>

			<div class="button-group-area-detail">
				<button class="btn btn-primary">수정</button>
				<button class="btn btn-secondary">취소</button>
			</div>

		</div>
	</div>
</body>
</html>
