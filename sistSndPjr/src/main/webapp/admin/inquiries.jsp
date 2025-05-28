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
					class="toggle-submenu"><i class="fas fa-users"></i> 계정 관리 <i
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
						<li><a href="faq_board.jsp">FAQ 관리</a></li>
						<li><a href="qna_board.jsp">QaA 관리</a></li>
					</ul></li>

				<li class="menu-item"><a href="inquiries.jsp"><i
						class="fas fa-question-circle"></i> 문의 관리</a></li>

				<li class="menu-item"><a href="reviews.jsp"><i
						class="fas fa-star"></i> 리뷰 조회/신고관리</a></li>

				<li class="menu-item"><a href="rest-areas.jsp"><i
						class="fas fa-map-marker-alt"></i> 휴게소 관리</a></li>
			</ul>
		</div>

		<!-- Main Content -->
		<div class="main-content">
			<div class="header">
				<h1>문의 관리</h1>
			</div>
			
			<div class="search">
				<textarea rows="" cols=""></textarea>
				~
				<textarea rows="" cols=""></textarea>
				<input type="button" class="btn btn-secondary" value="검색"/>
			</div>

			<div class="content">
				<table class="data-table">
					<thead>
						<tr>
							<th><input type="checkbox" /></th>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
						<tr onclick="location.href='inquiry_detail.jsp'">
							<td><input type="checkbox" /></td>
							<td>10</td>
							<td>닉네임 변경</td>
							<td>주현석</td>
							<td>2025-05-08</td>
							<td>답변완료</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>9</td>
							<td>탈퇴 후 재가입</td>
							<td>박선은</td>
							<td>2025-05-07</td>
							<td>답변완료</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>8</td>
							<td>전화번호 수정</td>
							<td>유연수</td>
							<td>2025-05-03</td>
							<td>답변완료</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>7</td>
							<td>이벤트 일정</td>
							<td>신민기</td>
							<td>2025-05-02</td>
							<td>답변완료</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>6</td>
							<td>비밀번호 변경</td>
							<td>현지영</td>
							<td>2025-05-01</td>
							<td>답변완료</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>5</td>
							<td>이벤트 일정</td>
							<td>현지영</td>
							<td>2025-04-28</td>
							<td>대기</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>4</td>
							<td>아이디 찾기</td>
							<td>장태규</td>
							<td>2025-04-26</td>
							<td>답변완료</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>3</td>
							<td>전화번호 수정</td>
							<td>장태규</td>
							<td>2025-01-27</td>
							<td>대기</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>2</td>
							<td>회원탈퇴</td>
							<td>이여진</td>
							<td>2025-01-27</td>
							<td>답변완료</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>1</td>
							<td>로그인 오류</td>
							<td>이여진</td>
							<td>2024-12-12</td>
							<td>대기</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="pagination">
				<a href="#" class="first-page"><i
					class="fas fa-angle-double-left"></i></a> <a href="#" class="active">1</a>
				<a href="#">2</a> <a href="#">3</a> <a href="#">4</a> <a href="#">5</a>
				<a href="#" class="last-page"><i
					class="fas fa-angle-double-right"></i></a>
			</div>

			<div class="button-group">
				<button class="btn btn-primary">작성</button>
				<button class="btn btn-secondary">삭제</button>
			</div>
		</div>
	</div>
</body>
</html>
