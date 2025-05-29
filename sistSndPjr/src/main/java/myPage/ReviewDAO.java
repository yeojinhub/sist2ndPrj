package myPage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import DTO.ReviewDTO;

public class ReviewDAO {
	public List<ReviewDTO> selectReviewByEmail(String email) throws SQLException {
	    List<ReviewDTO> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    DBConnection dbCon = DBConnection.getInstance();

	    try {
	        conn = dbCon.getDbCon();

	        StringBuilder selectQuery = new StringBuilder();
	        selectQuery.append("SELECT r.rev_num, r.content, r.input_date, a.name AS area_name ")
	           .append("FROM review r ")
	           .append("JOIN area a ON r.area_num = a.area_num ")
	           .append("WHERE r.acc_num = ( ")
	           .append("    SELECT acc_num FROM account WHERE user_email = ? ")
	           .append(") ")
	           .append("ORDER BY r.input_date DESC");

	        pstmt = conn.prepareStatement(selectQuery.toString());
	        pstmt.setString(1, email);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            ReviewDTO rDTO = new ReviewDTO();
	            rDTO.setRev_num(rs.getInt("rev_num"));
	            rDTO.setContent(rs.getString("content"));
	            rDTO.setInput_date(rs.getDate("input_date"));
	            rDTO.setArea_name(rs.getString("area_name"));  // DTO에 맞게 이름 맞춰줘
	            list.add(rDTO);
	        }

	    } finally {
	        dbCon.dbClose(conn, pstmt, rs);;
	    }

	    return list;
	}

}
