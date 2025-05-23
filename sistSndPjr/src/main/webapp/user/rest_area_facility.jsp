<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info=""%>
<%
    request.setAttribute("menu", "facility");
%>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>휴게소 편의시설 정보</title>
    <jsp:include page="../common/jsp/external_file.jsp"/>
<style>

</style>

<script>
    $(function(){
    	
    });
</script>
</head>
<body>
<header>
<jsp:include page="../common/jsp/header.jsp" />
</header>
<div class="container" style="display: flex; flex-direction: column; min-height: 100vh; height: auto;">
<!-- 타이틀 영역 -->
<div><hr class="line_blue" style="text-align: center;" /></div>
<div>
  <h2>
    <span style="font-size:40px;">휴게소/영업소_</span>
    <span style="font-size:30px;">휴게소</span>
  </h2>
</div>

<!-- 안내문 박스 -->
<div class="notice-box">
  <div class="notice-title">고속도로 휴게소 시각장애인 전담요원 지원 안내</div>
  <ul class="notice-list">
    <li>시각장애인이 휴게소 이용 시 직원이 직접 동행하여 편의 제공</li>
    <li>신청방법 : 해당 휴게소 전화번호로 연락해 요청 바랍니다.</li>
  </ul>
</div>

<!-- 검색 필터 영역 -->
<div class="search-box">
  <label for="route">노선명</label>
  <select name="route" id="route">
    <option value="">선택</option>
    <option value="경부고속도로">경부고속도로</option>
    <option value="영동고속도로">영동고속도로</option>
    <option value="서해안고속도로">서해안고속도로</option>
    <option value="중부고속도로">중부고속도로</option>
    <option value="호남고속도로">호남고속도로</option>
  </select>

  <label for="rest-name">휴게소명</label>
  <input type="text" id="rest-name" name="restName" placeholder="예: 칠곡(상)" />

  <label class="divider-label">구분</label>
  <label><input type="checkbox" name="type" value="세차장" /> 세차장</label>
  <label><input type="checkbox" name="type" value="경정비소" /> 경정비소</label>
  <label><input type="checkbox" name="type" value="ex화물차라운지" /> ex-화물차라운지</label>


  <button type="submit" class="btn btn-confirm">조회</button>
</div>
		
<!-- 편의시설 정보 박스 -->
<div class="facility-legend">
  <div class="legend-title">편의시설 정보</div>
  <div class="legend-items">
    <span><span class="circle green"></span> 수면실</span>
    <span><span class="circle blue"></span> 샤워실</span>
    <span><span class="circle purple"></span> 세탁실</span>
    <span><span class="circle gray"></span> 쉼터</span>
    <span><span class="circle brown"></span> 이발소</span>
    <span><span class="circle pink"></span> 수유실</span>
    <span><span class="circle red"></span> 병원</span>
    <span><span class="circle yellow"></span> 약국</span>
    <span><span class="circle orange"></span> 농산물판매장</span>
  </div>
</div>

