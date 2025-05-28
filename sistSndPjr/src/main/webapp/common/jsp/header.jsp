<%@page import="DTO.LoginDTO"%>
<%@page import="kr.co.sist.cipher.DataDecryption"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="헤더"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
boolean loginCheckFlag = false;

String name = "";

if (session.getAttribute("userData") != null) {
	loginCheckFlag = true;
	
	String myKey = "asdf1234asdf1234";
	DataDecryption dd = new DataDecryption(myKey);
	
	LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");

	name = dd.decrypt(lDTO.getName());
} // end if

pageContext.setAttribute("loginCheck", loginCheckFlag);
pageContext.setAttribute("name", name);
%>
<style>
.login_menu a.no-hover:hover {
    color: #444 !important;             /* 원래 색상 유지 */
    font-weight: 500 !important;        /* 원래 굵기 유지 */
}

.login_menu a.no-hover::after {
    width: 0 !important;                /* 밑줄 애니메이션 제거 */
    background-color: transparent !important; /* 밑줄 색 제거 */
}
</style>
<div class="headerTop">
	<div class="header_content main-wrapper">
		<h5 class="logo" title="모두쉼로고">
			<a href="http://localhost/sistSndPjr/user/user_main_page.jsp"><img
				src="http://localhost/sistSndPjr/common/images/logo251.png" alt=""
				class="logo-img"></a>
		</h5>
		<div class="member">
			<ul class="login_menu center">
				<li class="<c:if test='${menu eq "facility"}'>active</c:if>"><a
					href="http://localhost/sistSndPjr/user/rest_area_facility.jsp">휴게소
						편의시설 정보</a></li>
				<li class="<c:if test='${menu eq "gas"}'>active</c:if>"><a
					href="http://localhost/sistSndPjr/user/gas_station.jsp">노선별주유소</a>
				</li>
				<li class="<c:if test='${menu eq "board"}'>active</c:if>"><a
					href="http://localhost/sistSndPjr/user/user_board.jsp">게시판</a></li>
				<li class="<c:if test='${menu eq "mypage"}'>active</c:if>"><a
					href="http://localhost/sistSndPjr/user/user_mypage.jsp" id="mypage">마이페이지</a></li>
			</ul>
			<ul class="login_menu right">
				<c:choose>
					<c:when test="${loginCheck }">
						<li><a href="http://localhost/sistSndPjr/user/user_mypage.jsp" class="no-hover"><span style="color: #0000FF;">${name }</span>님</a></li>
						<li><a href="../login/logout.jsp">로그아웃</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="../login/register.jsp">회원가입</a></li>
						<li><a href="../login/login.jsp">로그인</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>
</div>