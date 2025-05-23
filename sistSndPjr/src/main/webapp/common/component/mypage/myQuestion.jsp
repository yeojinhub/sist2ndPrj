<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            $contentDiv.load('../common/component/mypage/myQuestionDetail.jsp', function(response, status, xhr){
                if(status === 'error'){
                    console.error("myQuestionDetail.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
                    $contentDiv.html("<p style='color:red;'>오류: '내 정보' 페이지를 불러올 수 없습니다. 경로를 확인해주세요.</p>");
                } else {
                    console.log("myQuestionDetail.jsp 로드 성공.");
                }
            })
        });

        $('#writeBtn').on('click', function(e){
            e.preventDefault();
            $contentDiv.load('../common/component/mypage/myQuestionWrite.jsp', function(response, status, xhr){
                if(status === 'error'){
                    console.error("myQuestionWrite.jsp 로드 오류: " + xhr.status + " " + xhr.statusText);
                    $contentDiv.html("<p style='color:red;'>오류: '문의 작성' 페이지를 불러올 수 없습니다. 경로를 확인해주세요.</p>");
                } else {
                    console.log("myQuestionWrite.jsp 로드 성공.");
                }
            })
        });
    });
</script>
<div style="position: relative;">
    <h3 class="section-title">문의내역</h3>
	<hr class="line_gray">
	
 <div class="board-content">
            <div class="search-container" style="text-align: center;">
                <div class="search-box">
                    <select>
                        <option>제목</option>
                    </select>
                <input type="text"  placeholder="검색어를 입력해주세요" />
                <button class="btn btn-confirm" >검색</button>
                </div>
            </div>
            
            <div class="user_table">
            <table >
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>답변여부</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>3</td>
                        <td>회원탈퇴 어떻게 해요?</td>
                        <td>답변완료</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>벌써 월요일이에요?</td>
                        <td>답변완료</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>행담도휴게소 김치찌개메뉴 가격이 달라요</td>
                        <td>대기</td>
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
                <button class="btn btn-confirm" id="writeBtn">작성</button>
            </div>
        </div>

</div>