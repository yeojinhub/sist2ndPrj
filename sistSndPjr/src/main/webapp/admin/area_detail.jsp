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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
	<div class="container">
		<!-- Sidebar -->
        <jsp:include page="admin_sidebar.jsp" />

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
								<label class="info-label">휴게소명</label> <input type="text" value="홍천강(춘천)"
									readonly>
							</div>

							<div class="input-row">
								<label class="info-label">주소</label> <input type="text" value="강원도 홍천군 홍천읍 홍천강변로 123-4" readonly>
							</div>

							<div class="input-row">
								<label class="info-label">전화번호</label> <input type="text"
									class="small-input" value="033-435-1201" readonly> <label
									class="info-label route-label">노선</label> <input type="text"
									class="small-input" value="중앙선" readonly>
							</div>

							<div class="input-row">
								<label class="info-label">위도</label> <input type="text"
									class="small-input" value="37.712386" readonly> <label
									class="info-label route-label">경도</label> <input type="text"
									class="small-input" value="127.827719" readonly>
							</div>

							<div class="input-row">
								<label class="info-label">영업시간</label> <input type="text" value="00:00 - 23:59"
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
				<button class="btn btn-edit">수정</button>
				<button class="btn btn-back" onclick="location.href='areas.jsp'">취소</button>
			</div>

		</div>
	</div>
</body>
</html>
