<%@page import="user.notice.NoticeDTO"%>
<%@page import="user.notice.NoticeService"%>
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
footer {
  margin-top: auto; /* 이 속성이 핵심 */
}
.container {
    display: flex;
    height: 100vh;
    width: 100vw;
    flex: 1;
}
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

		<div class="container">
			<div class="sidebar">
				<h2 class="title">게시판</h2>
				<ul class="menu">
					<li class="active"><a href="#" id="boardNotice">공지사항</a></li>
					<li><a href="#" id="boardFAQ">FAQ</a></li>
				</ul>
				<div class="sidebar-bottom"></div>
			</div>

			<div class="content">
<%
String notNumParam = request.getParameter("not_num");
int notNum = 0;
if (notNumParam != null && !notNumParam.isEmpty()) {
    notNum = Integer.parseInt(notNumParam);
}

if (notNum > 0) {
    // `not_num`이 있으면 디테일 페이지 로드
    NoticeService ns = new NoticeService();
    NoticeDTO nDTO = ns.searchOneNotice(notNum);
    pageContext.setAttribute("nDTO", nDTO);
%>
<!-- 공지사항 디테일 -->
    <h3 class="section-title">공지사항 상세보기</h3>
    <hr class="line_gray">

    <table class="user_table">
        <thead>
            <tr>
                <th style="width: 25%;">제목</th>
                <td colspan="3">${nDTO.title}</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>${nDTO.name}</td>
                <th>작성일</th>
                <td>${nDTO.input_date}</td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td colspan="4" style="height: 300px; vertical-align: top; padding: 15px;">
                    ${nDTO.content}
                </td>
            </tr>
        </tbody>
    </table>
<%  
    } else {%>
         <jsp:include page="../common/component/board/boardNotice.jsp" />
   <% }
%>
			</div>
		</div>
	</div>


	<footer>
		<jsp:include page="../common/jsp/footer.jsp" />
	</footer>
</body>
</html>
