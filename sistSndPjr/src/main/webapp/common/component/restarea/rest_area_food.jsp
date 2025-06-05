<%@page import="DTO.AreaDetailFoodDTO"%>
<%@page import="java.util.List"%>
<%@page import="restarea.detail.RestAreaDetailFoodService"%>
<%@page import="restarea.detail.RestAreaDetailFoodDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
int id = Integer.parseInt(request.getParameter("id"));

RestAreaDetailFoodService radfs = new RestAreaDetailFoodService();

List<AreaDetailFoodDTO> list = radfs.searchAllFood(id);

pageContext.setAttribute("foodList", list);
%>
<style>
.food-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 20px;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 14px;
	margin-bottom: 20px;
}

.food-card {
	border: 1px solid #ccc;
	border-radius: 8px;
	background-color: #f8f8f8;
	text-align: center;
	padding: 12px;
}

.food-image {
	width: 100%;
	aspect-ratio: 1/1;
	background-color: #ddd;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 8px;
	font-size: 13px;
	color: #999;
}

.food-name {
	font-weight: bold;
	margin-bottom: 4px;
}

.food-price {
	color: #333;
}

.hidden {
	display: none;
}

.more-btn {
	display: block;
	margin: 0 auto;
	margin-top: 16px;
	font-weight: bold;
	font-size: 16px;
	color: #222;
	background: none;
	border: none;
	cursor: pointer;
}

.more-btn:hover {
	color: #2f5fd0;
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

<div class="food-table">
	<table class="info-table">
		<thead>
			<tr>
				<th style="width: 20%;">번호</th>
				<th style="width: 60%;">음식명</th>
				<th style="width: 20%;">가격</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty foodList }">
				<tr>
					<td colspan="3">등록된 먹거리가 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="food" items="${foodList }" varStatus="i">
				<tr>
					<td><c:out value="${i.count }" /></td>
					<td><c:out value="${food.name }" /></td>
					<td><c:out value="${food.price }" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
