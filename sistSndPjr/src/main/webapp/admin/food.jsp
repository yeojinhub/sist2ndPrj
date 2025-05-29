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
        <jsp:include page="admin_sidebar.jsp" />

		<!-- Main Content -->
		<div class="main-content">
			<div class="header">
				<h1>주유소 관리</h1>
			</div>
			
			<div class="search-div">
				<span class="search-area">노선명</span>
				<textarea class="search-title" rows="" cols=""></textarea>
				<span class="search-area">휴게소명</span>
				<textarea class="search-title" rows="" cols=""></textarea>
				<input type="button" class="btn-search" value="검색"/>
			</div>

			<div class="content">
				<table class="data-table">
					<thead>
						<tr>
							<th><input type="checkbox" /></th>
							<th>번호</th>
							<th>휴게소명</th>
							<th>전화번호</th>
							<th>휘발유</th>
							<th>경유</th>
							<th>LPG</th>
							<th>전기충전소</th>
							<th>수소충전소</th>
							<th>영업시간</th>
						</tr>
					</thead>
					<tbody>
						<tr onclick="location.href='area_detail.jsp'">
							<td><input type="checkbox" /></td>
							<td>210</td>
							<td>강릉대관령(인천)</td>
							<td>033-647-7112</td>
							<td>1,574원</td>
							<td>1,439원</td>
							<td>1,117원</td>
							<td>O</td>
							<td>X</td>
							<td>00:00 - 23:59</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>209</td>
							<td>강릉대관령(인천)</td>
							<td>033-647-7112</td>
							<td>1,574원</td>
							<td>1,439원</td>
							<td>1,117원</td>
							<td>O</td>
							<td>X</td>
							<td>00:00 - 23:59</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>208</td>
							<td>강릉대관령(인천)</td>
							<td>033-647-7112</td>
							<td>1,574원</td>
							<td>1,439원</td>
							<td>1,117원</td>
							<td>O</td>
							<td>X</td>
							<td>00:00 - 23:59</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>207</td>
							<td>강릉대관령(인천)</td>
							<td>033-647-7112</td>
							<td>1,574원</td>
							<td>1,439원</td>
							<td>1,117원</td>
							<td>O</td>
							<td>X</td>
							<td>00:00 - 23:59</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>206</td>
							<td>강릉대관령(인천)</td>
							<td>033-647-7112</td>
							<td>1,574원</td>
							<td>1,439원</td>
							<td>1,117원</td>
							<td>O</td>
							<td>X</td>
							<td>00:00 - 23:59</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>205</td>
							<td>강릉대관령(인천)</td>
							<td>033-647-7112</td>
							<td>1,574원</td>
							<td>1,439원</td>
							<td>1,117원</td>
							<td>O</td>
							<td>X</td>
							<td>00:00 - 23:59</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>204</td>
							<td>강릉대관령(인천)</td>
							<td>033-647-7112</td>
							<td>1,574원</td>
							<td>1,439원</td>
							<td>1,117원</td>
							<td>O</td>
							<td>X</td>
							<td>00:00 - 23:59</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>203</td>
							<td>강릉대관령(인천)</td>
							<td>033-647-7112</td>
							<td>1,574원</td>
							<td>1,439원</td>
							<td>1,117원</td>
							<td>O</td>
							<td>X</td>
							<td>00:00 - 23:59</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>202</td>
							<td>강릉대관령(인천)</td>
							<td>033-647-7112</td>
							<td>1,574원</td>
							<td>1,439원</td>
							<td>1,117원</td>
							<td>O</td>
							<td>X</td>
							<td>00:00 - 23:59</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>201</td>
							<td>강릉대관령(인천)</td>
							<td>033-647-7112</td>
							<td>1,574원</td>
							<td>1,439원</td>
							<td>1,117원</td>
							<td>O</td>
							<td>X</td>
							<td>00:00 - 23:59</td>
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
				<button class="btn btn-add" onclick="location.href='petrol_add.jsp'">등록</button>
			</div>
		</div>
	</div>
</body>
</html>
