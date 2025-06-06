<%@page import="Faq.FaqService"%>
<%@ page import="AdminLogin.LoginResultDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
request.setCharacterEncoding("UTF-8");
LoginResultDTO userData = (LoginResultDTO) session.getAttribute("userData");
if (userData == null) {
    response.sendRedirect("../login/admin_login.jsp");
    return;
}

String faqNumStr = request.getParameter("faq_num");
int faqNum = 0;
if (faqNumStr != null && !faqNumStr.trim().isEmpty()) {
    faqNum = Integer.parseInt(faqNumStr);
}

FaqService service = new FaqService();
boolean deleteSuccess = service.deleteNotice(faqNum);
request.setAttribute("deleteFlag", deleteSuccess);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FAQ 작성 결과</title>
	<script type="text/javascript">
	    <c:choose>
	        <c:when test="${deleteFlag}">
	            alert("FAQ글삭제 완료");
	            location.href="faq_board.jsp";
	        </c:when>
	        <c:otherwise>
	            alert("FAQ글삭제 실패. 정상적으로 실행되지 않았습니다.");
	            history.back();
	        </c:otherwise>
	    </c:choose>
	</script>
</head>
<body>
</body>
</html>