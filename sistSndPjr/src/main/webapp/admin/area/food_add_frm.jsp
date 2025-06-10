<%@page import="Admin.Area.FoodDTO"%>
<%@page import="Admin.Area.FoodService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/jsp/login_chk.jsp" %>
<%
String paramNum=request.getParameter("areaNum");

int num=0;
try{
	num=Integer.parseInt(paramNum);
} catch(NumberFormatException nfe) {
	nfe.printStackTrace();
} //end try catch

FoodService service = new FoodService();
FoodDTO foodDTO = service.searchOneArea(num);
		
request.setAttribute("num", num);
request.setAttribute("foodDTO", foodDTO);
		
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
<script src="/sistSndPjr/admin/common/js/food_manage.js"></script>

</head>
<body>
	<div class="container">
		<!-- Sidebar -->
		<jsp:include page="/admin/common/jsp/admin_sidebar.jsp" />

		<!-- Main Content -->
		<div class="main-content">
			<div class="header">
				<h1>먹거리 추가</h1>
			</div>

			<form name="addFrm" id="addFrm" method="post" action="food_add_process.jsp">
			<div class="content">
				<div>
					<div>
						<h1><c:out value="${ foodDTO.areaName }"></c:out> </h1>
					</div>
				</div>
				
				<input type="hidden" name="areaNum" id="areaNum" value="${ num }" />
				<table class="account-table account-content">
					<tbody>
						<tr>
							<td>휴게소명</td>
							<td><input type="text" name="areaName" id="areaName" value="${ foodDTO.areaName }"
									readonly="readonly"/></td>
						</tr>
						<tr>
							<td>노선</td>
							<td><input type="text" name="route" id="route" value="${ foodDTO.areaRoute }"
									readonly="readonly"/></td>
						</tr>
						<tr>
							<td>음식명</td>
							<td><input type="text" name="foodName" id="foodName" /></td>
						</tr>
						<tr>
							<td>가격</td>
							<td><input type="text" name="price" id="price" /></td>
						</tr>
					</tbody>
				</table>

				<div class="button-group-area-detail">
					<input type="button" class="btn btn-add" id="btnFoodAdd" value="등록" />
					<input type="button" class="btn btn-back" id="btnFoodBack" value="뒤로" />
				</div>
			</div>
			</form>
		</div>
	</div>
</body>
</html>