<!-- 테이블 영역 -->
<div class="user_table">
  <table>
    <thead>
      <tr>
        <th rowspan="2">휴게소명</th>
        <th rowspan="2">이정</th>
        <th rowspan="2">전화번호</th>
        <th colspan="2">편의시설</th>
        <th rowspan="2">브랜드매장</th>
        <th rowspan="2">세차장</th>
        <th rowspan="2">경정비소</th>
        <th rowspan="2">ex화물차라운지</th>
      </tr>
      <tr>
        <th>휴게소</th>
        <th>주유소</th>
      </tr>
    </thead>
  <tbody>
  <tr>
    <td><a href="rest_area_detail.jsp?id=101">강릉(강릉)</a></td>
    <td>인천기점 231</td>
    <td>033-648-8850</td>
    <td><span class="circle green"></span><span class="circle blue"></span><span class="circle gray"></span></td>
    <td><span class="circle brown"></span></td>
    <td>엔제리너스 외 1</td>
    <td>X</td><td>X</td><td>X</td>
  </tr>
  <tr>
    <td><a href="rest_area_detail.jsp?id=102">강릉(인천)</a></td>
    <td>인천기점 231</td>
    <td>033-647-9970</td>
    <td><span class="circle green"></span><span class="circle blue"></span><span class="circle gray"></span></td>
    <td><span class="circle brown"></span></td>
    <td>엔제리너스 외 3</td>
    <td>X</td><td>X</td><td>X</td>
  </tr>
  <tr>
    <td><a href="rest_area_detail.jsp?id=103">강천산(광주)</a></td>
    <td>고서기점 22</td>
    <td>063-653-4033</td>
    <td><span class="circle green"></span><span class="circle blue"></span><span class="circle pink"></span></td>
    <td><span class="circle orange"></span></td>
    <td>로떼번</td>
    <td>X</td><td>X</td><td>X</td>
  </tr>
  <tr>
    <td><a href="rest_area_detail.jsp?id=104">강천산(대구)</a></td>
    <td>고서기점 22</td>
    <td>063-653-3050</td>
    <td><span class="circle green"></span><span class="circle blue"></span><span class="circle pink"></span></td>
    <td><span class="circle orange"></span></td>
    <td>로떼번</td>
    <td>X</td><td>X</td><td>X</td>
  </tr>
  <tr>
    <td><a href="rest_area_detail.jsp?id=105">거창(광주)</a></td>
    <td>고서기점 137</td>
    <td>055-943-0992</td>
    <td><span class="circle green"></span><span class="circle blue"></span><span class="circle pink"></span></td>
    <td><span class="circle orange"></span></td>
    <td>할리스 외 1</td>
    <td>X</td><td>X</td><td>X</td>
  </tr>
  <tr>
    <td><a href="rest_area_detail.jsp?id=106">거창(대구)</a></td>
    <td>고서기점 137</td>
    <td>055-943-9534</td>
    <td><span class="circle green"></span><span class="circle blue"></span><span class="circle pink"></span></td>
    <td><span class="circle orange"></span></td>
    <td>할리스 외 1</td>
    <td>X</td><td>X</td><td>X</td>
  </tr>
  <tr>
    <td><a href="rest_area_detail.jsp?id=107">건천(부산)</a></td>
    <td>부산기점 76</td>
    <td>054-751-6890</td>
    <td><span class="circle blue"></span></td>
    <td></td>
    <td>투썸플레이스 외 1</td>
    <td>X</td><td>X</td><td>X</td>
  </tr>
  <tr>
    <td><a href="rest_area_detail.jsp?id=108">건천(서울)</a></td>
    <td>부산기점 76</td>
    <td>054-751-7401</td>
    <td><span class="circle green"></span><span class="circle gray"></span></td>
    <td></td>
    <td>탐앤탐스</td>
    <td>X</td><td>X</td><td>X</td>
  </tr>
  <tr>
    <td><a href="rest_area_detail.jsp?id=109">경산(서울)</a></td>
    <td>부산기점 111</td>
    <td>053-852-5243</td>
    <td><span class="circle green"></span><span class="circle blue"></span><span class="circle pink"></span><span class="circle gray"></span><span class="circle purple"></span><span class="circle red"></span></td>
    <td><span class="circle orange"></span></td>
    <td>엔제리너스 외 3</td>
    <td>X</td><td>X</td><td>O</td>
  </tr>
  <tr>
    <td><a href="rest_area_detail.jsp?id=110">경주(부산)</a></td>
    <td>부산기점 59</td>
    <td>054-748-3195</td>
    <td><span class="circle green"></span><span class="circle blue"></span><span class="circle pink"></span><span class="circle gray"></span><span class="circle purple"></span><span class="circle red"></span></td>
    <td><span class="circle orange"></span></td>
    <td>드롭탑</td>
    <td>X</td><td>X</td><td>O</td>
  </tr>
</tbody>



</table>
</div>

</div> <%-- End of container div --%>
<div class="agent-container">
		<div class="agent-box">담당자 정보</div>
		<div class="agent-call">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;모두쉼 콜센터 : 02-1234-5678</div>
	</div>
<div class="footer" style="width: 100%;">
<footer>
<jsp:include page="../common/jsp/footer.jsp" />
</footer>
</div>
</body>
</html>