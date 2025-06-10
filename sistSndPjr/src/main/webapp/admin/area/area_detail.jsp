<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="Admin.Area.AreaDTO"%>
<%@page import="Admin.Area.AreaService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/jsp/login_chk.jsp" %>
<%
String paramNum=request.getParameter("area_num");

int num=0;
try{
	num=Integer.parseInt(paramNum);
} catch(NumberFormatException nfe) {
	nfe.printStackTrace();
} //end try catch

AreaService areaService = new AreaService();
AreaDTO areaDTO = areaService.searchOneArea(num);
request.setAttribute("areaDTO", areaDTO);
		
//Map으로 편의시설 정리
Map<String, String> facilityMap = new LinkedHashMap<>();
facilityMap.put("수유실", areaDTO.getFeed());
facilityMap.put("수면실", areaDTO.getSleep());
facilityMap.put("샤워실", areaDTO.getShower());
facilityMap.put("세탁실", areaDTO.getLaundry());
facilityMap.put("병원", areaDTO.getClinic());
facilityMap.put("약국", areaDTO.getPharmacy());
facilityMap.put("쉼터", areaDTO.getShelter());
facilityMap.put("이발소", areaDTO.getSalon());
facilityMap.put("농산물판매장", areaDTO.getAgricultural());
facilityMap.put("경정비소", areaDTO.getRepair());
facilityMap.put("화물차라운지", areaDTO.getTruck());
facilityMap.put("추가시설", areaDTO.getTemp());

request.setAttribute("facilityMap", facilityMap);

%>
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
				<h1>휴게소 상세정보 수정</h1>
			</div>
			
			<form name="editFrm" id="editFrm" method="post">
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
								<input type="text" value="${ areaDTO.name }" readonly="readonly" />
							</div>

							<div class="input-row">
								<label class="info-label">주소</label>
								<input type="text" value="${ areaDTO.addr }" readonly="readonly" />
							</div>

							<div class="input-row">
								<label class="info-label">전화번호</label>
								<input type="text" class="small-input" value="${ areaDTO.tel }" readonly="readonly" />
								<label class="info-label route-label">노선</label>
								<input type="text" class="small-input" value="${ areaDTO.route }" readonly="readonly" />
							</div>

							<div class="input-row">
								<label class="info-label">위도</label>
								<input type="text" class="small-input" value="${ areaDTO.lat }" readonly="readonly" />
								<label class="info-label route-label">경도</label>
								<input type="text" class="small-input" value="${ areaDTO.lng }" readonly="readonly" />
							</div>

							<div class="input-row">
								<label class="info-label">영업시간</label>
								<input type="text" value="${ areaDTO.operation_time }" readonly="readonly" />
							</div>
						</div>
					</div>

					<!-- 편의시설 -->
					<div class="right-area">
						<div class="facility-section">
							<h3 style="margin-left: 20px;">편의시설</h3>
							<hr style="border: 1px solid #ccc;">
							<div class="checkbox-group">
							<c:forEach var="entry" items="${ facilityMap }">
								<label class="facility-label">
								<c:choose>
									<c:when test="${ entry.key eq '추가시설' and not empty entry.value }">
										<input type="text" name="textText" id="tempText" value="${entry.value}" />
									</c:when>
									 
									<c:when test="${ entry.key eq '추가시설' and (entry.value eq 'X' or empty entry.value) }">
										<input type="text" name="tempText" id="tempText" />
									</c:when>
									
									<c:when test="${ entry.value eq 'O' }">
										<input type="checkbox" class="label-checkbox" name="${entry.key}" checked="checked" />
										<c:out value="${ entry.key }" />
									</c:when>
									
									<c:otherwise>
										<input type="checkbox" class="label-checkbox" name="${entry.key}" />
										<c:out value="${ entry.key }" />
									</c:otherwise>
								</c:choose>
								</label>
							</c:forEach>
							</div>
						</div>
					</div>
					</div>
				</div>

				<div class="button-group-area-detail">
					<input type="button" class="btn btn-edit" id="btnAreaModify" value="수정" />
					<input type="button" class="btn btn-back" id="btnAreaBack" value="뒤로" />
				</div>
			</form>
		</div>
	</div>
</body>
</html>
