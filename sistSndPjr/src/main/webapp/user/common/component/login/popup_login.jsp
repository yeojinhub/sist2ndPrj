<%@ page contentType="text/html; charset=UTF-8" %>
<style>
  #reportConfirmPopup {
    position: fixed;
    top: 30%;
    left: 50%;
    transform: translateX(-50%);
    width: 280px;
    background-color: white;
    border: 1px solid #ccc;
    padding: 20px 30px;
    z-index: 999;
    text-align: center;
    border-radius: 8px;
    display: none;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    font-family: 'Noto Sans KR', sans-serif;
  }

  #reportConfirmPopup .logo {
    width: 80px;
    margin-bottom: 8px;
  }

  #reportConfirmPopup .popup-title {
    font-size: 13px;
    font-weight: 500;
    text-align: left;
    border-bottom: 1px solid #aaa;
    padding-bottom: 4px;
    margin-bottom: 16px;
  }

  #reportConfirmPopup .popup-content {
    font-weight: bold;
    margin: 10px 0 20px;
    font-size: 15px;
  }

  #reportConfirmPopup .popup-buttons {
    display: flex;
    justify-content: center;
    gap: 10px;
  }

  #reportConfirmPopup .popup-buttons button {
    padding: 6px 18px;
    font-size: 14px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  #reportConfirmPopup .popup-confirm {
    background-color: #2c3eeb;
    color: white;
  }

  #reportConfirmPopup .popup-cancel {
    background-color: #ccc;
    color: #333;
  }
</style>

<div class="popup" id="reportConfirmPopup">
  <img src="../common/images/logo251.png" alt="로고" class="logo">
  <div class="popup-title">리뷰 신고</div>
  <div class="popup-content">리뷰를 신고 하시겠습니까?</div>
  <div class="popup-buttons">
    <button class="popup-confirm">확인</button>
    <button class="popup-cancel">취소</button>
  </div>
</div>


