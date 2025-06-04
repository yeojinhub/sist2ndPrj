<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Inquiry.InquiryService" %>
<%@ page import="AdminLogin.LoginResultDTO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
    LoginResultDTO userData = (LoginResultDTO)session.getAttribute("userData");
	
    if (userData == null) {
        response.sendRedirect("../login/admin_login.jsp");
        return;
    }
%>
<jsp:useBean id="iDTO" class="Inquiry.InquiryDTO" scope="request" />
<jsp:setProperty name="iDTO" property="*" />
<%

String inqNumStr = request.getParameter("inq_num");
int inqNum = 0;

if (inqNumStr != null && !inqNumStr.trim().isEmpty()) {
    inqNum = Integer.parseInt(inqNumStr);
}

InquiryService service = new InquiryService();
boolean deleteSuccess = service.deleteInquiryAndAnswer(inqNum);

request.setAttribute("deleteFlag", deleteSuccess);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><c:out value="${site_name}" /></title>
    <c:import url="${url}/common/jsp/external_file.jsp" />
    <style type="text/css">
        #container { min-height: 600px; margin-top: 30px; margin-left: 20px; }
    </style>
    <title><c:out value="${site.name}" /></title>
    <script type="text/javascript">
        <c:choose>
            <c:when test="${deleteFlag}">
                alert("글삭제 완료");
                location.href="inquiries.jsp";
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
