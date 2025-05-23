<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
    function deleteFavorite() {
        if (confirm('즐겨찾기를 삭제하시겠습니까?')) {
            alert('즐겨찾기가 삭제되었습니다.');
            window.parent.$('.content').load('../common/component/mypage/myFavorite.jsp', function(response, status, xhr) {
                if (status === "error") {
                    console.error("myFavorite.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
                }
            });
            window.parent.$('#myfavorite').addClass('active');
            window.parent.$('#myinfo').removeClass('active');
        }
    }
</script>

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
$(function() {
    $('#checkAll').on('change', function() {
        const isChecked = $(this).prop('checked');
        $('input[name="favoriteCheck"]').prop('checked', isChecked);
    });
}); // ready
</script>

<div style="position: relative;">
    <h3 class="section-title">나의 즐겨찾기</h3>
	<hr class="line_gray">

	<div class="user_table">
            <table>
                <thead>
                    <tr>
                        <th><input type="checkbox" name="checkAll" id="checkAll"></th>
                        <th>휴게소명</th>
                        <th>노선</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><input type="checkbox" name="favoriteCheck" value="1"></td>
                        <td>강릉(인천)</td>
                        <td>경부선</td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" name="favoriteCheck" value="2"></td>
                        <td>거장(대구)</td>
                        <td>경부선</td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" name="favoriteCheck" value="3"></td>
                        <td>신창(전남)</td>
                        <td>경부선</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="pagination">
            <button>◀</button>
            <span style="text-decoration: underline;">1</span>
            <button>▶</button>
        </div>

        <div class="button-group" style="text-align: center;">
            <button class="btn btn-cancel" onclick="deleteFavorite()">삭제</button>
        </div>
</div>