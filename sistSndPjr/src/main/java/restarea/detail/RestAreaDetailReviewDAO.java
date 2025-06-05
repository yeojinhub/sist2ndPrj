package restarea.detail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import DTO.AreaDetailReviewDTO;
import DTO.AreaDetailReviewRangeDTO;
import DTO.LoginDTO;

public class RestAreaDetailReviewDAO {

	public List<AreaDetailReviewDTO> seleteAllReview(int area_num, AreaDetailReviewRangeDTO adrrDTO)
			throws SQLException {
		List<AreaDetailReviewDTO> list = new ArrayList<AreaDetailReviewDTO>();

		DBConnection dbCon = DBConnection.getInstance();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = dbCon.getDbCon();

			StringBuilder selectQuery = new StringBuilder();
			selectQuery.append(" SELECT * ").append(
					" FROM (SELECT REV_NUM, CONTENT, NAME, INPUT_DATE, REPORT, HIDDEN_TYPE, AREA_NUM, ACC_NUM, ROW_NUMBER() OVER(ORDER BY INPUT_DATE) RNUM ")
					.append(" FROM REVIEW ").append(" WHERE AREA_NUM = ? AND HIDDEN_TYPE = 'N') ")
					.append(" WHERE RNUM BETWEEN ? AND ? ");

			pstmt = conn.prepareStatement(selectQuery.toString());

			// 바인드 변수 할당
			pstmt.setInt(1, area_num);
			pstmt.setInt(2, adrrDTO.getStartNum());
			pstmt.setInt(3, adrrDTO.getEndNum());

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
			} // end while

		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		} // end try-finally

		return list;
	}// seleteAllReview

	public boolean insertReview(int area_num, String msg, LoginDTO lDTO) throws SQLException {
		boolean flag = false;

		DBConnection dbCon = DBConnection.getInstance();

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = dbCon.getDbCon();

			StringBuilder insertQuery = new StringBuilder();
			insertQuery.append(" INSERT INTO REVIEW(REV_NUM, CONTENT, NAME, AREA_NUM, ACC_NUM) ")
					.append(" VALUES(SEQ_REV_NUM.NEXTVAL, ?, ?, ?, ?) ");

			pstmt = conn.prepareStatement(insertQuery.toString());

			// 바인드 변수 할당
			pstmt.setString(1, msg);
			pstmt.setString(2, lDTO.getName());
			pstmt.setInt(3, area_num);
			pstmt.setInt(4, lDTO.getAcc_num());

			flag = pstmt.executeUpdate() != 0;

		} finally {
			dbCon.dbClose(conn, pstmt, null);
		} // end try-finally

		return flag;
	}// insertReview

	public boolean updateReviewReport(int rev_num) throws SQLException {
		boolean flag = false;

		DBConnection dbCon = DBConnection.getInstance();

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = dbCon.getDbCon();

			StringBuilder insertQuery = new StringBuilder();
			insertQuery	.append(" UPDATE REVIEW SET REPORT = REPORT + 1 ")
						.append(" WHERE REV_NUM = ? ");

			pstmt = conn.prepareStatement(insertQuery.toString());

			// 바인드 변수 할당
			pstmt.setInt(1, rev_num);

			flag = pstmt.executeUpdate() != 0;

		} finally {
			dbCon.dbClose(conn, pstmt, null);
		} // end try-finally

		return flag;
	}// updateReviewReport

	/*********************************
	 * pagination
	 ************************************/

	/**
	 * 1. 총 게시물(데이터) 카운트 구하기.
	 * 
	 * @param id 휴게소넘버
	 * @return
	 * @throws SQLException
	 */
	public int selectTotalCount(int id) throws SQLException {
		int cnt = 0;

		DBConnection dbCon = DBConnection.getInstance();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = dbCon.getDbCon();

			StringBuilder selectQuery = new StringBuilder();
			selectQuery.append(" SELECT COUNT(*) CNT ").append(" FROM REVIEW ").append(" WHERE AREA_NUM = ?");

			pstmt = conn.prepareStatement(selectQuery.toString());

			// 바인드 변수 할당
			pstmt.setInt(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				cnt = rs.getInt("CNT");
			} // end if

		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		} // end try-finally

		return cnt;
	}// selectTotalCount

	/*********************************
	 * pagination
	 ************************************/

}// class
