<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, myPage.FavoriteService" %>

<%
    request.setCharacterEncoding("UTF-8");

    String[] favNums = request.getParameterValues("favoriteCheck");

    if (favNums != null && favNums.length > 0) {
        List<Integer> favList = new ArrayList<>();
        for (String num : favNums) {
            try {
                favList.add(Integer.parseInt(num));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        FavoriteService service = new FavoriteService();
        service.removeFavorites(favList);
        out.print("success");
    } else {
        out.print("fail");
    }
%>


