<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" info="헤더"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="../common/css/style_mypage.css">
<div class="headerTop">
    <div class="header_content main-wrapper">
        <h5 class="logo" title="모두쉼로고">
            <a href="http://localhost/sistSndPjr/user/user_main_page.jsp"><img src="http://localhost/sistSndPjr/common/images/logo251.png" alt="" class="logo-img"></a>
        </h5>
        <div class="member">
            <ul class="login_menu center">
                <li class="<c:if test='${menu eq "facility"}'>active</c:if>">
                    <a href="http://localhost/sistSndPjr/user/rest_area_facility.jsp">휴게소 편의시설 정보</a>
                </li>
                <li class="<c:if test='${menu eq "gas"}'>active</c:if>">
                    <a href="http://localhost/sistSndPjr/user/gas_station.jsp">노선별주유소</a>
                </li>
                <li class="<c:if test='${menu eq "board"}'>active</c:if>">
                    <a href="http://localhost/sistSndPjr/user/user_board.jsp">게시판</a>
                </li>
                <li class="<c:if test='${menu eq "mypage"}'>active</c:if>">
                    <a href="http://localhost/sistSndPjr/user/user_mypage.jsp">마이페이지</a>
                </li>
            </ul>
            <ul class="login_menu right"> 
                <li><a href="../login/register.jsp">회원가입</a></li>
                <li><a href="../login/login.jsp">로그인</a></li>
            </ul>
        </div>
    </div>
</div>