package restarea.detail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import DTO.AreaDetailReviewDTO;

public class RestAreaDetailReviewDAO {

	public List<AreaDetailReviewDTO> seleteAllReview(int area_num) throws SQLException{
		List<AreaDetailReviewDTO> list = new ArrayList<AreaDetailReviewDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = dbCon.getDbCon();
			
			StringBuilder selectQuery = new StringBuilder();
			selectQuery	.append(" SELECT * ")
						.append(" FROM REVIEW ")
						.append(" WHERE AREA_NUM = ?");
			
			pstmt = conn.prepareStatement(selectQuery.toString());
			
			// 바인드 변수 할당
			pstmt.setInt(1, area_num);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				AreaDetailReviewDTO adrDTO = new AreaDetailReviewDTO();
				adrDTO.setAcc_num(rs.getInt("ACC_NUM"));
				adrDTO.setRev_num(rs.getInt("REV_NUM"));
				adrDTO.setArea_num(rs.getInt("AREA_NUM"));
				adrDTO.setReport(rs.getInt("REPORT"));
				adrDTO.setContent(rs.getString("CONTENT"));
				adrDTO.setName(rs.getString("NAME"));
				adrDTO.setInput_date(rs.getDate("INPUT_DATE"));
				list.add(adrDTO);
			}// end while
			
		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		}// end try-finally
		
		return list;
	}// seleteAllReview
	
}// class
