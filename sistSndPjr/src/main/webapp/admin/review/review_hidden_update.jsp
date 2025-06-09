<%@page import="Review.ReviewService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="AdminLogin.LoginResultDTO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
    LoginResultDTO userData = (LoginResultDTO)session.getAttribute("userData");
	
    if (userData == null) {
        response.sendRedirect("../login/admin_login.jsp");
        return;
    }
%>
<jsp:useBean id="rDTO" class="Review.ReviewDTO" scope="request" />
<jsp:setProperty name="rDTO" property="*" />
<%
int revNum = Integer.parseInt(request.getParameter("rev_num"));
rDTO.setRev_num(revNum);

boolean updateFlag = false;
ReviewService reviewService = new ReviewService();
updateFlag = reviewService.hideReview(revNum);
request.setAttribute("updateFlag", updateFlag);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hidden 업데이트 수정 결과</title>
    <script type="text/javascript">
        <c:choose>
            <c:when test="${updateFlag}">
                alert("Hidden 업데이트 완료");
                location.href="reviews.jsp";
            </c:when>
            <c:otherwise>
                alert("Hidden 업데이트 실패. 정상적으로 실행되지 않았습니다.");
                history.back();
            </c:otherwise>
        </c:choose>
    </script>
</head>
<body>
</body>
</html>
