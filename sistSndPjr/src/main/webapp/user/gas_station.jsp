<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

</style>
</head>

<body>
	<header>
		<jsp:include page="../common/jsp/header.jsp" />
	</header>
	<div class="container" style="display: flex; flex-direction: column; ">
	<div><hr class="line_blue" style="text-align: center;"></div>
	<div>
		<h2><span style="font-size:40px;">휴게소/영업소_</span>
             <span style="font-size:30px;">주유소</span>
        </h2>
	</div>

	<div class="search-box">
		<label>노선명:</label> <select>
			<option>선택1</option>
			<option>선택2</option>
			<option>선택3</option>
		</select>
		<label>주유소명:</label> <input type="text" />
		<label><input type="checkbox"> 전기충전소</label> <label><input type="checkbox"> 수소충전소</label>

		<button class="btn btn-confirm">검색</button>
	</div>

	<table class="user_table">
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
			<tr>
				<td>강릉(강릉)</td>
				<td>033-648-9559</td>
				<td>1,574원</td>
				<td>1,439원</td>
				<td>1,117원</td>
				<td>O</td>
				<td>X</td>
			</tr>
			<tr>
				<td>강릉(강릉)</td>
				<td>033-648-9559</td>
				<td>1,574원</td>
				<td>1,439원</td>
				<td>1,117원</td>
				<td>O</td>
				<td>X</td>
			</tr>
			<tr>
				<td>강릉(강릉)</td>
				<td>033-648-9559</td>
				<td>1,574원</td>
				<td>1,439원</td>
				<td>1,117원</td>
				<td>O</td>
				<td>X</td>
			</tr>
			<tr>
				<td>강릉(강릉)</td>
				<td>033-648-9559</td>
				<td>1,574원</td>
				<td>1,439원</td>
				<td>1,117원</td>
				<td>O</td>
				<td>X</td>
			</tr>
			<tr>
				<td>강릉(강릉)</td>
				<td>033-648-9559</td>
				<td>1,574원</td>
				<td>1,439원</td>
				<td>1,117원</td>
				<td>O</td>
				<td>X</td>
			</tr>
			<tr>
				<td>강릉(강릉)</td>
				<td>033-648-9559</td>
				<td>1,574원</td>
				<td>1,439원</td>
				<td>1,117원</td>
				<td>O</td>
				<td>X</td>
			</tr>

		</tbody>
	</table>

	<div class="agent-container">
		<div class="agent-box">담당자 정보</div>
		<div class="agent-call">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;모두쉼 콜센터 : 02-1234-5678</div>
	</div>
	</div> <%-- End of container div --%>


	<div class="footer">
	<footer>
		<jsp:include page="../common/jsp/footer.jsp" />
	</footer>
	</div>
</body>

</html>