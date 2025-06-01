<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="sidebar">
	<div class="logo-container">
		<img src="/sistSndPjr/admin/common/images/logo251.png" alt="로고" class="logo">
	</div>

	<div class="admin-info">
		<span class="admin-label">관리자</span> <span class="admin-name">김민경님</span>
		<button class="logout-btn">로그아웃</button>
	</div>

	<ul class="menu">
		<li class="menu-item"><a href="/sistSndPjr/admin/home.jsp"><i
				class="fas fa-home"></i> Home</a></li>
		<li class="menu-item has-submenu"><a href="#"
			class="toggle-submenu"><i class="fas fa-users"></i> 계정 관리 <i
				class="fas fa-chevron-down arrow"></i></a>
			<ul class="submenu">
				<li><a href="/sistSndPjr/admin/account/user_account_list.jsp">회원 계정관리</a></li>
				<li><a href="/sistSndPjr/admin/account/admin_accounts.jsp">관리자 계정관리</a></li>
			</ul></li>
		<li class="menu-item has-submenu"><a href="#"
			class="toggle-submenu"><i class="fas fa-clipboard-list"></i> 게시판
				관리 <i class="fas fa-chevron-down arrow"></i></a>
			<ul class="submenu">
				<li><a href="/sistSndPjr/admin/board/notice_board.jsp">공지사항 관리</a></li>
				<li><a href="/sistSndPjr/admin/board/faq_board.jsp">FAQ 관리</a></li>
			</ul></li>
		<li class="menu-item"><a href="/sistSndPjr/admin/inquiry/inquiries.jsp"><i
				class="fas fa-question-circle"></i> 문의 관리</a></li>
		<li class="menu-item"><a href="/sistSndPjr/admin/review/reviews.jsp"><i
				class="fas fa-star"></i> 리뷰조회/신고관리</a></li>
		<li class="menu-item has-submenu"><a href="#"
			class="toggle-submenu"><i class="fas fa-map-marker-alt"></i>휴게소
				관리 <i class="fas fa-chevron-down arrow"></i></a>
			<ul class="submenu">
				<li><a href="/sistSndPjr/admin/area/areas.jsp">상세정보 관리</a></li>
				<li><a href="/sistSndPjr/admin/area/food.jsp">먹거리 관리</a></li>
				<li><a href="/sistSndPjr/admin/area/petrol.jsp">주유소 관리</a></li>
			</ul></li>
	</ul>
</div>
