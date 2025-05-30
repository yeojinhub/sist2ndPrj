<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <link rel="stylesheet" href="/sistSndPjr/admin/common/css/styles.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="/sistSndPjr/admin/script.js"></script>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="/admin/common/jsp/admin_sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>공지사항 수정</h1>
            </div>
            <div class="content">
            	<div class="notice-div">
            		<table class="notice-table">
						<tbody>
							<tr>
								<td class="tdColumn">작성자</td>
								<td><textarea class="one-line">admin03 </textarea></td>
								<td class="tdColumn">작성일</td>
								<td><textarea class="one-line">2025-05-03</textarea></td>
							</tr>
							<tr>
								<td>제목</td>
								<td colspan="3"><textarea class="title">[고속도로 교통상황] 오후 4~5시 정체 절정...영동선, 서해안선 혼잡</textarea></td>
							</tr>
							<tr>
								<td>내용</td>
								<td colspan="3"><textarea class="content">
5월 어린이날 연휴 마지막날인 6일 화요일은 교통량이 평소 주말 및 화요일 보다는 감소하지만 서울 방향은 다소 혼잡할 것으로 전망된다.
한국도로 공사에 따르면 이날 전국 고속도록 교통량은 516만대로 예상된다. 수도권에서 지방으로 빠져나가는 차량은 36만대, 지방에서 수도권으로 진입하는 차량은 50만대로 예측된다.
지방방향은 비교적 원활하지만, 서울 방향은 영동선과 서해안선을 위주로 오후 4시께 가장 혼잡할 것으로 보인다.
시간대별로 오전 9시~10시 정체가 시작돼 오후 4시~5시 절정에 이르다 오후 10시~11시 해소될 것으로 보인다.</textarea>
        						</td>
							</tr>
						</tbody>
					</table>
            	</div>
            </div>
            
            <div class="button-detail">
            	<button class="btn btn-edit">수정</button>
            	<button class="btn btn-delete">삭제</button>
            	<button class="btn btn-back" onclick="location.href='notice_board.jsp'">취소</button>
            </div>

        </div>
    </div>
</body>
</html>
