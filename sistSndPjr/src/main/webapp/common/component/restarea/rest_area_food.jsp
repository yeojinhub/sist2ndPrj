<%@ page contentType="text/html; charset=UTF-8" %>
<style>
  .food-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 14px;
    margin-bottom: 20px;
  }

  .food-card {
    border: 1px solid #ccc;
    border-radius: 8px;
    background-color: #f8f8f8;
    text-align: center;
    padding: 12px;
  }

  .food-image {
    width: 100%;
    aspect-ratio: 1 / 1;
    background-color: #ddd;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 8px;
    font-size: 13px;
    color: #999;
  }

  .food-name {
    font-weight: bold;
    margin-bottom: 4px;
  }

  .food-price {
    color: #333;
  }

  .hidden {
    display: none;
  }

  .more-btn {
    display: block;
    margin: 0 auto;
    margin-top: 16px;
    font-weight: bold;
    font-size: 16px;
    color: #222;
    background: none;
    border: none;
    cursor: pointer;
  }

  .more-btn:hover {
    color: #2f5fd0;
  }
</style>

<div class="food-grid">
  <!-- 기본 노출 8개 -->
  <div class="food-card"><div class="food-image">[1]</div><div class="food-name">홍순두부정식</div><div class="food-price">9,000 원</div></div>
  <div class="food-card"><div class="food-image">[2]</div><div class="food-name">김치순두부정식</div><div class="food-price">9,000 원</div></div>
  <div class="food-card"><div class="food-image">[3]</div><div class="food-name">부대순두부정식</div><div class="food-price">9,500 원</div></div>
  <div class="food-card"><div class="food-image">[4]</div><div class="food-name">(실속상품) 우동</div><div class="food-price">5,500 원</div></div>
  <div class="food-card"><div class="food-image">[5]</div><div class="food-name">홍순두부정식</div><div class="food-price">9,000 원</div></div>
  <div class="food-card"><div class="food-image">[6]</div><div class="food-name">김치순두부정식</div><div class="food-price">9,000 원</div></div>
  <div class="food-card"><div class="food-image">[7]</div><div class="food-name">부대순두부정식</div><div class="food-price">9,500 원</div></div>
  <div class="food-card"><div class="food-image">[8]</div><div class="food-name">(실속상품) 우동</div><div class="food-price">5,500 원</div></div>

  <!-- 숨겨진 2개 -->
  <div class="food-card hidden"><div class="food-image">[9]</div><div class="food-name">한우불고기정식</div><div class="food-price">10,000 원</div></div>
  <div class="food-card hidden"><div class="food-image">[10]</div><div class="food-name">냉모밀</div><div class="food-price">8,000 원</div></div>
</div>

<button class="more-btn" id="showMoreBtn">더보기 +</button>

<script>
  document.getElementById("showMoreBtn").addEventListener("click", function () {
    document.querySelectorAll(".food-card.hidden").forEach(el => el.classList.remove("hidden"));
    this.style.display = "none";
  });
</script>

