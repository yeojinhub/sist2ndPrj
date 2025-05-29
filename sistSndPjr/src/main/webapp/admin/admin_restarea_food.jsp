<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 대시보드</title>
<link rel="stylesheet" href="../common/css/styles.css">
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
				<h1>먹거리 작성</h1>
			</div>

			<div class="content">
				<div>
					<div>
						<h1>금강휴게소</h1>
					</div>
					<div class="addBtn-wrapper">
					<input type="button" class="btn btn-primary addBtn" value="추가+" />
					</div>
				</div>
				<table class="data-table">
					<thead>
						<tr>
							<th><input type="checkbox" class="label-checkbox"></th>
							<th>번호</th>
							<th>음식명</th>
							<th>가격</th>
							<th>이미지</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th><input type="checkbox" class="label-checkbox"></th>
							<td>10</td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<th><input type="checkbox" class="label-checkbox"></th>
							<td>9</td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<th><input type="checkbox" class="label-checkbox"></th>
							<td>8</td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<th><input type="checkbox" class="label-checkbox"></th>
							<td>7</td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<th><input type="checkbox" class="label-checkbox"></th>
							<td>6</td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<th><input type="checkbox" class="label-checkbox"></th>
							<td>5</td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<th><input type="checkbox" class="label-checkbox"></th>
							<td>4</td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<th><input type="checkbox" class="label-checkbox"></th>
							<td>3</td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<th><input type="checkbox" class="label-checkbox"></th>
							<td>2</td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
						</tr>
						<tr>
							<th><input type="checkbox" class="label-checkbox"></th>
							<td>1</td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
						</tr>
					</tbody>
				</table>

			<div class="button-group-area-detail">
				<button class="btn btn-primary">수정</button>
				<button class="btn btn-secondary">취소</button>
			</div>
			</div>

		</div>
	</div>
</body>
</html>
