<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info=""%>
<%
String id = request.getParameter("id");

String name = "알 수 없음";
String direction = "";

if ("101".equals(id)) {
    name = "강릉휴게소";
    direction = "강릉방향";
} else if ("102".equals(id)) {
    name = "강릉휴게소";
    direction = "인천방향";
} else if ("103".equals(id)) {
    name = "강천산휴게소";
    direction = "광주방향";
} else if ("104".equals(id)) {
    name = "강천산휴게소";
    direction = "대구방향";
} else if ("105".equals(id)) {
    name = "거창휴게소";
    direction = "광주방향";
} else if ("106".equals(id)) {
    name = "거창휴게소";
    direction = "대구방향";
} else if ("107".equals(id)) {
    name = "건천휴게소";
    direction = "부산방향";
} else if ("108".equals(id)) {
    name = "건천휴게소";
    direction = "서울방향";
} else if ("109".equals(id)) {
    name = "경산휴게소";
    direction = "서울방향";
} else if ("110".equals(id)) {
    name = "경주휴게소";
    direction = "부산방향";
}
%>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>휴게소 편의시설 정보</title>
    <jsp:include page="../common/jsp/external_file.jsp"/>
<style>

</style>

<script>
$(function(){
	// 페이지 최초 로딩 시
    $("#tabContent").load("../common/component/restarea/rest_area_info.jsp");

    // 탭 클릭 시
    $(".tab-btn").click(function () {
      $(".tab-btn").removeClass("active");
      $(this).addClass("active");

      const tabName = $(this).data("tab");
      let file = "";
      if (tabName === "info") file = "../common/component/restarea/rest_area_info.jsp";
      else if (tabName === "food") file = "../common/component/restarea/rest_area_food.jsp";
      else if (tabName === "review") file = "../common/component/restarea/rest_area_review.jsp";

      $("#tabContent").load(file);
    });    	 
});
</script>
</head>
<body>
<header>
<jsp:include page="../common/jsp/header.jsp" />
</header>
<div class="container" style="display: flex; flex-direction: column; height: auto; min-height: 100vh;">

<div><hr class="line_blue" style="text-align: center;" /></div>

<div>
  <h2>
    <span style="font-size:40px;">휴게소/영업소_</span>
    <span style="font-size:30px;">휴게소</span>
  </h2>
</div>

<hr class="rest-title-divider">

<div class="rest-title-row">
  <h2 class="rest-name"><%= name %> (<%= direction %>)</h2>
  <button class="favorite-btn">★ 즐겨찾기 추가</button>
</div>

<div class="detail-tab">
  <button class="tab-btn active" data-tab="info">상세정보</button>
  <button class="tab-btn" data-tab="food">먹거리</button>
  <button class="tab-btn" data-tab="review">리뷰</button>
</div>

<div id="tabContent"></div>


</div>
<div class="agent-container" style="margin-top: 20px;">
    <div class="agent-box">담당자 정보</div>
    <div class="agent-call">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;모두쉼 콜센터 : 02-1234-5678</div>
</div>
</body>
<div class="footer" style="width: 100%;">
<footer>
<jsp:include page="../common/jsp/footer.jsp" />
</footer>
</div>
</html>