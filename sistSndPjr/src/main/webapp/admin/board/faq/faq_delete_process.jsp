<%@page import="Faq.FaqService"%>
<%@ page import="AdminLogin.LoginResultDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8");

// 로그인 확인
LoginResultDTO userData = (LoginResultDTO) session.getAttribute("userData");
if (userData == null) {
    response.sendRedirect("../login/admin_login.jsp");
    return;
}

// 삭제할 번호 확인 (다중/단일 모두 처리)
String[] faqNums = request.getParameterValues("faqCheck");
String singleFaqNum = request.getParameter("faq_num");

FaqService service = new FaqService();
boolean allDeleted = true;

if (faqNums != null) {
    for (String numStr : faqNums) {
        try {
            int num = Integer.parseInt(numStr);
            if (!service.deleteNotice(num)) {
                allDeleted = false;
            }
        } catch (NumberFormatException e) {
            allDeleted = false;
        }
    }
} else if (singleFaqNum != null) {
    try {
        int num = Integer.parseInt(singleFaqNum);
        allDeleted = service.deleteNotice(num);
    } catch (NumberFormatException e) {
        allDeleted = false;
    }
} else {
    allDeleted = false;
}

request.setAttribute("deleteFlag", allDeleted);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FAQ 삭제결과</title>
    <script type="text/javascript">
        <c:choose>
            <c:when test="${deleteFlag}">
                alert("FAQ 삭제 완료");
                location.href = "faq_board.jsp";
            </c:when>
            <c:otherwise>
                alert("FAQ 삭제 실패 또는 잘못된 요청입니다.");
                history.back();
            </c:otherwise>
        </c:choose>
    </script>
</head>
<body>
</body>
</html>

