<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.invalidate();  // 세션 초기화
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그아웃</title>
    <script type="text/javascript">
        alert("로그아웃 되었습니다.");
        location.href = "/sistSndPjr/admin/login/admin_login.jsp";
    </script>
</head>
<body>
</body>
</html>