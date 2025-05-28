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
						class="fas fa-star"></i> 리뷰조회/신고관리</a></li>

				<li class="menu-item"><a href="rest-areas.jsp"><i
						class="fas fa-map-marker-alt"></i> 휴게소 관리</a></li>
			</ul>
		</div>

		<!-- Main Content -->
		<div class="main-content">
			<div class="header">
				<h1>리뷰조회/신고관리</h1>
			</div>
			
			<div class="content">
				<table class="data-table">
					<thead>
						<tr>
							<th><input type="checkbox" /></th>
							<th>번호</th>
							<th>휴게소명</th>
							<th>리뷰 내용</th>
							<th>작성자</th>
							<th>누적신고</th>
						</tr>
					</thead>
					<tbody>
						<tr onclick="location.href='reviews_detail.jsp'">
							<td><input type="checkbox" /></td>
							<td>50</td>
							<td>예산(당진)</td>
							<td>자연경관이 멋진 곳이에요!</td>
							<td>주현석</td>
							<td>0</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>49</td>
							<td>매송(서울)</td>
							<td>피곤할 때 쉬기에 최적의 장소입니다.</td>
							<td>주현석</td>
							<td>0</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>48</td>
							<td>백양사(천안)</td>
							<td>주차 구역이 넓어서 이용하기 편했어요.</td>
							<td>주현석</td>
							<td>0</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>47</td>
							<td>성주(창원)</td>
							<td>깨끗하고 정돈된 인상이었어요.</td>
							<td>주현석</td>
							<td>0</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>46</td>
							<td>영천(포항)</td>
							<td>뷰가 너무 좋아서 사진도 많이 찍었어요.</td>
							<td>주현석</td>
							<td>0</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>45</td>
							<td>여주(강릉)</td>
							<td>드라이브 중 꼭 들러야 할 곳 같아요.</td>
							<td>심규민</td>
							<td>0</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>44</td>
							<td>의성(영덕)</td>
							<td>간식 코너가 다양해서 좋았어요.</td>
							<td>심규민</td>
							<td>0</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>43</td>
							<td>구정(삼척)</td>
							<td>전체적으로 쾌적하고 조용했어요.</td>
							<td>심규민</td>
							<td>0</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>42</td>
							<td>단양팔경(부산)</td>
							<td>아이들이 놀기 좋은 공간이 있었어요.</td>
							<td>심규민</td>
							<td>0</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>41</td>
							<td>서부산(순천)</td>
							<td>정체 중 들렸는데 정말 힐링됐어요.</td>
							<td>심규민</td>
							<td>0</td>
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
				<button class="btn btn-primary">숨김</button>
			</div>
		</div>
	</div>
</body>
</html>
