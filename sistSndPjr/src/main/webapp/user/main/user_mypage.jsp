<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setAttribute("menu", "mypage");

boolean flag = false;

if (session.getAttribute("userData") == null) {
	flag = true;
} // end if

pageContext.setAttribute("loginCheck", flag);

String mainPageButtonType = request.getParameter("type") != null ? request.getParameter("type") : "";

pageContext.setAttribute("type", mainPageButtonType);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<jsp:include page="../common/jsp/external_file.jsp" />

<style>
   .content {
    min-width: 0; /* flexbox에서 overflow 방지 */
    flex: 1;       /* 나머지 영역 차지 */
    padding: 24px;
    box-sizing: border-box;
}
    
.page-wrapper {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

.container {
    flex: 1;
}
</style>

<script>
	var $contentDiv;
	
    $(function(){
    	$contentDiv = $('.content');
    	
		if(${loginCheck}) {
			alert("로그인이 필요합니다.\n로그인 페이지로 이동합니다.");
			location.href = "../login/login.jsp"
		};// end if
		
		if('${type}' == 'favorite') {
			myFavorite();
		};
    	
    	//여기도 있어야 색이 유지됨
    	$('.menu li a').on('click', function(e) {
        e.preventDefault(); // 링크 이동 막기
        // 모든 li에서 active 제거
        $('.menu li').removeClass('active');
        // 클릭한 a의 부모 li에 active 추가
        $(this).parent().addClass('active');

    	});
    	
        // ✅ 헤더 메뉴 active 처리 추가
        $('.login_menu.center li a').on('click', function(e) {
            $('.login_menu.center li').removeClass('active');
            $(this).parent().addClass('active');
        });

        

        // 나의 리뷰 로딩 시작.
        $('#myreview').on('click', function(e) {
        	e.preventDefault();
        	myReview();
        });
        // 나의 리뷰 로딩 끝.

        // 나의 정보 로딩 시작.
        $('#myinfo').on('click', function(e) {
        	e.preventDefault();
            myInfo();
        });
        // 나의 정보 로딩 끝.

        $('#myquestion').on('click', function(e) {
        	e.preventDefault();
        	myQuestion();
        });
        // 나의 문의내역 로딩 끝.

        $('#myfavorite').on('click', function(e) {
        	e.preventDefault();
        	myFavorite();
        });
        // 나의 즐겨찾기 로딩 끝.
    });// ready
    
function myFavorite() {
    $contentDiv.load('../common/component/mypage/myFavorite.jsp', function(response, status, xhr) {
        if (status === "error") {
            console.error("myFavorite.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
        } else {
            console.log("myFavorite.jsp 로드 성공.");
        }
    });
};

function myInfo() {
    $contentDiv.load('../common/component/mypage/myinfoRecheckPass.jsp', function(response, status, xhr) {
        if (status === "error") {
            console.error("myinfoRecheckPass.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
        } else {
            console.log("myinfoRecheckPass.jsp 로드 성공.");
        }
    });
};

function myQuestion() {
    $contentDiv.load('../common/component/mypage/myQuestion.jsp', function(response, status, xhr) {
        if (status === "error") {
            console.error("myQuestion.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
        } else {
            console.log("myQuestion.jsp 로드 성공.");
        }
    });
};

function myReview() {
    $contentDiv.load('../common/component/mypage/myReview.jsp', function(response, status, xhr) {
        if (status === "error") {
            console.error("myreview.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
        } else {
            console.log("myreview.jsp 로드 성공.");
        }
    });
};
</script>
</head>
<body>
	<div class="page-wrapper">
		<header>
			<jsp:include page="../common/jsp/header.jsp" />
		</header>
		<body>
			<div class="container">
				<div class="sidebar">
					<h2 class="title">마이페이지</h2>
					<ul class="menu">
						<li id="myinfo" class="active"><a href="#">내 정보</a></li>
						<li id="myreview"><a href="#">나의 리뷰</a></li>
						<li id="myquestion"><a href="#">문의내역</a></li>
						<li id="myfavorite"><a href="#">즐겨찾기</a></li>
					</ul>
					<div class="sidebar-bottom"></div>
				</div>
				<div class="content">
					<c:choose>
						<c:when test="${type == 'favorite' }">
							<jsp:include page="../common/component/mypage/myFavorite.jsp" />
						</c:when>
						<c:when test="${type == 'question' }">
							<jsp:include page="../common/component/mypage/myQuestion.jsp" />
						</c:when>
						<c:otherwise>
							<jsp:include
								page="../common/component/mypage/myinfoRecheckPass.jsp" />
						</c:otherwise>
					</c:choose>
				</div>
			</div>
	</div>
</body>
<footer>
	<jsp:include page="../common/jsp/footer.jsp" />
</footer>
</div>
</body>
</html>
