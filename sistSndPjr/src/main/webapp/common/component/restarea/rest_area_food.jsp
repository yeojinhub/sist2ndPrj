<%@page import="DTO.AreaDetailFoodDTO"%>
<%@page import="java.util.List"%>
<%@page import="restarea.detail.RestAreaDetailFoodService"%>
<%@page import="restarea.detail.RestAreaDetailFoodDAO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
int id = Integer.parseInt(request.getParameter("id"));

RestAreaDetailFoodService radfs = new RestAreaDetailFoodService();

List<AreaDetailFoodDTO> list = radfs.searchAllFood(id);

pageContext.setAttribute("foodList", list);
%>
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

<div class="food-table">
<table class="user_table">
			<thead>
				<tr>
					<th>번호</th>
					<th>음식명</th>
					<th>가격</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</tbody>
		</table>

  <!-- 기본 노출 8개 -->
  <c:forEach var="food" items="${foodList }" varStatus="i">
  	<div class="food-card"><div class="food-image">[${i.count }]</div><div class="food-name">${food.name }</div><div class="food-price">${food.price }</div></div>	
  </c:forEach>
  
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

