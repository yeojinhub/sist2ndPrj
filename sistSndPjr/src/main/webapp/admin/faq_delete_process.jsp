<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Faq.FaqService" %>
<%@ page import="Faq.FaqDTO" %>
<%@ page import="AdminLogin.LoginResultDTO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
    LoginResultDTO userData = (LoginResultDTO)session.getAttribute("userData");
	
    if (userData == null) {
        response.sendRedirect("../login/admin_login.jsp");
        return;
    }
%>
<jsp:useBean id="fDTO" class="Faq.FaqDTO" scope="request" />
<jsp:setProperty name="fDTO" property="*" />
<%
	int faqNum=0;

	faqNum=Integer.parseInt(request.getParameter("faq_num"));
	
	boolean deleteFlag=false;
	FaqService faqService=new FaqService();
	deleteFlag=faqService.deleteNotice(faqNum);
	request.setAttribute("deleteFlag", deleteFlag);
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
                alert("faq글삭제 완료");
                location.href="faq_board.jsp";
            </c:when>
            <c:otherwise>
                alert("faq글삭제 실패. 정상적으로 실행되지 않았습니다.");
                history.back();
            </c:otherwise>
        </c:choose>
    </script>
</head>
<body>
</body>
</html>
