<%@page import="user.mypage.info.InfoService"%>
<%@page import="user.account.login.LoginDTO"%>
<%@page import="kr.co.sist.cipher.DataEncryption"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
    info=""%>
<%
request.setCharacterEncoding("UTF-8");

//세션에서 사용자 정보 가져오기
LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");

//입력값 받기
String tel = request.getParameter("tel");
String email = lDTO.getUser_email();

//필수값 체크
if (tel == null || tel.equals("")) {
    out.println("<script>alert('입력값이 유효하지 않습니다.'); history.back();</script>");
    return;
}

// 암호화
DataEncryption de = new DataEncryption("asdf1234asdf1234");
String encryptedTel = de.encrypt(tel);

InfoService is = new InfoService();


try {
   	is.changeAccount(encryptedTel, email);

    // 세션 값도 업데이트
    lDTO.setTel(encryptedTel);
    session.setAttribute("userData", lDTO);

    // 마이페이지로 리다이렉트
    response.sendRedirect("../../../main/user_mypage.jsp");

} catch (Exception e) {
    e.printStackTrace();
    out.println("<script>alert('오류가 발생했습니다. 관리자에게 문의하세요.'); history.back();</script>");
}
%>