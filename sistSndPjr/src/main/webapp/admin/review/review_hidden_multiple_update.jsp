<%@ page import="Review.ReviewService" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    
    String[] revNums = request.getParameterValues("rev_nums");
    boolean updateSuccess = false;

    if (revNums != null && revNums.length > 0) {
        ReviewService service = new ReviewService();
        updateSuccess = service.hideReviewsBatch(Arrays.asList(revNums));
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숨김 처리 결과</title>
<script>
    <% if (updateSuccess) { %>
        alert("선택한 리뷰들이 성공적으로 숨김 처리되었습니다.");
        location.href = "reviews.jsp";
    <% } else { %>
        alert("리뷰를 선택한 후 숨김 버튼을 눌러주세요.");
        history.back();
    <% } %>
</script>
</head>
<body></body>
</html>
