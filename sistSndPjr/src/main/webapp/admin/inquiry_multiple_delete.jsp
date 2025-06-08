<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Inquiry.InquiryService" %>
<%@ page import="AdminLogin.LoginResultDTO" %>
<%
    request.setCharacterEncoding("UTF-8");
    LoginResultDTO userData = (LoginResultDTO) session.getAttribute("userData");

    if (userData == null) {
        response.sendRedirect("../login/admin_login.jsp");
        return;
    }

    String[] selectedInquiries = request.getParameterValues("inq_nums");

    boolean allDeleted = true;
    InquiryService inquiryService = new InquiryService();

    int cnt = 0;
    if (selectedInquiries != null && selectedInquiries.length > 0) {
        for (String inqNumStr : selectedInquiries) {
            try {
                int inqNum = Integer.parseInt(inqNumStr);
                boolean deleted = inquiryService.deleteInquiryAndAnswer(inqNum);
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
    request.setAttribute("deletedCount", cnt);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의사항 일괄 삭제</title>
    <script type="text/javascript">
        <c:choose>
            <c:when test="${allDeleted}">
                alert("문의사항이 성공적으로 삭제되었습니다.");
                location.href = "inquiries.jsp";
            </c:when>
            <c:otherwise>
                alert("문의사항 삭제에 실패했습니다. 다시 시도해주세요.");
                history.back();
            </c:otherwise>
        </c:choose>
    </script>
</head>
<body>
</body>
</html>
