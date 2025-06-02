<%@page import="AdminLogin.LoginResultDTO"%>
<%@page import="Notice.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    LoginResultDTO userData = (LoginResultDTO) session.getAttribute("userData");
%>
<!DOCTYPE html>

<html>

<head>
<meta charset="UTF-8">
<title>관리자 대시보드</title>
<link rel="stylesheet" href="../common/css/styles.css">

<!-- Quill CSS -->
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css"
	rel="stylesheet">

<style>
#quilleditor {
	background-color: #fff !important;
	border: 1px solid #ccc;
	padding: 10px;
}

.ql-toolbar {
	background-color: #ECECEC !important;
	border: 1px solid #ccc;
}

.ql-container {
	background-color: #fff !important;
	height: 500px;
	font-size: 16px;
}

/* checkbox-container */
.radio-container {
	display: flex; /* Flexbox로 설정 */
	justify-content: center; /* 한 줄로 가운데 정렬 */
	align-items: center; /* 세로 가운데 정렬 */
	gap: 80px; /* 체크박스 간의 간격 */
	width: 100%; /* 부모 셀 너비 100% */
}

/* checkbox*/
.radio-container label {
	font-size: 16px;
	cursor: pointer;
	white-space: nowrap;
}

.radio-container input[type="radio"] {
	margin-right: 15px;
}

/* input  */
.input-style {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	background-color: #f9f9f9;
	font-size: 16px;
	color: #333;
	transition: all 0.3s ease;
}

.input-style:focus {
	border-color: #4CAF50;
	background-color: #fff;
	outline: none;
}

/* 제목 입력창 스타일 */
.title {
	width: 100%;
}
</style>

<!-- Quill JS -->
<script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>

</head>

<body>
	<div class="container">
		<!-- Sidebar -->
		<jsp:include page="admin_sidebar.jsp" />

		<!-- Main Content -->
		<div class="main-content">
			<div class="header">
				<h1>공지사항 작성</h1>
			</div>
			<form action="notice_write_process.jsp" method="post">
				<div class="content">
					<div class="notice-div">
						<table class="notice-table">
							<tbody>
								<tr>
									<td class="tdColumn">작성자</td>
									<td><input type="text" class="input-style" readonly value="<c:out value='<%= userData.getName() %>' />" /></td>
									<td class="tdColumn">작성일</td>
									<td><input type="text" class="input-style" readonly value="<fmt:formatDate value='<%=new java.util.Date()%>' pattern='yyyy-MM-dd' />" /></td>
								</tr>
								<tr>
									<td>제목</td>
									<td colspan="3"><input type="text" class="input-style title"  name="title" placeholder="제목을 입력하세요" /></td>
								</tr>
								<tr>
                                     <td colspan="4">
                                        <div class="radio-container" style="border:1px solid #ccc; padding: 10px;">
                                            <label><input type="radio" name="status_type" value="공지" <c:if test="${notice.status_type=='공지'}">checked</c:if> /> 공지</label>
                                            <label><input type="radio" name="status_type" value="미공지" <c:if test="${notice.status_type=='미공지'}">checked</c:if>/> 미공지</label>
                                        </div>
                                    </td>
								</tr>
								<tr>
									<td colspan="4"><div id="quilleditor"></div><input type="hidden" name="content" id="content" /></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="button-detail">
					<button type="submit" class="btn btn-add">작성</button>
					<button class="btn btn-back"
						onclick="location.href='notice_board.jsp'">취소</button>
				</div>
			</form>
		</div>
	</div>

	<script>
		var quill = new Quill('#quilleditor', {
			theme : 'snow',
			placeholder : '내용을 입력하세요.',
			modules : {
				toolbar : [ [ 
					{'header' : '1'},{'header' : '2'},{'font' : []} ],
					[ {'list' : 'ordered'},{'list' : 'bullet'} ],
					[ 'bold', 'italic', 'underline' ], [ 'link', 'image' ],
					[ {'align' : []} ],[ 'clean' ]
				]}
		});
	</script>
	<script>
		document.querySelector("form").onsubmit=function(){
			document.getElementById("content").value=quill.root.innerHTML;
		}
	</script>
</body>
</html>
