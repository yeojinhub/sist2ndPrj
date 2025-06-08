<%@page import="user.restarea.detail.AreaDetailDTO"%>
<%@page import="user.restarea.detail.RestAreaDetailService"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
RestAreaDetailService rads = new RestAreaDetailService();

int id = Integer.parseInt(request.getParameter("id"));

AreaDetailDTO adDTO = rads.searchRestAreaDetail(id);

pageContext.setAttribute("adDTO", adDTO);
%>
<style>
.info-container {
	display: flex;
	justify-content: space-between;
	gap: 20px;
	margin-bottom: 20px;
}

.info-image, .info-map {
	flex: 1;
	height: 400px;
	background-color: #eee;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 14px;
	color: #666;
}

.info-table {
	width: 100%;
	border-collapse: collapse; 
	margin-top: 10px;
	font-size: 14px;
	table-layout: fixed;
}

.info-table th, .info-table td {
	border: 1px solid #ccc;
	padding: 10px;
	text-align: center;
	aspect-ratio: 1 / 1;
}

.info-table th {
	background-color: #f5f5f5;
	font-weight: bold;
}
</style>

<div class="info-container">
	<div class="info-image">
		<div id="roadview" style="width:100%; height:100%;"></div>
		<script>
			kakao.maps.load(function() {
				var roadviewContainer = document.getElementById('roadview'); //로드뷰를 표시할 div
				var roadview = new kakao.maps.Roadview(roadviewContainer); //로드뷰 객체
				var roadviewClient = new kakao.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체
				
				var position = new kakao.maps.LatLng(${adDTO.lat}, ${adDTO.lng});
				
				// 특정 위치의 좌표와 가까운 로드뷰의 panoId를 추출하여 로드뷰를 띄운다.
				roadviewClient.getNearestPanoId(position, 50, function(panoId) {
				    roadview.setPanoId(panoId, position); //panoId와 중심좌표를 통해 로드뷰 실행
				});
			});	
		</script>
	</div>
	<div class="info-map">
		<div id="map" style="width: 100%; height: 100%;"></div>
		<script>
			kakao.maps.load(function() {
				var mapContainer = document.getElementById('map');
				var mapOption = {
					center: new kakao.maps.LatLng(${adDTO.lat}, ${adDTO.lng}),
					level: 3
				};
				var map = new kakao.maps.Map(mapContainer, mapOption);
				
				var markerPosition  = new kakao.maps.LatLng(${adDTO.lat}, ${adDTO.lng});
				
				var marker = new kakao.maps.Marker({
				    position: markerPosition
				});
				
				marker.setMap(map);
			});			
		</script>
	</div>
</div>

<table class="info-table">
	<tr>
		<th>주소</th>
		<td colspan="3"><c:out value="${adDTO.addr }"/></td>
	</tr>
	<tr>
		<th>노선</th>
		<td><c:out value="${adDTO.route }"/></td>
		<th>전화번호</th>
		<td><c:out value="${adDTO.tel }"/></td>
	</tr>
	<tr>
		<th colspan="4">편의시설</th>
	</tr>
	<tr>
		<td>수유실</td>
		<td><c:out value="${adDTO.feed }"/></td>
		<td>수면실</td>
		<td><c:out value="${adDTO.sleep }"/></td>
	</tr>
	<tr>
		<td>샤워실</td>
		<td><c:out value="${adDTO.shower }"/></td>
		<td>세탁실</td>
		<td><c:out value="${adDTO.laundry }"/></td>
	</tr>
	<tr>
		<td>병원</td>
		<td><c:out value="${adDTO.clinic }"/></td>
		<td>약국</td>
		<td><c:out value="${adDTO.pharmacy }"/></td>
	</tr>
	<tr>
		<td>쉼터</td>
		<td><c:out value="${adDTO.shelter }"/></td>
		<td>이발소</td>
		<td><c:out value="${adDTO.salon }"/></td>
	</tr>
	<tr>
		<td>경정비소</td>
		<td><c:out value="${adDTO.repair }"/></td>
		<td>Ex. 화물차라운지</td>
		<td><c:out value="${adDTO.truck }"/></td>
	</tr>
	<tr>
		<td>추가시설</td>
		<td colspan="3"><c:out value="${adDTO.temp }"/></td>
	</tr>
</table>



