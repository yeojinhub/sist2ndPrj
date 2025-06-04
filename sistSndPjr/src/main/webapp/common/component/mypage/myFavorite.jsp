<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, DTO.FavoriteDTO, DTO.LoginDTO, DTO.PaginationDTO2, myPage.FavoriteService" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    request.setCharacterEncoding("UTF-8");
    LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");
    String email = lDTO.getUser_email();

    String pageParam = request.getParameter("page");
    int currentPage = 1;
    if (pageParam != null && !pageParam.isEmpty()) {
        try {
            currentPage = Integer.parseInt(pageParam);
        } catch (NumberFormatException e) {
            currentPage = 1;
        }
    }

    int pageSize = 10;

    FavoriteService service = new FavoriteService();
    int totalCount = service.getTotalCount(email);
    PaginationDTO2 paging = new PaginationDTO2(currentPage, pageSize, totalCount);
    List<FavoriteDTO> favList = service.searchFavoriteWithPaging(email, paging);

    request.setAttribute("favList", favList);
    request.setAttribute("paging", paging);
%>

<style>
.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 16px;
    font-family: sans-serif;
}
.pagination a, .pagination span {
    margin: 0 6px;
    font-size: 18px;
    text-decoration: none;
    color: black;
    cursor: pointer;
}
.pagination span {
    font-weight: bold;
    text-decoration: underline;
}
.pagination a.disabled {
    color: #ccc;
    pointer-events: none;
    cursor: default;
}
.user_table {
    width: 100%;
    overflow-x: auto;
}
.user_table table {
    width: 100%;
    border-collapse: collapse;
}
.user_table th, .user_table td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid #ccc;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function () {
    $('#checkAll').on('change', function () {
        const isChecked = $(this).prop('checked');
        $('input[name="favoriteCheck"]').prop('checked', isChecked);
    });

    $('#deleteBtn').on('click', function () {
        let checked = $('input[name="favoriteCheck"]:checked');
        if (checked.length === 0) {
            alert("삭제할 항목을 선택해주세요.");
            return;
        }

        if (!confirm("즐겨찾기를 삭제하시겠습니까?")) return;

        let favNums = [];
        checked.each(function () {
            favNums.push($(this).val());
        });

        $.ajax({
            type: "POST",
            url: "../common/component/mypage/deleteFavorite.jsp",
            traditional: true,
            data: {
                favoriteCheck: favNums
            },
            success: function () {
                alert("삭제가 완료되었습니다.");
                $(".content").load("../common/component/mypage/myFavorite.jsp?page=<%= currentPage %>");
            },
            error: function () {
                alert("삭제 중 오류가 발생했습니다.");
            }
        });
    });

    $('.pagination').on('click', 'a', function(e) {
        e.preventDefault();
        const url = $(this).attr('href');
        $('.content').load(url);
    });
});
</script>

<div style="position: relative;">
    <h3 class="section-title">나의 즐겨찾기</h3>
    <hr class="line_gray">

    <div class="user_table">
        <table>
            <thead>
                <tr>
                    <th><input type="checkbox" id="checkAll"></th>
                    <th>휴게소명</th>
                    <th>노선</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty favList}">
                        <c:forEach var="fav" items="${favList}">
                            <tr>
                                <td><input type="checkbox" name="favoriteCheck" value="${fav.fav_num}"></td>
                                <td>${fav.area_name}</td>
                                <td>${fav.area_path}</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="3" style="text-align:center;">등록된 즐겨찾기가 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <div class="button-group" style="text-align: center;">
        <button id="deleteBtn" class="btn btn-cancel">삭제</button>
    </div>

    <div class="pagination">
        <c:choose>
            <c:when test="${paging.page > 1}">
                <a href="../common/component/mypage/myFavorite.jsp?page=${paging.page - 1}">◀</a>
            </c:when>
            <c:otherwise>
                <a class="disabled">◀</a>
            </c:otherwise>
        </c:choose>

        <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
            <c:choose>
                <c:when test="${i == paging.page}">
                    <span>${i}</span>
                </c:when>
                <c:otherwise>
                    <a href="../common/component/mypage/myFavorite.jsp?page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:choose>
            <c:when test="${paging.page < paging.totalPage}">
                <a href="../common/component/mypage/myFavorite.jsp?page=${paging.page + 1}">▶</a>
            </c:when>
            <c:otherwise>
                <a class="disabled">▶</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>





