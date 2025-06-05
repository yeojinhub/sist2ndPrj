<%@page import="Util.ReviewPaginationUtil"%>
<%@page import="DTO.AreaDetailReviewPaginationDTO"%>
<%@page import="restarea.detail.RestAreaDetailReviewService"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="adrrDTO" class="DTO.AreaDetailReviewRangeDTO" scope="page"/>
<jsp:setProperty name="adrrDTO" property="*"/>
<jsp:include page="popup_review_submit.jsp" />
<jsp:include page="popup_review_report.jsp" />

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

 /* 페이지네이션 시작 */
.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 16px;
    font-size: 30px;
}

.pagination p {
	margin-top: 20px;
}

.pagination .next {
    background: none;
    border: none;
    color: #9ca3af;
    padding: 0 16px;
    font-size: 15px;
    cursor: pointer;
}

.pagination .prev {
    background: none;
    border: none;
    color: #9ca3af;
    padding: 0 16px;
    font-size: 15px;
    cursor: pointer;
}

.pagination .number {
    font-size: 20px;
    margin-right: 10px;
}

.pagination a {
	text-decoration: none;
	color: #333;
}
 /* 페이지네이션 끝 */
</style>
<%
int id = Integer.parseInt(request.getParameter("id"));

RestAreaDetailReviewService radrs = new RestAreaDetailReviewService();

// 1. 총 게시물 확인
int totalCount = 0;
totalCount = radrs.searchTotalCount(id);
// 2. 보여질 게시물의 수
int pageScale = 0;
pageScale = radrs.pageScale(10);
// 3. 총 페이지 수를 구한다.
int totalPage = 0;
totalPage = radrs.totalPage(totalCount, pageScale);
// 4. 현재 페이지(currentPage)에 따른 게시물 시작 번호
int startNum = 0;
startNum = radrs.startNum(pageScale, adrrDTO);
// 5. 현재 페이지(currentPage)에 따른 게시물 시작 번호
int endNum = 0;
endNum = radrs.endNum(pageScale, adrrDTO);

pageContext.setAttribute("reviewList", radrs.searchAllReview(id, adrrDTO));
%>
<!-- 리뷰 목록 -->
<div class="review-list">
	<c:choose>
		<c:when test="${empty reviewList }">
			<div class="review-item">
				<div style="text-align: center;">
					<strong>작성된 리뷰가 존재하지 않습니다.</strong>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<c:forEach var="review" items="${reviewList }" varStatus="i">
				<div class="review-item">
					<div class="review-header">
						${review.name } <span><fmt:formatDate
								value="${review.input_date }" pattern="M.d(E)" /></span>
					</div>
					<div class="review-content">
						<div>${review.content }</div>
						<div class="report-btn">🚨 신고</div>
					</div>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>

</div>

<!-- 페이지네이션 -->
<div class="pagination">
	<%
	AreaDetailReviewPaginationDTO adrpDTO = new AreaDetailReviewPaginationDTO(5, adrrDTO.getCurrentPage(), totalPage);
	
	ReviewPaginationUtil rp = new ReviewPaginationUtil();
	%>
	<%= rp.pagination(adrpDTO) %>
</div>

<!-- 리뷰 작성 -->
<div class="review-write">
	<label>리뷰 작성</label><br> <input type="text" id="reviewText"
		placeholder="리뷰를 작성해주세요." style="width: 90%;">
	<button id="submitBtn">작성</button>
</div>

<!-- jQuery 로직 -->
<script>
	$(function() {

		// 작성 버튼 눌렀을 때
		$("#submitBtn").on("click", function() {
			const text = $("#reviewText").val().trim();
			if (text) {
				$("#reviewSubmitPopup").fadeIn();
				$("#reviewText").val("");
			}
		});

		// 신고 버튼 눌렀을 때
		$(".report-btn").on("click", function() {
			$("#reportConfirmPopup").fadeIn();
		});

		// 팝업 버튼 닫기
		$("#reviewSubmitPopup .popup-confirm").on("click", function() {
			$("#reviewSubmitPopup").fadeOut();
		});

		$("#reportConfirmPopup .popup-confirm, #reportConfirmPopup .popup-cancel").on("click", function() {
			$("#reportConfirmPopup").fadeOut();
		});
		
		
		// 페이지네이션	
		 // 페이지 번호 클릭
	    $('.pagination span').click(function(e){
	        var page = $(this).text().trim();
	        var url = '../common/component/restarea/rest_area_review.jsp?id=' + ${param.id} 
	                + '&currentPage=' + page;
	        $('#tabContent').load(url);
	    });

	    // next 버튼 클릭
	    $('.pagination .next').click(function(){
	        var nextPage = <%= adrrDTO.getCurrentPage() + 1 %>;
	        if(nextPage <= <%= totalPage %>) {
	            var url = '../common/component/restarea/rest_area_review.jsp?id=' + ${param.id} 
	                    + '&currentPage=' + nextPage;
	            $('#tabContent').load(url);
	        }
	    });

	    // prev 버튼 클릭
	    $('.pagination .prev').click(function(){
	        var prevPage = <%= adrrDTO.getCurrentPage() - 1 %>;
	        if(prevPage >= 1) {
	            var url = '../common/component/restarea/rest_area_review.jsp?id=' + ${param.id} 
	                    + '&currentPage=' + prevPage;
	            $('#tabContent').load(url);
	        }
	    });

	});
</script>



