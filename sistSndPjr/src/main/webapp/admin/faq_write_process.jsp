<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Faq.FaqService" %>
<%@ page import="Faq.FaqDTO" %>
<%@ page import="AdminLogin.LoginResultDTO" %>
<% request.setCharacterEncoding("UTF-8");%>
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

    fDTO.setName(userData.getName());
    
	FaqService faqService = new FaqService();
    int accNum = faqService.getAccNumByAdmId(userData.getAdm_id());
    System.out.println("ACC_NUM: " + accNum);
    
    if (accNum > 0) {
        fDTO.setAcc_num(accNum);
        boolean writeFlag = faqService.writeFaq(fDTO);
        System.out.println("faq-Write Flag: " + writeFlag);
        request.setAttribute("writeFlag", writeFlag);
    } else {
        System.out.println("ACC_NUM을 찾을 수 없습니다.");
        request.setAttribute("writeFlag", false);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FAQ 작성 결과</title>
    <script type="text/javascript">
        <c:choose>
            <c:when test="${writeFlag}">
                alert("FAQ글쓰기 완료");
                location.href="faq_board.jsp";
            </c:when>
            <c:otherwise>
                alert("FAQ글쓰기 실패. 정상적으로 실행되지 않았습니다.");
                history.back();
            </c:otherwise>
        </c:choose>
    </script>
</head>
<body>
</body>
</html>