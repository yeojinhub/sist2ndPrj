<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info=""%>
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
    	
    	$('.notice').click(()=>{
			location.href = 'user_board.jsp';
    	});// click
	
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
            	<h3 id="sub-title3" class="notice">공지사항</h3><i class="bi bi-plus-square plus" onclick="location.href='user_board.jsp'"></i>
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