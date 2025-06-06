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
	fDTO.setFaq_num(faqNum);
	
	boolean updateFlag=false;
	FaqService faqService=new FaqService();
	updateFlag=faqService.updatFaq(fDTO);

	request.setAttribute("updateFlag", updateFlag);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FAQ 수정 결과</title>
    <script type="text/javascript">
        <c:choose>
            <c:when test="${updateFlag}">
                alert("FAQ글수정 완료");
                location.href="faq_board.jsp";
            </c:when>
            <c:otherwise>
                alert("FAQ글수정 실패. 정상적으로 실행되지 않았습니다.");
                history.back();
            </c:otherwise>
        </c:choose>
    </script>
</head>
</html>
