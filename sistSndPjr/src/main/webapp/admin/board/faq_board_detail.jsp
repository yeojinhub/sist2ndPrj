<%@page import="Board.FaqDTO"%>
<%@page import="java.util.List"%>
<%@page import="Board.FaqService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String paramNum=request.getParameter("faq_num");

System.out.println("list에서 받아온 faq 번호 : "+paramNum);

int num=0;
try{
num=Integer.parseInt(paramNum);
}catch (NumberFormatException nfe){
	response.sendRedirect("faq_account_manage.jsp");
}//end catch

FaqService faqService = new FaqService();
request.setAttribute("faqDTO", faqService.searchOneFaq(num));
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
<script src="/sistSndPjr/admin/common/js/faq_board_manage.js"></script>

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

			<form name="editFrm" id="editFrm" method="post">
				<div class="content">
					<div class="notice-div">
						<input type="hidden" name="num" id="num"
							value="${ faqDTO.faq_num }" />
						<table class="notice-table">
							<tbody>
								<tr>
									<td class="tdColumn">작성자</td>
									<td><textarea class="one-line">
            							<c:out value="${ faqDTO.name }" />
            						</textarea></td>
									<td class="tdColumn">작성일</td>
									<td><textarea class="one-line">
            						<fmt:formatDate value="${ faqDTO.input_date }"
												pattern="yyyy-MM-dd" />
            						</textarea></td>
								</tr>
								<tr>
									<td>제목</td>
									<td colspan="3"><textarea class="title">
            						<c:out value="${ faqDTO.title }" />
            						</textarea></td>
								</tr>
								<tr>
									<td>내용</td>
									<td colspan="3"><textarea class="content">
            						<c:out value="${ faqDTO.content }" />
            						</textarea></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="button-detail">
					<input type="button" class="btn btn-edit" id="btnFaqModify" value="수정" />
					<input type="button" class="btn btn-remove" id="btnFaqRemove" value="삭제" />
					<input type="button" class="btn btn-back" id="btnFaqBack" value="뒤로" />
				</div>
			</form>
		</div>
    </div>
</body>
</html>
