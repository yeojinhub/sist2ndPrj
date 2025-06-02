<%@page import="Util.PaginationUtil"%>
<%@page import="DTO.PaginationDTO"%>
<%@page import="restarea.facility.RestAreaFacilityService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="rDTO" class="DTO.RangeDTO" scope="page" />
<jsp:setProperty name="rDTO" property="*" />
<%
    request.setAttribute("menu", "facility");
	request.setCharacterEncoding("UTF-8");
%>
<%
RestAreaFacilityService rafs = new RestAreaFacilityService();

//1. 전체 데이터(게시물)수를 구합니다.
int totalCount = 0;
totalCount = rafs.totalCount( rDTO );
// 2. 페이지에 보여질 게시물의 수를 구합니다.
int pageScale = 0;
pageScale = rafs.pageScale();
// 3. 총 페이지의 수를 구합니다.
int totalPage = 0;
totalPage = rafs.totalPage(totalCount, pageScale);
// 4. 현재페이지(currentPage)에 따른 게시물 시작 번호를 구합니다.
int startNum = 0;
startNum = rafs.startNum(pageScale, rDTO);
// 5. 현재페이지(currentPage)에 따른 게시물 끝 번호를 구합니다.
int endNum = 0;
endNum = rafs.endNum(pageScale, rDTO);

pageContext.setAttribute("totalCount", totalCount);
pageContext.setAttribute("pageScale", pageScale);
pageContext.setAttribute("totalPage", totalPage);
pageContext.setAttribute("startNum", startNum);
pageContext.setAttribute("endNum", endNum);
pageContext.setAttribute("restAreaFacilityList", rafs.searchAllAreaFacility(rDTO));

// 전체 노선 얻어와서 EL문 사용하기 위한 setAttribute
pageContext.setAttribute("allRoute", rafs.searchAllRoute());
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
    	if (${not empty rDTO.route}) {
	    	$('#route').val('${rDTO.route}');
    	}
    	
    	$('#keyword').val('${rDTO.keyword}');
    	
    	if(${not empty rDTO.wash}) {
    		$('#wash').prop('checked', true);
    	};// end if
    	if(${not empty rDTO.repair}) {
    		$('#repair').prop('checked', true);
    	};// end if
    	if(${not empty rDTO.truck}) {
    		$('#truck').prop('checked', true);
    	};// end if
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
<form action="rest_area_facility.jsp" method="GET">
  <label for="route">노선명</label>
  <select name="route" id="route">
    <option value="select">선택</option>
    <c:forEach var="route" items="${allRoute }" varStatus="i">
    <option value="${route }">${route }</option>
    </c:forEach>
  </select>

  <label for="rest-name">휴게소명</label>
  <input type="text" id="keyword" name="keyword" placeholder="예: 칠곡(상)" />

  <label class="divider-label">구분</label>
  <label><input type="checkbox" id="wash" name="wash" value="O" /> 세차장</label>
  <label><input type="checkbox" id="repair" name="repair" value="O" /> 경정비소</label>
  <label><input type="checkbox" id="truck" name="truck" value="O" /> ex-화물차라운지</label>


  <button type="submit" class="btn btn-confirm">조회</button>
  </form>
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
  </div>
</div>

<!-- 테이블 영역 -->
<div class="user_table">
  <table>
    <thead>
      <tr>
        <th rowspan="2">휴게소명</th>
        <th rowspan="2">노선</th>
        <th rowspan="2">전화번호</th>
        <th rowspan="2">편의시설</th>
        <th rowspan="2">세차장</th>
        <th rowspan="2">경정비소</th>
        <th rowspan="2">ex화물차라운지</th>
      </tr>
    </thead>
  <tbody>
  	<c:if test="${ empty restAreaFacilityList }">
	<tr>
		<td colspan="7">검색된 휴게소가 없습니다.</td>
	</tr>
	</c:if>
    
  <c:forEach var="afDTO" items="${ restAreaFacilityList }" varStatus="i">
	<tr>
	    <td><a href="rest_area_detail.jsp?id=${ afDTO.area_num }">${ afDTO.name }</a></td>
	    <td>${ afDTO.route }</td>
	    <td>${ afDTO.tel }</td>
	    <td>
		 <c:if test="${ afDTO.sleep == 'O' }"><span class="circle green"></span></c:if>
		 <c:if test="${ afDTO.shower == 'O' }"><span class="circle blue"></span></c:if>
		 <c:if test="${ afDTO.laundry == 'O' }"><span class="circle purple"></span></c:if>
		 <c:if test="${ afDTO.shelter == 'O' }"><span class="circle gray"></span></c:if>
		 <c:if test="${ afDTO.salon == 'O' }"><span class="circle brown"></span></c:if>
		 <c:if test="${ afDTO.feed == 'O' }"><span class="circle pink"></span></c:if>
		 <c:if test="${ afDTO.clinic == 'O' }"><span class="circle red"></span></c:if>
		 <c:if test="${ afDTO.pharmacy == 'O' }"><span class="circle yellow"></span></c:if>
	    </td>
	    <td>${ afDTO.wash }</td><td>${ afDTO.repair }</td><td>${ afDTO.truck }</td>
  	</tr>
	</c:forEach>
</tbody>
</table>
<div id="pageinationDiv">

<%
PaginationDTO pDTO = new PaginationDTO(5,rDTO.getCurrentPage(),totalPage,"rest_area_facility.jsp",null,rDTO.getKeyword(),rDTO.getRoute(),null,null,rDTO.getWash(),rDTO.getRepair(),rDTO.getTruck());
%>
<%= PaginationUtil.pagination(pDTO) %>
</div>
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