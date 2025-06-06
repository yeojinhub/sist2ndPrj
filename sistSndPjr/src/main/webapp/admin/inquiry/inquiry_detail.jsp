<%@page import="AdminLogin.LoginResultDTO"%>
<jsp:useBean id="now" class="java.util.Date" />
<%@page import="Inquiry.AnswerDAO"%>
<%@page import="Inquiry.AnswerDTO"%>
<%@page import="Inquiry.AnswerService"%>
<%@page import="Inquiry.InquiryDTO"%>
<%@page import="Inquiry.InquiryService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/jsp/login_chk.jsp" %>
<%
    LoginResultDTO userData = (LoginResultDTO) session.getAttribute("userData");
%>
<%
    String inqNumStr = request.getParameter("inq_num");
    int inqNum = 0;
    
    if (inqNumStr != null && !inqNumStr.trim().isEmpty()) {
        try {
            inqNum = Integer.parseInt(inqNumStr);
        } catch (NumberFormatException e) {
            e.printStackTrace(); // 잘못된 파라미터 처리
        }
    }
    InquiryService service = new InquiryService();
    InquiryDTO inquiry = service.getInquiryOne(inqNum);

    request.setAttribute("inquiry", inquiry);
%>
<%
/* AnswerService answerService = AnswerService.getInstance();
AnswerDTO answer = answerService.getAnswerByInquiryNum(inqNum); */

AnswerDTO answer = AnswerDAO.getInstance().getAnswerByInquiryNum(inqNum);
request.setAttribute("answer", answer);

if (answer != null) {
    request.setAttribute("answer", answer);
}

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <link rel="stylesheet" href="../common/css/styles.css">
    <script src="/sistSndPjr/admin/script.js"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="/admin/common/jsp/admin_sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>문의 상세</h1>
            </div>
            <div class="content">
            	<div class="notice-div">
            	<form action="answer_write_process.jsp" method="post">
  				<input type="hidden" name="inq_num" value="${inquiry.inq_num}" />
    			<input type="hidden" name="answerWriter" value="${userData.name}" />
            		<table class="notice-table">
						<tbody>
						<tr>
							<td colspan="4">
							<div style="padding: 10px; background-color: #334b48; border-radius: 8px; font-weight: bold; font-size: 18px;text-align: left;color:#f0f0f0;">문의</div></td>
						</tr>
							<tr>
								<td class="tdColumn">작성자</td>
								<td><input type="text" class="input-style" value="${inquiry.name}" readonly /></td>
								<td class="tdColumn">작성일</td>
								<td><input type="text" class="input-style" value="${inquiry.input_date}" readonly /></td>
							</tr>
							<tr>
								<td>제목</td>
								<td colspan="3"><input type="text" class="input-style title" name="title" value="${inquiry.title}" readonly />
							</tr>
							<tr>
								<td>내용</td>
								<td colspan="3"><textarea class="content" readonly>${inquiry.content}</textarea></td>
        						
							</tr>
							</tbody>
							<tbody>
							<tr>
							<td colspan="4">
							    <div style="padding: 10px; background-color: #334b48; border-radius: 8px; font-weight: bold; font-size: 18px;text-align: left;color:#f0f0f0;">답변</div></td>
							</tr>
							<c:if test="${not empty answer}">
							    <tr>
							        <td class="tdColumn">작성자</td>
							        <td><input type="text" class="input-style" value="${answer.name}" readonly /></td>
							        <td class="tdColumn">작성일</td>
							        <td><input type="text" class="input-style"
							                   value="<fmt:formatDate value='${answer.input_date}' pattern='yyyy-MM-dd'/>" readonly /></td>
							    </tr>
							</c:if>
							
							<c:if test="${empty answer}">
							    <tr>
							        <td class="tdColumn">작성자</td>
							        <td><input type="text" class="input-style" value="${userData.name}" readonly /></td>
							        <td class="tdColumn">작성일</td>
							        <td><input type="text" class="input-style"
							                   value="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>" readonly /></td>
							    </tr>
							</c:if>
							
							<tr>
							    <td>답변</td>
							    <td colspan="3">
							        <c:choose>
							            <c:when test="${not empty answer}">
							                <textarea class="content" name="answerContent" readonly="readonly">${answer.content}</textarea>
							            </c:when>
							            <c:otherwise>
							                <textarea class="content" name="answerContent"></textarea>
							            </c:otherwise>
							        </c:choose>
							    </td>
							</tr>
						</tbody>
					</table>

			<div class="button-detail">
<%--			    <form action="answer_write_process.jsp" method="post">
 			        <input type="hidden" name="inq_num" value="${inquiry.inq_num}" />
			        <input type="hidden" name="answerWriter" value="${sessionScope.loginAdminName}" />
			        <input type="hidden" name="answerContent" id="hiddenAnswerContent" /> --%>
			        <button type="submit" class="btn btn-edit">저장</button>
			        <button type="button" class="btn btn-back" onclick="location.href='inquiries.jsp'">취소</button>
			 </form>
			 
				<form action="inquiries_delete_process.jsp" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
				    <input type="hidden" name="inq_num" value="${inquiry.inq_num}" />
				    <button type="submit" class="btn btn-delete">삭제</button>
				</form>
				</div>
			</div>
			</div>

		
		    </div>
		    </div>
		</body>
		</html>
