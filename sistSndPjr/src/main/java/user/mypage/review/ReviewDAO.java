package user.mypage.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import user.DBConnection.DBConnection;



public class ReviewDAO {
	
	public List<ReviewDTO> selectReviewByEmailWithPaging(String email, int startRow, int endRow) throws SQLException {
	    List<ReviewDTO> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    DBConnection dbCon = DBConnection.getInstance();

	    try {
	        conn = dbCon.getDbCon();

	        StringBuilder sql = new StringBuilder();
	        sql.append("SELECT * FROM (")
	           .append("    SELECT ROWNUM rnum, inner_query.* FROM (")
	           .append("        SELECT r.rev_num, r.content, r.input_date, a.name AS area_name ")
	           .append("          FROM review r ")
	           .append("          JOIN area a ON r.area_num = a.area_num ")
	           .append("         WHERE r.acc_num = (SELECT acc_num FROM account WHERE user_email = ?) ")
	           .append("         ORDER BY r.input_date DESC ")
	           .append("    ) inner_query ")
	           .append(") ")
	           .append("WHERE rnum BETWEEN ? AND ?");

	        pstmt = conn.prepareStatement(sql.toString());
	        pstmt.setString(1, email);
	        pstmt.setInt(2, startRow);
	        pstmt.setInt(3, endRow);

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            ReviewDTO dto = new ReviewDTO();
	            dto.setRev_num(rs.getInt("rev_num"));
	            dto.setArea_name(rs.getString("area_name"));
	            dto.setContent(rs.getString("content"));
	            dto.setInput_date(rs.getDate("input_date"));
	            list.add(dto);
	        }

	    } finally {
	        dbCon.dbClose(conn, pstmt, rs);
	    }

	    return list;
	}

	
	public int selectReviewCnt(String email) throws SQLException {
        int cnt = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        DBConnection dbCon = DBConnection.getInstance();

        try {
            conn = dbCon.getDbCon();
            String sql = "SELECT COUNT(*) FROM review WHERE acc_num = (SELECT acc_num FROM account WHERE user_email = ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                cnt = rs.getInt(1);
            }

        } finally {
            dbCon.dbClose(conn, pstmt, rs);
        }

        return cnt;
    }
	public ReviewDTO selectReviewByNum (int revNum) throws SQLException{
		ReviewDTO rDTO = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		try {
			conn = dbCon.getDbCon();
			
			StringBuilder selectQuery = new StringBuilder();
			selectQuery.append("SELECT r.rev_num, r.content, r.input_date, a.name AS area_name, ")
            .append("r.name as user_name FROM review r ")
            .append("JOIN area a ON r.area_num = a.area_num ")
            .append("WHERE r.rev_num = ?");
			
			pstmt = conn.prepareStatement(selectQuery.toString());
	        pstmt.setInt(1, revNum);
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	            rDTO = new ReviewDTO();
	            rDTO.setRev_num(rs.getInt("rev_num"));
	            rDTO.setContent(rs.getString("content"));
	            rDTO.setUser_name(rs.getString("user_name"));
	            rDTO.setInput_date(rs.getDate("input_date"));
	            rDTO.setArea_name(rs.getString("area_name"));
	        }
		}finally {
			dbCon.dbClose(conn, pstmt, rs);
		}
		
		return rDTO;
	}
	
	public void deleteReviewByNum(int revNum) throws SQLException{
		Connection conn= null;
		PreparedStatement pstmt = null;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		try {
			conn = dbCon.getDbCon();
			
			StringBuilder deleteQuery = new StringBuilder();
			deleteQuery.append("DELETE FROM REVIEW	").
			append("WHERE REV_NUM = ?	");
			
			pstmt = conn.prepareStatement(deleteQuery.toString());
			pstmt.setInt(1, revNum);
			
			pstmt.executeUpdate();
		}finally {
			dbCon.dbClose(conn, pstmt, null);
		}
	}
	
	public void updateReview(int revNum, String newContent) throws SQLException {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    
	    DBConnection dbCon = DBConnection.getInstance();
	    
	    try {
	    	conn = dbCon.getDbCon();
	    	
	    	StringBuilder updateQuery = new StringBuilder();
	    	updateQuery.append("UPDATE review ")
	             .append("SET content = ?, input_date = SYSDATE ")
	             .append("WHERE rev_num = ?");

	        pstmt = conn.prepareStatement(updateQuery.toString());
	        pstmt.setString(1, newContent);
	        pstmt.setInt(2, revNum);

	        pstmt.executeUpdate();
	    }finally {
	        dbCon.dbClose(conn, pstmt, null);
	    }
	}
}