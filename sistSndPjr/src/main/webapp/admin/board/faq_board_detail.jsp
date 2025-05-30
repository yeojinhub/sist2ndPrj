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
                <h1>FAQ 수정</h1>
            </div>
            <div class="content">
            	<div class="notice-div">
            		<table class="notice-table">
            			<tbody>
            				<tr>
            					<td class="tdColumn">작성자</td>
            					<td><textarea class="one-line">admin03</textarea></td>
            					<td class="tdColumn">작성일</td>
            					<td><textarea class="one-line">2025-05-08</textarea></td>
            				</tr>
            				<tr>
            					<td>제목</td>
            					<td colspan="3"><textarea class="title">전기/수소차 충전소 정보 제공 안내</textarea></td>
            				</tr>
            				<tr>
            					<td>내용</td>
            					<td colspan="3"><textarea class="content">전기 충전소는 공공데이터 연계로 3~4분 정도 지연이 있으며, 갱신 주기는 5분입니다. 수소 충전소는 정보 확인 시 지연 시간 없이 제공하고 있습니다. *한국환경공단 전기자동차 충전소 정보 등 활용</textarea></td>
            				</tr>
            				<tr>
            				</tr>
            			</tbody>
            		</table>
            	</div>
            </div>
            
            <div class="button-detail">
            	<button class="btn btn-edit">수정</button>
            	<button class="btn btn-delete">삭제</button>
            	<button class="btn btn-back" onclick="location.href='faq_board.jsp'">취소</button>
            </div>

        </div>
    </div>
</body>
</html>
