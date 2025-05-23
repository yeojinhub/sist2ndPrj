<%@ page contentType="text/html; charset=UTF-8" %>
<style>
  .info-container {
    display: flex;
    justify-content: space-between;
    gap: 20px;
    margin-bottom: 20px;
  }

  .info-image, .info-map {
    flex: 1;
    height: 200px;
    background-color: #eee;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    color: #666;
  }

  .info-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
    font-size: 14px;
  }

  .info-table th, .info-table td {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: center;
  }

  .info-table th {
    background-color: #f5f5f5;
    font-weight: bold;
  }
</style>

<div class="info-container">
  <div class="info-image">
    [휴게소 이미지]
  </div>
  <div class="info-map">
    [지도 이미지]
  </div>
</div>

<table class="info-table">
  <tr>
    <th>주소</th>
    <td>충북 옥천군 동이면 금강로 596</td>
    <th>노선</th>
    <td>경부선</td>
  </tr>
  <tr>
    <th>운영시간</th>
    <td>매일 08:00 ~ 20:00</td>
    <th>전화번호</th>
    <td>043-731-2233</td>
  </tr>
  <tr>
    <th colspan="4">편의시설</th>
  </tr>
  <tr>
    <td>수유실</td><td>X</td>
    <td>수면실</td><td>X</td>
  </tr>
  <tr>
    <td>샤워실</td><td>X</td>
    <td>세탁실</td><td>X</td>
  </tr>
  <tr>
    <td>병원</td><td>X</td>
    <td>약국</td><td>X</td>
  </tr>
  <tr>
    <td>쉼터</td><td>O</td>
    <td>이발소</td><td>X</td>
  </tr>
  <tr>
    <td>경정비소</td><td>X</td>
    <td>세차장</td><td>X</td>
  </tr>
  <tr>
    <td colspan="2">Ex. 화물차라운지</td><td colspan="2">X</td>
  </tr>
</table>



