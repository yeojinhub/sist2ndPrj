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

    String[] selectedNotices = request.getParameterValues("not_nums");

    boolean allDeleted = true;
    NoticeService noticeService = new NoticeService();

    int cnt = 0;
    if (selectedNotices != null && selectedNotices.length > 0) {
        for (String notNumStr : selectedNotices) {
            try {
                int notNum = Integer.parseInt(notNumStr);
                boolean deleted = noticeService.deleteNotice(notNum);
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
    <title>공지사항 일괄 삭제</title>
    <script type="text/javascript">
        <c:choose>
            <c:when test="${allDeleted}">
                alert("공지사항이 성공적으로 삭제되었습니다.");
                location.href = "notice_board.jsp";
            </c:when>
            <c:otherwise>
                alert("공지사항 삭제에 실패했습니다. 다시 시도해주세요.");
                history.back();
            </c:otherwise>
        </c:choose>
    </script>
</head>
<body>
</body>
</html>
