<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common/jsp/login_chk.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="Statistics.StatisticsDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <link rel="stylesheet" href="common/css/styles.css">
    <link rel="stylesheet" href="common/css/dashboard.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- 파비콘 추가 (404 에러 방지) -->
    <link rel="icon" type="image/x-icon" href="common/images/favicon.ico">
</head>
<body>
    <%
        // 통계 데이터를 가져오는 Java 코드
        StatisticsDAO statsDAO = StatisticsDAO.getInstance();
        
        // 기본 통계 (try-catch로 예외 처리)
        int todaySignups = 0;
        int totalMembers = 0;
        int withdrawnMembers = 0;
        int todayReviews = 0;
        int totalReviews = 0;
        List<Map<String, Object>> dailySignups = new ArrayList<>();
        List<Map<String, Object>> dailyReviews = new ArrayList<>();
        
        String errorMessage = "";
        boolean hasData = false;
        
        try {
            todaySignups = statsDAO.getTodaySignups();
            totalMembers = statsDAO.getTotalMembers();
            withdrawnMembers = statsDAO.getWithdrawnMembers();
            todayReviews = statsDAO.getTodayReviews();
            totalReviews = statsDAO.getTotalReviews();
            
            // 차트용 데이터
            dailySignups = statsDAO.getDailySignupStats(30);
            dailyReviews = statsDAO.getDailyReviewStats(30);
            
            hasData = true;
            
        } catch(SQLException e) {
            e.printStackTrace();
            errorMessage = e.getMessage();
            // 에러 발생 시 기본값 사용
        }
    %>
    
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="common/jsp/admin_sidebar.jsp" />
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>메인화면</h1>
                <% if(!errorMessage.isEmpty()) { %>
                    <div style="color: red; font-size: 12px; margin-top: 10px;">
                        <i class="fas fa-exclamation-triangle"></i>
                        데이터베이스 연결 오류: <%= errorMessage %>
                    </div>
                <% } %>
                <% if(hasData) { %>
                    <div style="color: green; font-size: 12px; margin-top: 5px;">
                        <i class="fas fa-check-circle"></i>
                        데이터 로드 완료
                    </div>
                <% } %>
            </div>
            
            <!-- Charts Row -->
            <div class="dashboard-grid">
                <div class="chart-container">
                    <div class="chart-title">
                        <i class="fas fa-user-plus"></i>
                        날짜별 회원가입 통계 (최근 30일)
                        <button onclick="window.refreshDashboard()" style="float: right; padding: 5px 10px; font-size: 12px;">
                            <i class="fas fa-refresh"></i> 새로고침
                        </button>
                    </div>
                    <canvas id="membershipChart" width="400" height="200"></canvas>
                </div>
                
                <div class="chart-container">
                    <div class="chart-title">
                        <i class="fas fa-star"></i>
                        날짜별 리뷰 통계 (최근 30일)
                    </div>
                    <canvas id="reviewChart" width="400" height="200"></canvas>
                </div>
            </div>
            
            <!-- Statistics Row -->
            <div class="dashboard-grid">
                <div class="stats-card">
                    <div class="stats-header">
                        <i class="fas fa-users"></i>
                        <h3>회원가입 통계</h3>
                    </div>
                    <div class="stats-content">
                        <div class="stats-item">
                            <div class="stats-label">
                                <i class="fas fa-user-plus"></i>
                                오늘 가입 회원수
                            </div>
                            <div class="stats-value today"><%= todaySignups %></div>
                        </div>
                        <div class="stats-item">
                            <div class="stats-label">
                                <i class="fas fa-users"></i>
                                누적 가입 회원수
                            </div>
                            <div class="stats-value total"><%= String.format("%,d", totalMembers) %></div>
                        </div>
                        <div class="stats-item">
                            <div class="stats-label">
                                <i class="fas fa-user-minus"></i>
                                탈퇴 회원수
                            </div>
                            <div class="stats-value withdrawn"><%= withdrawnMembers %></div>
                        </div>
                    </div>
                </div>
                
                <div class="stats-card">
                    <div class="stats-header">
                        <i class="fas fa-star"></i>
                        <h3>리뷰 통계</h3>
                    </div>
                    <div class="stats-content">
                        <div class="stats-item">
                            <div class="stats-label">
                                <i class="fas fa-edit"></i>
                                오늘 리뷰 작성수
                            </div>
                            <div class="stats-value today"><%= todayReviews %></div>
                        </div>
                        <div class="stats-item">
                            <div class="stats-label">
                                <i class="fas fa-comments"></i>
                                누적 리뷰 작성수
                            </div>
                            <div class="stats-value total"><%= String.format("%,d", totalReviews) %></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // JSP에서 JavaScript로 실제 데이터베이스 값 전달
        window.membershipData = {
            labels: [
                <% 
                if(dailySignups != null && dailySignups.size() > 0) {
                    for(int i = 0; i < dailySignups.size(); i++) {
                        Map<String, Object> data = dailySignups.get(i);
                        String date = (String) data.get("signup_date");
                        if(i > 0) out.print(",");
                        out.print("'" + date + "'");
                    }
                } else {
                    out.print("'데이터 없음'");
                }
                %>
            ],
            data: [
                <% 
                if(dailySignups != null && dailySignups.size() > 0) {
                    for(int i = 0; i < dailySignups.size(); i++) {
                        Map<String, Object> data = dailySignups.get(i);
                        Integer count = (Integer) data.get("signup_count");
                        if(i > 0) out.print(",");
                        out.print(count != null ? count : 0);
                    }
                } else {
                    out.print("0");
                }
                %>
            ]
        };
        
        window.reviewData = {
            labels: [
                <% 
                if(dailyReviews != null && dailyReviews.size() > 0) {
                    for(int i = 0; i < dailyReviews.size(); i++) {
                        Map<String, Object> data = dailyReviews.get(i);
                        String date = (String) data.get("review_date");
                        if(i > 0) out.print(",");
                        out.print("'" + date + "'");
                    }
                } else {
                    out.print("'데이터 없음'");
                }
                %>
            ],
            data: [
                <% 
                if(dailyReviews != null && dailyReviews.size() > 0) {
                    for(int i = 0; i < dailyReviews.size(); i++) {
                        Map<String, Object> data = dailyReviews.get(i);
                        Integer count = (Integer) data.get("review_count");
                        if(i > 0) out.print(",");
                        out.print(count != null ? count : 0);
                    }
                } else {
                    out.print("0");
                }
                %>
            ]
        };
        
        // 차트 객체 초기화
        window.membershipChart = null;
        window.reviewChart = null;
        
        // 디버깅용 콘솔 출력
        console.log("=== JSP에서 전달된 데이터 ===");
        console.log("오늘 가입자:", <%= todaySignups %>);
        console.log("전체 회원:", <%= totalMembers %>);
        console.log("탈퇴 회원:", <%= withdrawnMembers %>);
        console.log("오늘 리뷰:", <%= todayReviews %>);
        console.log("전체 리뷰:", <%= totalReviews %>);
        console.log("회원가입 차트 데이터:", window.membershipData);
        console.log("리뷰 차트 데이터:", window.reviewData);
    </script>
    
    <!-- 차트 스크립트는 데이터 정의 후에 로드 -->
    <script src="common/js/dashboard-charts.js" type="module"></script>
    <script src="script.js"></script>
</body>
</html>
