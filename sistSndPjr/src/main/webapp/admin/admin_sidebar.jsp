<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="sidebar">
	<div class="logo-container">
		<img src="../common/images/logo251.png" alt="로고" class="logo">
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
			class="toggle-submenu"><i class="fas fa-clipboard-list"></i> 게시판
				관리 <i class="fas fa-chevron-down arrow"></i></a>
			<ul class="submenu">
				<li><a href="notice_board.jsp">공지사항 관리</a></li>
				<li><a href="faq_board.jsp">FAQ 관리</a></li>
				<li><a href="qna_board.jsp">QaA 관리</a></li>
			</ul></li>
		<li class="menu-item"><a href="inquiries.jsp"><i
				class="fas fa-question-circle"></i> 문의 관리</a></li>
		<li class="menu-item"><a href="reviews.jsp"><i
				class="fas fa-star"></i> 리뷰조회/신고관리</a></li>
		<li class="menu-item has-submenu"><a href="#"
			class="toggle-submenu"><i class="fas fa-map-marker-alt"></i>휴게소
				관리 <i class="fas fa-chevron-down arrow"></i></a>
			<ul class="submenu">
				<li><a href="areas.jsp">상세정보 관리</a></li>
				<li><a href="petrol.jsp">주유소 관리</a></li>
			</ul></li>
	</ul>
</div>
