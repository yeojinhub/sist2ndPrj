<%@page import="DTO.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@page import="Notice.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="rDTO" class="DTO.RangeDTO" scope="page" />
<jsp:setProperty name="rDTO" property="*" />
<%
    request.setAttribute("menu", "home");
%>    
<!DOCTYPE html>
<html>	
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <jsp:include page="../common/jsp/external_file.jsp"/>

<style>

table {
            border-collapse: collapse;
            width: 90%;
            margin: 20px auto;
            font-family: Arial, sans-serif;
            margin-top: 30px;
            color: #fff;
        }

        th, td {
            padding: 10px 15px;
            border-bottom: 2px solid #fff; /* 밑줄 */
            text-align: left;
        }

        /* 밑줄만 있고 테두리 없음 */
        table, th, td {
            border: none;
        }

        /* td 밑에만 밑줄 */
        td {
            border-bottom: 2px solid #fff;
        }

</style>

<script>
    $(function(){
    	//여기도 있어야 호버된 상태가 유지됨
        $(".login_menu.center li a").click(function(e) {

            // 모든 항목에서 active 제거
            $(".login_menu.center li").removeClass("active");
            // 클릭된 항목에 active 추가
            $(this).parent().addClass("active");
          });
    });
</script>
<%
/* NoticeService ns = new NoticeService(); 
List<NoticeDTO> NoticeList = ns.selectMainNotice(rDTO); 
pageContext.setAttribute("noticeList", ns.selectMainNotice(rDTO)); */
%>

</head>
<body>
 <div class="page-wrapper">
<header>
    <jsp:include page="../common/jsp/header.jsp"/>
</header>

<main class="main-content">
    <div class="main-wrapper">
        <img id="main-image" src="../common/images/main_pic.png" />

        <div id="color-sections">
            <div class="section section-blue">
            	<i class="bi bi-bookmark-check book"></i>
            	<h3 id="sub-title1">휴게소목록</h3>
            </div>
		 <div class="section section-yellow">
            	<i class="bi bi-star star"></i>
            	<h3 id="sub-title2">즐겨찾기</h3>
            </div>
         <div class="section section-gray">
            	<i class="bi bi-chat-dots chat" id="aqwe"></i>
            	<h3 id="sub-title2">문의하기</h3>
            </div>

			<div class="section section-red">
            	<!-- <h3 id="sub-title3">공지사항</h3>
            	<i class="bi bi-plus-square plus"></i><br> -->

			<table>
			    <thead>
			        <tr>
			            <th><h3 id="sub-title3">공지사항</h3></th>
			            <th><i class="bi bi-plus-square plus"></i><br></th>
			        </tr>
			    </thead>
			    <tbody>
			        <c:if test="${ empty noticeList }">
						<tr>
							<td colspan="2">공지사항이 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="nDTO" items="${ noticeList }" varStatus="i">
					<tr data-num="${nDTO.not_num}">
						<td><c:out value="${ nDTO.title }"/> </td>
						<td><fmt:formatDate value="${ nDTO.input_date }" pattern="yyyy-MM-dd EEEE HH:mm"/> </td>
					</tr>
					</c:forEach>
			    </tbody>
			</table>
            	
            </div> 
        </div>
    </div>
</main>


</div>
</body>
<footer>
    <jsp:include page="../common/jsp/footer.jsp"/>
</footer>
</html>