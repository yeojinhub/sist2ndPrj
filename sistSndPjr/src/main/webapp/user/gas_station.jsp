<%@page import="GasStation.PaginationUtil"%>
<%@page import="DTO.PaginationDTO"%>
<%@page import="GasStation.PetrolService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="rDTO" class="DTO.RangeDTO" scope="page"/>
<jsp:setProperty name="rDTO" property="*"/>
<%
request.setAttribute("menu", "gas");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>노선별주유소</title>
<jsp:include page="../common/jsp/external_file.jsp" />

<style>
.footer {
	width: 100%;
	padding-top: 15%;
}
</style>
</head>

<body>
	<header>
		<jsp:include page="../common/jsp/header.jsp" />
	</header>
	<div class="container" style="display: flex; flex-direction: column;">
		<div>
			<hr class="line_blue" style="text-align: center;">
		</div>
		<div>
			<h2>
				<span style="font-size: 40px;">휴게소/영업소_</span> <span
					style="font-size: 30px;">주유소</span>
			</h2>
		</div>

		<div class="search-box">
			<label>노선명:</label> <select>
				<option>선택1</option>
				<option>선택2</option>
				<option>선택3</option>
			</select> <label>주유소명:</label> <input type="text" /> <label><input
				type="checkbox"> 전기충전소</label> <label><input type="checkbox">
				수소충전소</label>

			<button class="btn btn-confirm">검색</button>
		</div>
		<%
			PetrolService ps = new PetrolService();

			// 1. 전체 데이터(게시물)수를 구합니다.
			int totalCount = 0;
			totalCount = ps.searchTotalCount();
			// 2. 페이지에 보여질 게시물의 수를 구합니다.
			int pageScale = 0;
			pageScale = ps.pageScale();
			// 3. 총 페이지의 수를 구합니다.
			int totalPage = 0;
			totalPage = ps.totalPage(totalCount, pageScale);
			// 4. 현재페이지(currentPage)에 따른 게시물 시작 번호를 구합니다.
			int startNum = 0;
			startNum = ps.startNum(pageScale, rDTO);
			// 5. 현재페이지(currentPage)에 따른 게시물 끝 번호를 구합니다.
			int endNum = 0;
			endNum = ps.endNum(pageScale, rDTO);
			
			pageContext.setAttribute("totalCount", totalCount);
			pageContext.setAttribute("pageScale", pageScale);
			pageContext.setAttribute("totalPage", totalPage);
			pageContext.setAttribute("startNum", startNum);
			pageContext.setAttribute("endNum", endNum);
			
			// rDTO를 보내서 시작번호와 끝번호 데이터를 구해온다.
			pageContext.setAttribute("petrolList", ps.searchAllPetrol(rDTO));
			%>
		<table class="user_table" style="flex: 1;">
			<thead>
				<tr>
					<th>주유소명</th>
					<th>전화번호</th>
					<th>휘발유</th>
					<th>경유</th>
					<th>LPG</th>
					<th>전기충전소</th>
					<th>수소충전소</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty petrolList }">
					<tr>
						<td colspan="7" style="text-align: center;">주유소 정보가 존재하지 않습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="pDTO" items="${petrolList }" varStatus="i">
					<tr>
						<td><c:out value="${pDTO.name }"/></td>					
						<td><c:out value="${pDTO.tel }"/></td>					
						<td><c:out value="${pDTO.gasoline }"/></td>					
						<td><c:out value="${pDTO.diesel }"/></td>					
						<td><c:out value="${pDTO.lpg }"/></td>					
						<td><c:out value="${pDTO.elect }"/></td>					
						<td><c:out value="${pDTO.hydro }"/></td>					
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<!-- 페이지네이션 -->
		<%
		PaginationDTO pDTO = new PaginationDTO(5, rDTO.getCurrentPage(), totalPage, "gas_station.jsp", null, null);
		%>
		<%= PaginationUtil.pagination(pDTO) %>
		
		<div class="agent-container" style="flex: 1;">
			<div class="agent-box">담당자 정보</div>
			<div class="agent-call">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;모두쉼
				콜센터 : 02-1234-5678</div>
		</div>
	</div>
	<%-- End of container div --%>


</body>
<div class="footer">
	<footer>
		<jsp:include page="../common/jsp/footer.jsp" />
	</footer>
</div>

</html>