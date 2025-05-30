<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="myPage.ReviewService"%>
<%
    // POST 요청일 때: AJAX 결과용 텍스트만 찍고 종료
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        request.setCharacterEncoding("UTF-8");
        int revNum = Integer.parseInt(request.getParameter("rev_num"));
        String newContent = request.getParameter("newContent");

        response.setContentType("text/plain; charset=UTF-8");
        try {
            new ReviewService().modifyReview(revNum, newContent);
            out.print("OK");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("ERROR");
        }
        return;
    }
%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="DTO.ReviewDTO, myPage.ReviewService"%>
<jsp:include page="../../jsp/external_file.jsp"/>

<style>
  .user_table { width:100%; border-collapse:collapse; margin-bottom:20px; }
  .user_table th, .user_table td { border:1px solid #ddd; padding:8px; }
  textarea { width:100%; height:200px; box-sizing:border-box; }
  .button-group { text-align:center; margin-top:20px; }
  .button-group .btn { width:100px; margin:0 10px; }
</style>

<%
    // GET 요청일 때: 폼 렌더링
    request.setCharacterEncoding("UTF-8");
    int revNum = Integer.parseInt(request.getParameter("rev_num"));
    ReviewDTO review = new ReviewService().searchReviewByNum(revNum);
    String areaName = review.getArea_name();
    String author   = review.getUser_name();
    java.sql.Date date = review.getInput_date();
    String content  = review.getContent();
%>

<div style="padding:20px; max-width:600px; margin:0 auto;">
  <h3 class="section-title">리뷰 수정</h3>
  <hr class="line_gray">

  <form id="modifyForm" method="post"
        action="${pageContext.request.contextPath}/common/component/mypage/myReviewModify.jsp?rev_num=<%=revNum%>">
    <table class="user_table">
      <thead>
        <tr>
          <th style="width:25%">휴게소명</th>
          <td colspan="3"><%= areaName %></td>
        </tr>
        <tr>
          <th>작성자</th>
          <td><%= author %></td>
          <th>작성일</th>
          <td><%= date %></td>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td colspan="4">
            <p><strong>내용</strong></p>
            <textarea name="newContent" required><%= content.replaceAll("<","&lt;").replaceAll(">","&gt;") %></textarea>
          </td>
        </tr>
      </tbody>
    </table>

    <div class="button-group">
      <button type="submit" class="btn btn-confirm">저장</button>
      <button type="button" class="btn btn-cancel"
              onclick="window.parent.$('.content').load('${pageContext.request.contextPath}/common/component/mypage/myReviewDetail.jsp?rev_num=<%=revNum%>');">
        취소
      </button>
    </div>
  </form>
</div>

<script>
$(function(){
  $('#modifyForm').on('submit', function(e){
    e.preventDefault();
    var revNum = <%= revNum %>;
    var newContent = $(this).find('textarea[name="newContent"]').val();

    $.post(
      // AJAX용 URL (POST만 응답)
      '${pageContext.request.contextPath}/common/component/mypage/myReviewModify.jsp?rev_num=' + revNum,
      { newContent: newContent }
    ).done(function(response) {
      if (response.trim() === 'OK') {
        alert('리뷰가 수정되었습니다.');
        // 상세 페이지 다시 로드
        window.parent.$('.content').load(
          '${pageContext.request.contextPath}/common/component/mypage/myReviewDetail.jsp?rev_num=' + revNum
        );
      } else {
        alert('수정에 실패했습니다.');
      }
    }).fail(function(){
      alert('서버 오류가 발생했습니다.');
    });
  });
});
</script>



