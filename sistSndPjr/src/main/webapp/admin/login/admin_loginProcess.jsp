<%@page import="AdminLogin.LoginDTO"%>
<%@page import="AdminLogin.LoginService"%>
<%@page import="AdminLogin.LoginResultDTO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String admin_id = request.getParameter("admin_id");
    String admin_pass = request.getParameter("admin_pass");

    boolean loginFlag = false;
    boolean withdraw = false;

    LoginDTO lDTO = new LoginDTO();
    lDTO.setAdm_id(admin_id);
    lDTO.setPass(admin_pass);

    LoginService loginService = new LoginService();

    try {
        loginFlag = loginService.loginProcess(lDTO, session);//이거 탔는데 왜 출력이 안되는 거지?
        System.out.println("Login result: " + loginFlag);
        
        // 세션에서 로그인 결과 가져오기- 이게 안되는 거어ㅕㅆ저ㅏ어리ㅏㅇ너닺아ㅣ러ㅣ
        LoginResultDTO loginResultDTO = (LoginResultDTO) session.getAttribute("userData");
        if (loginResultDTO != null) {
            withdraw = loginResultDTO.isWithdraw();
            System.out.println("Withdraw status: " + withdraw);
        }

        // JSON 형식으로 응답 - 왜 너는 되냐
        response.setContentType("application/json; charset=UTF-8");
        String jsonResponse = "{\"loginFlag\":" + loginFlag + ", \"withdraw\":" + withdraw + "}";
        out.print(jsonResponse);
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("Error occurred: " + e.getMessage());
    }
%>
