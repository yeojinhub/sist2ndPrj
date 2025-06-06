<%@page import="Faq.FaqDTO"%>
<%@page import="Faq.FaqService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../common/jsp/login_chk.jsp" %>
<%
int faqNum = Integer.parseInt(request.getParameter("faq_num"));
FaqService service = new FaqService();
FaqDTO fDTO = service.getNoticeOne(faqNum);
request.setAttribute("fDTO", fDTO);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 대시보드</title>
<link rel="stylesheet" href="../../common/css/styles.css">
<script src="/sistSndPjr/admin/script.js"></script>
<!-- Font Awesome for icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
		<jsp:include page="/admin/common/jsp/admin_sidebar.jsp" />

		<!-- Main Content -->
		<div class="main-content">
			<div class="header">
				<h1>FAQ 수정</h1>
			</div>
			<form action="faq_update_process.jsp" method="post"
				onsubmit="return beforeSubmit();">
				<input type="hidden" name="faq_num" value="${fDTO.faq_num}" /> <input
					type="hidden" name="content" id="content" />

				<div class="content">
					<div class="notice-div">
						<table class="notice-table">
							<tbody>
								<tr>
									<td class="tdColumn">작성자</td>
									<td><input type="text" class="input-style" value="${fDTO.name}" readonly /></td>
									<td class="tdColumn">작성일</td>
									<td><input type="text" class="input-style" value="${fDTO.input_date}" readonly /></td>
								</tr>
								<tr>
									<td>제목</td>
									<td colspan="3"><input type="text" class="input-style title" name="title" value="${fDTO.title}" required />
								</tr>
								<tr>
									<td colspan="4">
										<div id="quilleditor">${fDTO.content}</div>
									</td>
								</tr>
								<tr>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="button-detail">
		<%-- 	    <form action="faq_update_process.jsp" method="post" onsubmit="return beforeSubmit();" >
			        <input type="hidden" name="faq_num" value="${fDTO.faq_num}" />
			        <input type="hidden" name="content" id="content" /> --%>
			        <button class="btn btn-edit" type="submit">수정</button>
			        <button class="btn btn-back" type="button" onclick="location.href='faq_board.jsp'">취소</button>
			</form>
			
			    <form action="faq_delete_process.jsp" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
			        <input type="hidden" name="faq_num" value="${fDTO.faq_num}" />
			        <button type="submit" class="btn btn-delete">삭제</button>
			    </form>
				</div>
		</div>
	</div>
	
	    <script>
        var quill = new Quill('#quilleditor', {
            theme: 'snow',
            placeholder: '내용을 입력하세요.',
            modules: {
                toolbar: [
                    [{'header': '1'}, {'header': '2'}, {'font': []}],
                    [{'list': 'ordered'}, {'list': 'bullet'}],
                    ['bold', 'italic', 'underline'],
                    ['link', 'image'],
                    [{'align': []}],
                    ['clean']
                ]
            }
        });
        function beforeSubmit() {
            document.getElementById("content").value = quill.root.innerHTML;
            return confirm("정말 수정하시겠습니까?");
        }
    </script>
</body>
</html>
