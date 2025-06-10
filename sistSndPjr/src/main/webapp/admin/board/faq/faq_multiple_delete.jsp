<%@page import="Faq.FaqService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Notice.NoticeService" %>
<%@ page import="AdminLogin.LoginResultDTO" %>
<%
    request.setCharacterEncoding("UTF-8");
    LoginResultDTO userData = (LoginResultDTO) session.getAttribute("userData");

    if (userData == null) {
        response.sendRedirect("../login/admin_login.jsp");
        return;
    }

    String[] selectedFaqs = request.getParameterValues("faq_nums");

    boolean allDeleted = true;
    FaqService faqService = new FaqService();

    int cnt = 0;
    if (selectedFaqs != null && selectedFaqs.length > 0) {
        for (String faqNumStr : selectedFaqs) {
            try {
                int faqNum = Integer.parseInt(faqNumStr);
                boolean deleted = faqService.deleteFaq(faqNum);
                if (deleted) {
                    cnt++;
                } else {
                    allDeleted = false;
                    break;
                }
            } catch (NumberFormatException e) {
                allDeleted = false;
                break;
            }
        }
    } else {
        allDeleted = false;
    }

    request.setAttribute("allDeleted", allDeleted);
    request.setAttribute("cnt", cnt);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 일괄 삭제</title>
    <script type="text/javascript">
        <c:choose>
            <c:when test="${allDeleted}">
                alert("FAQ가 성공적으로 삭제되었습니다.");
                location.href = "faq_board.jsp";
            </c:when>
            <c:otherwise>
                alert("FAQ 삭제에 실패했습니다. 다시 시도해주세요.");
                history.back();
            </c:otherwise>
        </c:choose>
    </script>
</head>
<body>
</body>
</html>
