<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <link rel="stylesheet" href="../common/css/styles.css">
    <script src="script.js"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="admin_sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>회원 계정관리</h1>
            </div>
            
            <div class="content">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>전화번호</th>
                            <th>가입일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr onclick="location.href='user_account_detail.jsp'">
                            <td>10</td>
                            <td>홍길동</td>
                            <td>father@noretest.com</td>
                            <td>010-1234-5678</td>
                            <td>2021-12-12</td>
                        </tr>
                        <tr>
                            <td>9</td>
                            <td>강태일</td>
                            <td>kang@sist.co.kr</td>
                            <td>010-1114-6321</td>
                            <td>2025-01-10</td>
                        </tr>
                        <tr>
                            <td>8</td>
                            <td>이여진</td>
                            <td>yeojin@sist.co.kr</td>
                            <td>010-8123-8700</td>
                            <td>2025-05-05</td>
                        </tr>
                        <tr>
                            <td>7</td>
                            <td>장태규</td>
                            <td>taegu321@sist.co.kr</td>
                            <td>010-3764-8070</td>
                            <td>2025-05-07</td>
                        </tr>
                        <tr>
                            <td>6</td>
                            <td>현지영</td>
                            <td>jiyeong@sist.co.kr</td>
                            <td>010-2513-9568</td>
                            <td>2025-05-08</td>
                        </tr>
                        <tr>
                            <td>5</td>
                            <td>신민기</td>
                            <td>mingi@sist.co.kr</td>
                            <td>010-3123-2119</td>
                            <td>2025-05-08</td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>유연수</td>
                            <td>yeonsoo@sist.co.kr</td>
                            <td>010-8462-2597</td>
                            <td>2025-05-08</td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>박선은</td>
                            <td>ksdsilver@sist.co.kr</td>
                            <td>010-3648-1211</td>
                            <td>2025-05-08</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>심규민</td>
                            <td>deepmin@sist.co.kr</td>
                            <td>010-5689-1209</td>
                            <td>2025-05-08</td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>주현석</td>
                            <td>zoo@sist.co.kr</td>
                            <td>010-9812-2362</td>
                            <td>2025-05-08</td>
                        </tr>
                    </tbody>
                </table>
                
                <div class="pagination">
                    <a href="#" class="first-page"><i class="fas fa-angle-double-left"></i></a>
                    <a href="#" class="active">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">4</a>
                    <a href="#">5</a>
                    <a href="#" class="last-page"><i class="fas fa-angle-double-right"></i></a>
                </div>
                
                <div class="button-group">
                    <button class="btn btn-add" onclick="location.href='user_account_add.jsp'">등록</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
