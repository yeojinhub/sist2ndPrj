<%@page import="user.mypage.review.ReviewService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../../jsp/external_file.jsp"/>

<link rel="stylesheet" href="../../css/style_headerfooter.css">
<link rel="stylesheet" href="../../css/style_main_page.css">
<link rel="stylesheet" href="../../css/style_accessory.css">
<link rel="stylesheet" href="../../css/style_user_menu.css">
<%
    request.setCharacterEncoding("UTF-8");
    String revNumParam = request.getParameter("rev_num");
    boolean isDeleted = false;

    if ("POST".equalsIgnoreCase(request.getMethod()) && revNumParam != null) {
        try {
            int revNum = Integer.parseInt(revNumParam);
            ReviewService rs = new ReviewService();
            rs.removeReview(revNum);
            isDeleted = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<script>
    <% if (isDeleted) { %>
        alert("리뷰가 삭제되었습니다.");
        window.opener.$('.content').load('../common/component/mypage/myReview.jsp');
        window.opener.$('#myreview').addClass('active');
        window.opener.$('#myinfo').removeClass('active');
        window.close();
    <% } %>
   
</script>

<div>
    <div class="content" style="text-align: center;">
        <img src="../../images/logo251.png" alt="Logo" style="width: 150px; margin-bottom: 50px;">
        <h3 class="section-title">리뷰 삭제</h3>
        <hr class="line_gray" style="width: 500px; margin: 0 auto; margin-bottom: 20px; margin-top: 20px;">
        
        <form method="post"  id="frm" style="width: 400px; margin: 0 auto; text-align: center;">
            <div style="margin: 50px 0;">
                <p class="text" style="font-size: 20px;"><strong>리뷰를 삭제하시겠습니까?</strong></p>
                <p class="text" style="font-size: 18px;">삭제 후 복구가 불가능합니다.</p>
            </div>
            <div class="button-group" style="margin-top: 80px;">
                <button type="submit" class="btn btn-confirm"  style="width: 150px;">삭제</button>
                <button type="button" class="btn btn-cancel" style="width: 150px;" onclick="window.close()">취소</button>
            </div>
        </form>
    </div>
</div>