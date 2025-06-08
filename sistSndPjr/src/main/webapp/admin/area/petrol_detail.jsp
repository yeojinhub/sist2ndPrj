<%@page import="Admin.Area.PetrolService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String paramNum=request.getParameter("petNum");

int num=0;
try{
num=Integer.parseInt(paramNum);
}catch (NumberFormatException nfe){
	response.sendRedirect("petrol_manage.jsp");
}//end catch

PetrolService service = new PetrolService();
request.setAttribute("petDTO", service.searchOnePetrol(num));
%>
<!DOCTYPE html>
<html>
<head>
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
<script src="/sistSndPjr/admin/common/js/petrol_manage.js"></script>

</head>
<body>
	<div class="container">
		<!-- Sidebar -->
		<jsp:include page="/admin/common/jsp/admin_sidebar.jsp" />

		<!-- Main Content -->
		<div class="main-content">
			<div class="header">
				<h1>주유소 수정</h1>
			</div>

			<form name="editFrm" id="editFrm" method="post">
				<div class="content">
					<input type="hidden" name="num" id="num" value="${ petDTO.petNum }" />
					<table class="account-table account-content">
						<tbody>
							<tr>
								<td>휴게소명</td>
								<td><input type="text" name="name" id="name" value="${ petDTO.areaName }"
									readonly="readonly"/></td>
							</tr>
							<tr>
								<td>노선</td>
								<td><input type="text" name="route" id="route"  value="${ petDTO.areaRoute }"
									readonly="readonly" /></td>
							</tr>
							<tr>
								<td>전화번호</td>
								<td><input type="text" name="tel" id="tel"  value="${ petDTO.areaTel }"
									readonly="readonly" /></td>
							</tr>
							<tr>
								<td>영업시간</td>
								<td><input type="text" name="operationTime" id="operationTime"  value="${ petDTO.operationTime }"
									readonly="readonly" /></td>
							</tr>
							<tr>
								<td>휘발유</td>
								<td><input type="text" name="gasoline" id="gasoline" value="${ petDTO.gasoline }" /></td>
							</tr>
							<tr>
								<td>경유</td>
								<td><input type="text" name="diesel" id="diesel" value="${ petDTO.diesel }" /></td>
							</tr>
							<tr>
								<td>LPG</td>
								<td><input type="text" name="lpg" id="lpg" value="${ petDTO.lpg }" /></td>
							</tr>
							<tr>
								<td>전기충전소</td>
								<td><input type="text" name="elect" id="elect" value="${ petDTO.elect }" /></td>
							</tr>
							<tr>
								<td>수소충전소</td>
								<td><input type="text" name="hydro" id="hydro" value="${ petDTO.hydro }" /></td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="button-group">
					<input type="button" class="btn btn-edit" id="btnPetModify" value="수정" />
					<input type="button" class="btn btn-back" id="btnPetBack" value="뒤로" />
				</div>
			</form>

		</div>
	</div>
</body>
</html>
