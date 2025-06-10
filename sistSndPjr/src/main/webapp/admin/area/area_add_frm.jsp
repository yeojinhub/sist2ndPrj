<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/jsp/login_chk.jsp" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>관리자 대시보드</title>

<!-- 사용자 정의 css 로드 -->
<link rel="stylesheet" href="/sistSndPjr/admin/common/css/styles.css">

<!-- Font Awesome for icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- jQuery 로드 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 사용자 정의 JS 로드 -->
<script src="/sistSndPjr/admin/script.js"></script>
<script src="/sistSndPjr/admin/common/js/area_manage.js"></script>

</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="/admin/common/jsp/admin_sidebar.jsp" />

		<!-- Main Content -->
		<div class="main-content">
			<div class="header">
				<h1>휴게소 등록</h1>
			</div>
			
			<form name="addFrm" id="addFrm" method="post">
				<div class="content">
					<div class="top-section">
						<div class="left-area">
						<!-- 기본 정보 -->
						<div class="info-section">
							<h3 style="margin-left: 20px;">상세정보</h3>
							<hr style="border: 1px solid #ccc;">
							<input type="hidden" name="num" id="num" value="${ areaDTO.area_num }" />
							<div class="input-row">
								<label class="info-label">휴게소명</label>
								<input type="text" name="name" id="name" />
							</div>

							<div class="input-row">
								<label class="info-label">주소</label>
								<input type="text" name="addr" id="addr" />
							</div>

							<div class="input-row">
								<label class="info-label">전화번호</label>
								<input type="text" class="small-input" name="tel" id="tel" />
								<label class="info-label route-label">노선</label>
								<input type="text" class="small-input" name="route" id="route" />
							</div>

							<div class="input-row">
								<label class="info-label">위도</label>
								<input type="text" class="small-input" name="lat" id="lat" />
								<label class="info-label route-label">경도</label>
								<input type="text" class="small-input" name="lng" id="lng" />
							</div>

							<div class="input-row">
								<label class="info-label">영업시간</label>
								<input type="text" name="operationTime" id="operationTime" />
							</div>
						</div>
					</div>

					<!-- 편의시설 -->
					<div class="right-area">
						<div class="facility-section">
							<h3 style="margin-left: 20px;">편의시설</h3>
							<hr style="border: 1px solid #ccc;">
							<div class="checkbox-group">
								<label class="facility-label"><input type="checkbox" class="label-checkbox" name="feed" id="feed"> 수유실</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox" name="sleep" id="sleep"> 수면실</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox" name="shower" id="shower"> 샤워실</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox" name="laundry" id="laundry"> 세탁실</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox" name="clinic" id="clinic"> 병원</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox" name="pharmacy" id="pharmacy"> 약국</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox" name="shelter" id="shelter"> 쉼터</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox" name="salon" id="salon"> 이발소</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox" name="agricultural" id="agricultural"> 농산물판매장</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox" name="repair" id="repair"> 경정비소</label>
								<label class="facility-label"><input type="checkbox" class="label-checkbox" name="truck" id="truck"> 화물차라운지</label>
								<input type="text" name="tempText" id="tempText" placeholder="추가시설">
							</div>
						</div>
					</div>
					</div>
				</div>

				<div class="button-group-area-detail">
					<input type="button" class="btn btn-add" id="btnAreaAdd" value="등록" />
					<input type="button" class="btn btn-back" id="btnAreaBack" value="뒤로" />
				</div>
			</form>
		</div>
	</div>
</body>
</html>
