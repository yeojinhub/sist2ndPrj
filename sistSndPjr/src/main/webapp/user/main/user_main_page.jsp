<%@page import="java.util.List"%>
<%@page import="user.notice.NoticeDTO"%>
<%@page import="user.notice.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="rDTO" class="user.util.RangeDTO" scope="page" />
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
        a {
			cursor: pointer; /* 손가락 모양의 커서 */
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
    	
    	$('#restarea').click(()=>{
			location.href = 'rest_area_facility.jsp';
    	});// click
    	
    	$('#favorite').click(()=>{
    		myFavorite();
    	});// click
    	
    	$('#question').click(()=>{
    		myQuestion();
    	});// click
    	
    	/* $('.notice').click(()=>{
			location.href = 'user_board.jsp';
    	});// click */
    	
    	$('.notice a').click(function(e) {
    	    e.preventDefault(); // 기본 클릭 이벤트 방지
    	    const notNum = $(this).closest('tr').data('num'); // 공지사항 번호 가져오기

    	    // AJAX 요청으로 디테일 페이지 로드
    	    $.ajax({
    	        url: 'user_board.jsp', // user_board.jsp로 요청
    	        method: 'GET',
    	        data: { 'not_num': notNum }, // 공지사항 번호 전달
    	        success: function(response) {
    	            // 성공적으로 받아온 내용을 #content에 표시
    	            $('#content').html(response);
    	        },
    	        error: function(xhr, status, error) {
    	            console.error('디테일 페이지 로드 오류:', status, error);
    	        }
    	    });
    	});
    	
    });
    
function myFavorite() {
	$('#hidden').val('favorite');
	$('#frmHidden').submit();
};

function myQuestion() {
	$('#hidden').val('question');
	$('#frmHidden').submit();
};


</script>
<%
NoticeService ns = new NoticeService(); 
List<NoticeDTO> NoticeList = ns.selectMainNotice(rDTO); 
pageContext.setAttribute("noticeList", ns.selectMainNotice(rDTO));
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
            	<i class="bi bi-bookmark-check book" onclick="location.href='rest_area_facility.jsp'"></i>
            	<h3 id="restarea">휴게소목록</h3>
            </div>
		 <div class="section section-yellow">
            	<i class="bi bi-star star" onclick="myFavorite()"></i>
            	<h3 id="favorite">즐겨찾기</h3>
            </div>
         <div class="section section-gray">
            	<i class="bi bi-chat-dots chat" id="aqwe" onclick="myQuestion()"></i>
            	<h3 id="question">문의하기</h3>
            </div>

			<div class="section section-red">

			<table>
			    <thead>
			        <tr>
			            <th><h3 id="sub-title3" class="notice">공지사항</h3></th>
			            <th><i class="bi bi-plus-square plus" onclick="location.href='user_board.jsp'"></i><br></th>
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
						<td>
						<a onclick="location.href='user_board.jsp?not_num=${nDTO.not_num}'" >
						    <c:choose>
					            <c:when test="${fn:length(nDTO.title) > 20}">
					                ${fn:substring(nDTO.title, 0, 20)}...
					            </c:when>
					            <c:otherwise>
					                <c:out value="${nDTO.title}" />
					            </c:otherwise>
					        </c:choose>
						</a> </td>
						<td><fmt:formatDate value="${ nDTO.input_date }" pattern="yyyy-MM-dd"/> </td>
					</tr>
					</c:forEach>
			    </tbody>
			</table>
            	
            </div> 
        </div>
    </div>
    <div id="hidden-form">
    	<form action="user_mypage.jsp" method="POST" id="frmHidden">
    		<input type="hidden" value="favorite" id="hidden" name="type"/>
    	</form>
    </div>
</main>


</div>
</body>
<footer>
    <jsp:include page="../common/jsp/footer.jsp"/>
</footer>
</html>