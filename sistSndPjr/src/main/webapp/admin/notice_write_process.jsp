<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Notice.NoticeService" %>
<%@ page import="Notice.NoticeDTO" %>
<%@ page import="AdminLogin.LoginResultDTO" %>
<% request.setCharacterEncoding("UTF-8");%>
<% 
   LoginResultDTO userData = (LoginResultDTO)session.getAttribute("userData");
   if (userData == null) {
       response.sendRedirect("../login/admin_login.jsp");
       return;
   }
%>
<jsp:useBean id="ntDTO" class="Notice.NoticeDTO" scope="request" />
<jsp:setProperty name="ntDTO" property="*" />
<% 

    ntDTO.setName(userData.getName());
    
    NoticeService noticeService = new NoticeService();
    int accNum = noticeService.getAccNumByAdmId(userData.getAdm_id());
    System.out.println("ACC_NUM: " + accNum);
    
    if (accNum > 0) {
        ntDTO.setAcc_num(accNum);
        boolean writeFlag = noticeService.writeNotice(ntDTO);
        System.out.println("Write Flag: " + writeFlag);
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
    <title>공지사항 작성 결과</title>
    <script type="text/javascript">
        <c:choose>
            <c:when test="${writeFlag}">
                alert("글쓰기 완료");
                location.href="notice_board.jsp";
            </c:when>
            <c:otherwise>
                alert("글쓰기 실패. 정상적으로 실행되지 않았습니다..");
                history.back();
            </c:otherwise>
        </c:choose>
    </script>
</head>
<body>
</body>
</html>