<%@page import="Review.ReviewDTO"%>
<%@page import="Review.ReviewService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
int revNum = Integer.parseInt(request.getParameter("revNum"));
ReviewService service = new ReviewService();
ReviewDTO review = service.getReviewOne(revNum);
request.setAttribute("review", review);

System.out.println("리뷰 번호: " + revNum);
System.out.println("review 객체: " + review);
%>
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
								<td><input type="text" class="input-style" value="${review.name}" readonly /></td>
								<td class="tdColumn">작성일</td>
								<td><input type="text" class="input-style" value="${review.input_date}" readonly /></td>
							</tr>
							<tr>
								<td>휴게소명</td>
								<td><input type="text" class="input-style title" name="title" value="${review.area_name}" required /></td>
								<td>숨김표시</td>
								<td><input type="text" class="input-style title" name="title" value="${review.hidden_type}" required /></td>
							</tr>
							<tr>
								<td>내용</td>
								<td colspan="3"><textarea class="content" readonly>${review.content}</textarea>
        						</td>
							</tr>
						</tbody>
					</table>
            	</div>
            </div>
            
            <div class="button-detail">
            	<form action="review_hidden_update.jsp" method="post" style="display:inline;">
					<input type="hidden" name="rev_num" value="${review.rev_num}" />
					<button type="submit" class="btn btn-hidden">숨김</button>
				</form>
            	<button class="btn btn-back" onclick="location.href='reviews.jsp'">취소</button>
            </div>

        </div>
    </div>
</body>
</html>
