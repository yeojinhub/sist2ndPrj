<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <link rel="stylesheet" href="/sistSndPjr/admin/common/css/styles.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="/sistSndPjr/admin/script.js"></script>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="/admin/common/jsp/admin_sidebar.jsp" />

		<!-- Main Content -->
		<div class="main-content">
			<div class="header">
				<h1>주유소 등록</h1>
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
				<button class="btn btn-edit">수정</button>
				<button class="btn btn-back" onclick="location.href='petrol.jsp'">뒤로</button>
			</div>
			</div>

		</div>
	</div>
</body>
</html>
