<%@page import="user.account.login.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,user.mypage.favorite.FavoriteDTO,user.mypage.favorite.FavoriteService" %>

<%
	List<FavoriteDTO> favList = new ArrayList<FavoriteDTO>();
	if (session.getAttribute("userData") != null) {
	    request.setCharacterEncoding("UTF-8");
	    LoginDTO lDTO = (LoginDTO) session.getAttribute("userData");
	    String email = lDTO.getUser_email();
	
	    FavoriteService service = new FavoriteService();
	    favList = service.searchFavorite(email);		
	}
%>

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
            success: function (res) {
                alert("삭제가 완료되었습니다.");
                window.parent.$(".content").load("../common/component/mypage/myFavorite.jsp");
            },
            error: function () {
                alert("삭제 중 오류가 발생했습니다.");
            }
        });
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
                <%
                    if (favList != null && !favList.isEmpty()) {
                        for (FavoriteDTO fav : favList) {
                %>
                <tr>
                    <td><input type="checkbox" name="favoriteCheck" value="<%= fav.getFav_num() %>"></td>
                    <td><%= fav.getArea_name() %></td>
                    <td><%= fav.getArea_path() %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="3" style="text-align:center;">등록된 즐겨찾기가 없습니다.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <div class="button-group" style="text-align: center;">
        <button id="deleteBtn" class="btn btn-cancel">삭제</button>
    </div>
</div>





