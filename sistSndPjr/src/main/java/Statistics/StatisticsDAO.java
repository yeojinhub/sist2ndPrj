package Statistics;

import java.sql.*;
import java.util.*;
import java.util.Date;
import java.text.SimpleDateFormat;
import DBConnection.DBConnection;

public class StatisticsDAO {
    
    private static StatisticsDAO sDAO;
    
    private StatisticsDAO() {
    }
    
    public static StatisticsDAO getInstance() {
        if (sDAO == null) {
            sDAO = new StatisticsDAO();
        }
        return sDAO;
    }
    
    // 오늘 가입한 회원 수
    public int getTodaySignups() throws SQLException {
        int count = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        DBConnection db = DBConnection.getInstance();
        
        try {
            con = db.getDbCon();
            
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT COUNT(*) as cnt ")
               .append("FROM ACCOUNT ")
               .append("WHERE TRUNC(INPUT_DATE) = TRUNC(SYSDATE) ")
               .append("AND WITHDRAW = 'N'");
            
            pstmt = con.prepareStatement(sql.toString());
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                count = rs.getInt("cnt");
            }
        } finally {
            db.dbClose(con, pstmt, rs);
        }
        
        return count;
    }
    
    // 전체 회원 수 (탈퇴하지 않은 회원)
    public int getTotalMembers() throws SQLException {
        int count = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        DBConnection db = DBConnection.getInstance();
        
        try {
            con = db.getDbCon();
            
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT COUNT(*) as cnt ")
               .append("FROM ACCOUNT ")
               .append("WHERE WITHDRAW = 'N'");
            
            pstmt = con.prepareStatement(sql.toString());
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                count = rs.getInt("cnt");
            }
        } finally {
            db.dbClose(con, pstmt, rs);
        }
        
        return count;
    }
    
    // 탈퇴한 회원 수
    public int getWithdrawnMembers() throws SQLException {
        int count = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        DBConnection db = DBConnection.getInstance();
        
        try {
            con = db.getDbCon();
            
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT COUNT(*) as cnt ")
               .append("FROM ACCOUNT ")
               .append("WHERE WITHDRAW = 'Y'");
            
            pstmt = con.prepareStatement(sql.toString());
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                count = rs.getInt("cnt");
            }
        } finally {
            db.dbClose(con, pstmt, rs);
        }
        
        return count;
    }
    
    // 오늘 작성된 리뷰 수
    public int getTodayReviews() throws SQLException {
        int count = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        DBConnection db = DBConnection.getInstance();
        
        try {
            con = db.getDbCon();
            
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT COUNT(*) as cnt ")
               .append("FROM REVIEW ")
               .append("WHERE TRUNC(INPUT_DATE) = TRUNC(SYSDATE)");
            
            pstmt = con.prepareStatement(sql.toString());
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                count = rs.getInt("cnt");
            }
        } finally {
            db.dbClose(con, pstmt, rs);
        }
        
        return count;
    }
    
    // 전체 리뷰 수
    public int getTotalReviews() throws SQLException {
        int count = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        DBConnection db = DBConnection.getInstance();
        
        try {
            con = db.getDbCon();
            
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT COUNT(*) as cnt ")
               .append("FROM REVIEW");
            
            pstmt = con.prepareStatement(sql.toString());
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                count = rs.getInt("cnt");
            }
        } finally {
            db.dbClose(con, pstmt, rs);
        }
        
        return count;
    }
    
    // 날짜별 회원가입 통계 (최근 N일)
    public List<Map<String, Object>> getDailySignupStats(int days) throws SQLException {
        List<Map<String, Object>> result = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        DBConnection db = DBConnection.getInstance();
        
        try {
            con = db.getDbCon();
            
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT TRUNC(INPUT_DATE) as signup_date, COUNT(*) as signup_count ")
               .append("FROM ACCOUNT ")
               .append("WHERE INPUT_DATE >= TRUNC(SYSDATE) - ? ")
               .append("AND WITHDRAW = 'N' ")
               .append("GROUP BY TRUNC(INPUT_DATE) ")
               .append("ORDER BY signup_date ASC");
            
            pstmt = con.prepareStatement(sql.toString());
            pstmt.setInt(1, days);
            rs = pstmt.executeQuery();
            
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd");
            
            while(rs.next()) {
                Map<String, Object> data = new HashMap<>();
                Date date = rs.getDate("signup_date");
                data.put("signup_date", sdf.format(date));
                data.put("signup_count", rs.getInt("signup_count"));
                result.add(data);
            }
        } finally {
            db.dbClose(con, pstmt, rs);
        }
        
        return result;
    }
    
    // 날짜별 리뷰 작성 통계 (최근 N일)
    public List<Map<String, Object>> getDailyReviewStats(int days) throws SQLException {
        List<Map<String, Object>> result = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        DBConnection db = DBConnection.getInstance();
        
        try {
            con = db.getDbCon();
            
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT TRUNC(INPUT_DATE) as review_date, COUNT(*) as review_count ")
               .append("FROM REVIEW ")
               .append("WHERE INPUT_DATE >= TRUNC(SYSDATE) - ? ")
               .append("GROUP BY TRUNC(INPUT_DATE) ")
               .append("ORDER BY review_date ASC");
            
            pstmt = con.prepareStatement(sql.toString());
            pstmt.setInt(1, days);
            rs = pstmt.executeQuery();
            
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd");
            
            while(rs.next()) {
                Map<String, Object> data = new HashMap<>();
                Date date = rs.getDate("review_date");
                data.put("review_date", sdf.format(date));
                data.put("review_count", rs.getInt("review_count"));
                result.add(data);
            }
        } finally {
            db.dbClose(con, pstmt, rs);
        }
        
        return result;
    }
}