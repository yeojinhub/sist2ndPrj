<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>

        /* 페이지네이션 */
.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 16px;
}
.pagination button {
    background: none;
    border: none;
    color: #9ca3af;
    cursor: pointer;
    padding: 0 16px;
}
.pagination span {
    font-size: 14px;
}
    
</style>

<script>
	var $contentDiv = $('.content');

    $(function(){
        $('.user_table tr').on('click', function(e){
            e.preventDefault();
            $contentDiv.load('../common/component/mypage/myReviewDetail.jsp', function(response, status, xhr) {
                    if (status === "error") {
                        console.error("myReviewDetail.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
                        $contentDiv.html("<p style='color:red;'>오류: '내 정보' 페이지를 불러올 수 없습니다. 경로를 확인해주세요.</p>");
                    } else {
                        console.log("myReviewDetail.jsp 로드 성공.");
                    }
                });
        });
    });


</script>

<div style="position: relative;">
    <h3 class="section-title">나의 리뷰</h3>
	<hr class="line_gray">

	<div class="user_table">
            <table>
                <thead>
                    <tr>
                        <th>휴게소명</th>
                        <th>내용</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>강릉(인천)</td>
                        <td>휴게소분들 친절해서...</td>
                        <td>2025-03-21</td>
                    </tr>
                    <tr>
                        <td>거장(대구)</td>
                        <td>알감자 맛있어요</td>
                        <td>2025-02-02</td>
                    </tr>
                    <tr>
                        <td>강릉(인천)</td>
                        <td>휴게소가 되게 크고 시설이...</td>
                        <td>2025-01-02</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="pagination">
            <button>◀</button>
            <span style="text-decoration: underline;">1</span>
            <button>▶</button>
        </div>
</div>