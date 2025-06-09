<%@page import="AdminLogin.LoginResultDTO"%>
<%@page import="Faq.FaqService"%>
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
    <script src="script.js"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
		
	<!-- Quill CSS -->
	<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css"
		rel="stylesheet">
	
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
                <h1>FAQ 작성</h1>
            </div>
            <form action="faq_write_process.jsp" method="post">
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
								<td colspan="4"><div id="quilleditor"></div><input type="hidden" name="content" id="content" /></td>
            				</tr>
            				<tr>
            				</tr>
            			</tbody>
            		</table>
            	</div>
            </div>
            
				<div class="button-detail">
					<button type="submit" class="btn btn-add">작성</button>
					<button class="btn btn-back"
						onclick="location.href='faq_board.jsp'">취소</button>
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
		    const title = document.querySelector('input[name="title"]').value.trim();
		    const content = quill.root.innerText.trim(); // 텍스트만 검사
		    if (title === "") {
		      alert("제목을 입력해주세요.");
		      return false;  // 폼 제출 막기
		    }
		    if (content === "") {
		      alert("내용을 입력해주세요.");
		      return false;
		    }
			document.getElementById("content").value=quill.root.innerHTML;
		}
	</script>
</body>
</html>
