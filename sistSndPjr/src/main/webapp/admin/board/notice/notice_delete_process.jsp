<%@page import="Notice.NoticeService"%>
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

String[] noticeNums = request.getParameterValues("noticeCheck");
String singleNoticeNum = request.getParameter("not_num");

NoticeService service = new NoticeService();
boolean allDeleted = true;

if (noticeNums != null) {
    for (String numStr : noticeNums) {
        try {
            int num = Integer.parseInt(numStr);
            if (!service.deleteNotice(num)) {
                allDeleted = false;
            }
        } catch (NumberFormatException e) {
            allDeleted = false;
        }
    }
} else if (singleNoticeNum != null) {
    try {
        int num = Integer.parseInt(singleNoticeNum);
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
    <title>공지사항 삭제결과</title>
    <script type="text/javascript">
        <c:choose>
            <c:when test="${deleteFlag}">
                alert("글삭제 완료");
                location.href = "notice_board.jsp";
            </c:when>
            <c:otherwise>
                alert("글삭제 실패. 정상적으로 실행되지 않았습니다.");
                history.back();
            </c:otherwise>
        </c:choose>
    </script>
</head>
<body>
</body>
</html>

