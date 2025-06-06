package Review;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import Pagination.PaginationDTO;

public class ReviewDAO {
    private static ReviewDAO reviewDAO;

    private ReviewDAO() {}

    public static ReviewDAO getInstance() {
        if(reviewDAO == null) {
            reviewDAO = new ReviewDAO();
        }
        return reviewDAO;
    }

    public int getTotalReviewCount() throws SQLException {
    	
    	StringBuilder reviewCnt=new StringBuilder();
    	reviewCnt
    	.append("SELECT COUNT(*) AS total_count	")
    	.append("FROM REVIEW	");
    	
        try (Connection conn = DBConnection.getInstance().getDbCon();
             PreparedStatement pstmt = conn.prepareStatement(reviewCnt.toString());
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total_count");
            }
        }
        return 0;
    }

    public List<ReviewDTO> selectReviewsByPage(PaginationDTO pagination) throws SQLException {
        List<ReviewDTO> reviewList = new ArrayList<>();

        StringBuilder reviewListArray = new StringBuilder();
        reviewListArray
        	.append("SELECT r.*, ar.name AS area_name ")
        	.append("FROM ( ")
        	.append("    SELECT rev_num, content, name, input_date, report, hidden_type, area_num, acc_num, ")
        	.append("           ROW_NUMBER() OVER (ORDER BY input_date DESC, rev_num DESC) AS rnum ")
        	.append("    FROM REVIEW ")
        	.append(") r ")
        	.append("JOIN AREA ar ON r.area_num = ar.area_num ")
        	.append("WHERE r.rnum BETWEEN ? AND ?");

        try (Connection conn = DBConnection.getInstance().getDbCon();
             PreparedStatement pstmt = conn.prepareStatement(reviewListArray.toString())) {

        	pstmt.setInt(1, pagination.getStartRowNum());
        	pstmt.setInt(2, pagination.getEndRowNum());

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ReviewDTO rvDTO = new ReviewDTO();
                    rvDTO.setRev_num(rs.getInt("rev_num"));
                    rvDTO.setContent(rs.getString("content"));
                    rvDTO.setName(rs.getString("name"));
                    rvDTO.setInput_date(rs.getDate("input_date"));
                    rvDTO.setReport(rs.getInt("report"));
                    rvDTO.setHidden_type(rs.getString("hidden_type"));
                    rvDTO.setArea_num(rs.getInt("area_num"));
                    rvDTO.setAcc_num(rs.getInt("acc_num"));
                    rvDTO.setArea_name(rs.getString("area_name"));

                    reviewList.add(rvDTO);
                }
            }
        }

        return reviewList;
    }
    
	//detail로 넘어가는 것
	public ReviewDTO getReviewOne(int revNum) {
		
		ReviewDTO rvDTO=null;
		
		DBConnection dbCon = DBConnection.getInstance();

		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs=null;
		
		StringBuilder reviewOne = new StringBuilder();
		reviewOne
		.append(" SELECT r.REV_NUM, r.CONTENT, a.NAME AS name, r.INPUT_DATE, r.HIDDEN_TYPE, ")
		.append(" r.ACC_NUM, ra.NAME AS AREA_NAME , r.AREA_NUM ")
		.append(" FROM REVIEW r ")
		.append(" JOIN ACCOUNT a ON r.ACC_NUM = a.ACC_NUM ")
		.append(" LEFT JOIN AREA ra ON r.AREA_NUM = ra.AREA_NUM ")
		.append(" WHERE r.REV_NUM = ? ");
	    
		
		try {
			conn = dbCon.getDbCon();
			pstmt = conn.prepareStatement(reviewOne.toString());
			pstmt.setInt(1,revNum);
			rs = pstmt.executeQuery();

			if(rs.next()) {
	            rvDTO = new ReviewDTO();
	            rvDTO.setRev_num(rs.getInt("REV_NUM"));
	            rvDTO.setContent(rs.getString("CONTENT"));
	            rvDTO.setName(rs.getString("name"));
	            rvDTO.setInput_date(rs.getDate("INPUT_DATE"));
	            rvDTO.setHidden_type(rs.getString("HIDDEN_TYPE"));
	            rvDTO.setAcc_num(rs.getInt("ACC_NUM"));
	            rvDTO.setArea_name(rs.getString("AREA_NAME"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				dbCon.dbClose(conn, pstmt, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rvDTO;
	}//getReivewOne
	
	//HiddenType
	public int updateHiddenType(int revNum, String hiddenType) throws SQLException {
		StringBuilder hiddenUpadte=new StringBuilder();
		hiddenUpadte
		.append("UPDATE REVIEW	")
		.append("SET HIDDEN_TYPE = ? ")
		.append("WHERE REV_NUM = ?	");
		
	    try (Connection conn = DBConnection.getInstance().getDbCon();
	         PreparedStatement pstmt = conn.prepareStatement(hiddenUpadte.toString())) {
	        pstmt.setString(1, hiddenType);
	        pstmt.setInt(2, revNum);
	        return pstmt.executeUpdate();
	    }
	}
	
	//검색창
	
	public int getSearchReviewCount(String hiddenType) throws SQLException {
	    int totalCount = 0;

	    DBConnection dbCon = DBConnection.getInstance();

	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    Connection con = null;

	    try {
	        con = dbCon.getDbCon();

	        StringBuilder countQuery = new StringBuilder();
	        countQuery
	            .append(" SELECT COUNT(*) as total_count ")
	            .append(" FROM REVIEW ")
	            .append(" WHERE 1=1 ");

	        List<String> paramList = new ArrayList<>();

	        if (hiddenType != null && !hiddenType.trim().isEmpty() && !"all".equals(hiddenType)) {
	            countQuery.append(" AND hidden_type = ? ");
	            paramList.add(hiddenType);
	        }

	        pstmt = con.prepareStatement(countQuery.toString());

	        for (int i = 0; i < paramList.size(); i++) {
	            pstmt.setString(i + 1, paramList.get(i));
	        }

	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            totalCount = rs.getInt("total_count");
	        }

	    } finally {
	        dbCon.dbClose(con, pstmt, rs);
	    }

	    return totalCount;
	}
	
	//조건펼 목록 조회
	public List<ReviewDTO> searchReviewByPage(String hiddenType, PaginationDTO pagination) throws SQLException {
	    List<ReviewDTO> reviewList = new ArrayList<>();

	    DBConnection dbCon = DBConnection.getInstance();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        con = dbCon.getDbCon();

	        StringBuilder sql = new StringBuilder();
	        sql.append(" SELECT * FROM ( ")
	           .append("   SELECT ROWNUM AS rnum, rev_num, content, name, area_name, input_date, hidden_type, report ")
	           .append("   FROM ( ")
	           .append("     SELECT r.rev_num, r.content, a.name, ar.name AS area_name, r.input_date, r.hidden_type, r.report ")
	           .append("     FROM REVIEW r ")
	           .append("     JOIN ACCOUNT a ON r.acc_num = a.acc_num ")
	           .append("     LEFT JOIN AREA ar ON r.area_num = ar.area_num ")
	           .append("     WHERE 1=1 ");

	        List<String> paramList = new ArrayList<>();
	        if (hiddenType != null && !hiddenType.trim().isEmpty() && !"all".equalsIgnoreCase(hiddenType)) {
	            sql.append(" AND r.hidden_type = ? ");
	            paramList.add(hiddenType);
	        }

	        sql.append("     ORDER BY r.input_date DESC ")
	           .append("   ) ")
	           .append("   WHERE ROWNUM <= ? ")
	           .append(" ) WHERE rnum >= ? ");

	        pstmt = con.prepareStatement(sql.toString());

	        int paramIndex = 1;
	        for (String param : paramList) {
	            pstmt.setString(paramIndex++, param);
	        }

	        pstmt.setInt(paramIndex++, pagination.getEndRowNum());
	        pstmt.setInt(paramIndex, pagination.getStartRowNum());

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            ReviewDTO review = new ReviewDTO();
	            review.setRev_num(rs.getInt("rev_num"));
	            review.setContent(rs.getString("content"));
	            review.setName(rs.getString("name"));
	            review.setArea_name(rs.getString("area_name"));
	            review.setInput_date(rs.getDate("input_date"));
	            review.setHidden_type(rs.getString("hidden_type"));
	            review.setReport(rs.getInt("report"));

	            reviewList.add(review);
	        }

	    } finally {
	        dbCon.dbClose(con, pstmt, rs);
	    }

	    return reviewList;
	}


    
}
