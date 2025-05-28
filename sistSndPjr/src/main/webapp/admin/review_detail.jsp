<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <link rel="stylesheet" href="../common/css/styles.css">
    <script src="script.js"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="admin_sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>리뷰 조회</h1>
            </div>
            <div class="content">
            	<div class="notice-div">
            		<table class="notice-table">
						<tbody>
							<tr>
								<td class="tdColumn">작성자</td>
								<td><textarea class="one-line">주현석</textarea></td>
								<td class="tdColumn">작성일</td>
								<td><textarea class="one-line">2025-05-03</textarea></td>
							</tr>
							<tr>
								<td>휴게소명</td>
								<td colspan="3"><textarea class="title">예산(당진)</textarea></td>
							</tr>
							<tr>
								<td>내용</td>
								<td colspan="3"><textarea class="content">자연경관이 멋진 곳이에요!</textarea>
        						</td>
							</tr>
						</tbody>
					</table>
            	</div>
            </div>
            
            <div class="button-detail">
            	<button class="btn btn-hidden">숨김</button>
            	<button class="btn btn-back" onclick="location.href='reviews.jsp'">취소</button>
            </div>

        </div>
    </div>
</body>
</html>
