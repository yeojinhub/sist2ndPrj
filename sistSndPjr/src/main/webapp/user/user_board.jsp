<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%
request.setAttribute("menu", "board");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<jsp:include page="../common/jsp/external_file.jsp" />

<style>
</style>

<script>
	$(function() {
		$('.menu li a').on('click', function(e) {
			$('.menu li').removeClass('active');
			$(this).parent().addClass('active');
		});

		$('.login_menu.center li a').on('click', function(e) {
			$('.login_menu.center li').removeClass('active');
			$(this).parent().addClass('active');
		});

		var $contentDiv = $('.content');

		// FAQ 시작.
		$('#boardFAQ').on(
				'click',
				function(e) {
					e.preventDefault();
					$contentDiv.load('../common/component/board/boardFAQ.jsp',
							function(response, status, xhr) {
								if (status === "error") {
									console
											.error("boardFAQ.jsp 로드 오류: "
													+ xhr.status + " "
													+ xhr.statusText);
								} else {
									console.log("boardFAQ.jsp 로드 성공.");
								}
							});
				});
		
		$('#boardNotice').on(
				'click',
				function(e) {
					e.preventDefault();
					$contentDiv.load('../common/component/board/boardNotice.jsp',
							function(response, status, xhr) {
								if (status === "error") {
									console
											.error("boardNotice.jsp 로드 오류: "
													+ xhr.status + " "
													+ xhr.statusText);
								} else {
									console.log("boardNotice.jsp 로드 성공.");
								}
							});
				});

	});
</script>
</head>
<body>
	<div class="page-wrapper">
		<header>
			<jsp:include page="../common/jsp/header.jsp" />
		</header>

		<div class="container" >
			<div class="sidebar">
				<h2 class="title">게시판</h2>
				<ul class="menu">
					<li class="active"><a href="#" id="boardNotice">공지사항</a></li>
					<li><a href="#" id="boardFAQ">FAQ</a></li>
				</ul>
				<div class="sidebar-bottom"></div>
			</div>

			<div class="content">
				<jsp:include page="../common/component/board/boardNotice.jsp" />
			</div>
		</div>
	</div>


	</div>
</body>
	<footer>
		<jsp:include page="../common/jsp/footer.jsp" />
	</footer>
</html>
