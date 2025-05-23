<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:include page="popup_review_submit.jsp"/>
<jsp:include page="popup_review_report.jsp"/>

<!-- 리뷰 스타일 및 목록 -->
<style>
  .review-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
    margin-bottom: 20px;
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 14px;
  }

  .review-item {
    border: 1px solid #ccc;
    border-radius: 8px;
    padding: 12px 14px;
    position: relative;
  }

  .review-header {
    display: flex;
    justify-content: space-between;
    font-weight: bold;
    margin-bottom: 6px;
  }

  .review-content {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    font-size: 14px;
  }

  .report-btn {
    font-size: 12px;
    color: red;
    cursor: pointer;
  }

  .pagenation {
    text-align: center;
    margin: 20px 0;
  }

  .pagenation span {
    margin: 0 5px;
    cursor: pointer;
  }

  .review-write {
    border-top: 1px solid #ccc;
    padding-top: 12px;
    margin-top: 30px;
    margin-left: 30px;
    margin-bottom: 50px;
  }

  .review-write label {
    font-weight: bold;
    font-size: 14px;
    display: inline-block;
    margin-bottom: 8px;
    color: #3f51b5;
  }

  .review-write input {
    width: 70%;
    padding: 6px;
    margin-right: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
  }

  .review-write button {
    padding: 6px 12px;
    background-color: #999;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
</style>

<!-- 리뷰 목록 -->
<div class="review-list">
  <% for (int i = 1; i <= 10; i++) { %>
    <div class="review-item">
      <div class="review-header">
        이름 <span>5.1(화)</span>
      </div>
      <div class="review-content">
        <div>내용</div>
        <div class="report-btn">🚨 신고</div>
      </div>
    </div>
  <% } %>
</div>

<!-- 페이지네이션 -->
<div class="pagenation">
  <span>1</span><span>2</span><span>3</span><span>4</span><span>5</span>
</div>

<!-- 리뷰 작성 -->
<div class="review-write">
  <label>리뷰 작성</label><br>
  <input type="text" id="reviewText" placeholder="리뷰를 작성해주세요." style="width: 90%;">
  <button id="submitBtn">작성</button>
</div>

<!-- jQuery 로직 -->
<script>
  $(function () {

    // 작성 버튼 눌렀을 때
    $("#submitBtn").on("click", function () {
      const text = $("#reviewText").val().trim();
      if (text) {
        $("#reviewSubmitPopup").fadeIn();
        $("#reviewText").val("");
      }
    });

    // 신고 버튼 눌렀을 때
    $(".report-btn").on("click", function () {
      $("#reportConfirmPopup").fadeIn();
    });

    // 팝업 버튼 닫기
    $("#reviewSubmitPopup .popup-confirm").on("click", function () {
      $("#reviewSubmitPopup").fadeOut();
    });

    $("#reportConfirmPopup .popup-confirm, #reportConfirmPopup .popup-cancel").on("click", function () {
      $("#reportConfirmPopup").fadeOut();
    });

  });
</script>



