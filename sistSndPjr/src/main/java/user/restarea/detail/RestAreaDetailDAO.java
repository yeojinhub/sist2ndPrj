package user.restarea.detail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import user.DBConnection.DBConnection;

public class RestAreaDetailDAO {

	/**
	 * ID 파라미터로 디테일 조회
	 * 
	 * @param num ID파라미터
	 * @return
	 * @throws SQLException
	 */
	public AreaDetailDTO selectRestAreaDetail(int num) throws SQLException {
		AreaDetailDTO adDTO = null;

		DBConnection dbCon = DBConnection.getInstance();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = dbCon.getDbCon();

			StringBuilder selectQuery = new StringBuilder();
			selectQuery.append(
				    " SELECT AREA_NUM, NAME, ROUTE, ADDR, TEL, OPERATION_TIME, LAT, LNG, FEED, SLEEP, SHOWER, LAUNDRY, CLINIC, PHARMACY, SHELTER, SALON, REPAIR, TRUCK, TEMP ")
				    .append(" FROM AREA ")
				    .append(" WHERE AREA_NUM = ? ");

			pstmt = conn.prepareStatement(selectQuery.toString());

			// 바인드 변수 할당
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				adDTO = new AreaDetailDTO();
				adDTO.setArea_num(rs.getInt("AREA_NUM"));
				adDTO.setOriginalName(rs.getString("NAME"));
				adDTO.setName(rs.getString("NAME"));
				adDTO.setRoute(rs.getString("ROUTE"));
				adDTO.setAddr(rs.getString("ADDR"));
				adDTO.setTel(rs.getString("TEL"));
				adDTO.setOperation_time(rs.getString("OPERATION_TIME"));
				adDTO.setLat(rs.getFloat("LAT"));
				adDTO.setLng(rs.getFloat("LNG"));
				adDTO.setFeed(rs.getString("FEED"));
				adDTO.setSleep(rs.getString("SLEEP"));
				adDTO.setShower(rs.getString("SHOWER"));
				adDTO.setLaundry(rs.getString("LAUNDRY"));
				adDTO.setClinic(rs.getString("CLINIC"));
				adDTO.setPharmacy(rs.getString("PHARMACY"));
				adDTO.setShelter(rs.getString("SHELTER"));
				adDTO.setSalon(rs.getString("SALON"));
				adDTO.setRepair(rs.getString("REPAIR"));
				adDTO.setTruck(rs.getString("TRUCK"));
				adDTO.setTemp(rs.getString("TEMP"));
			} // end if

		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		} // end try-finally

		return adDTO;
	}// selectRestAreaDetail

	/**
	 * 현재 로그인한 유저가 해당 휴게소를 즐겨찾기에 추가 했는지 확인합니다.
	 * 
	 * @param email
	 * @param area_num
	 * @return
	 * @throws SQLException
	 */
	public boolean selectFavorite(String email, int area_num) throws SQLException {
		boolean flag = false;

		DBConnection dbCon = DBConnection.getInstance();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = dbCon.getDbCon();

			StringBuilder selectQuery = new StringBuilder();
			selectQuery.append(" SELECT * ").append(" FROM (SELECT A.ACC_NUM, USER_EMAIL ,AREA_NUM ")
					.append(" 		FROM ACCOUNT A, FAVORITE F ").append(" 		WHERE A.ACC_NUM = F.ACC_NUM) ")
					.append(" WHERE USER_EMAIL = ? AND AREA_NUM = ? ");

			pstmt = conn.prepareStatement(selectQuery.toString());

			// 바인드 변수 할당
			pstmt.setString(1, email);
			pstmt.setInt(2, area_num);

			rs = pstmt.executeQuery();

			flag = rs.next();

		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		} // end try-finally

		return flag;
	}// selectFavorite

	public boolean insertFavorite(String restareaName, int acc_num, int area_num) throws SQLException {
		boolean flag = false;

		DBConnection dbCon = DBConnection.getInstance();

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = dbCon.getDbCon();

			StringBuilder insertQuery = new StringBuilder();
			insertQuery.append(" INSERT INTO FAVORITE ").append(" VALUES(SEQ_FAV_NUM.NEXTVAL, ?, ?, ?) ");

			pstmt = conn.prepareStatement(insertQuery.toString());

			// 바인드 변수 할당
			pstmt.setString(1, restareaName);
			pstmt.setInt(2, acc_num);
			pstmt.setInt(3, area_num);

			flag = pstmt.executeUpdate() != 0;

		} finally {
			dbCon.dbClose(conn, pstmt, null);
		} // end try-finally

		return flag;
	}// insertFavorite

	public boolean deleteFavorite(int acc_num, int area_num) throws SQLException {
		boolean flag = false;

		DBConnection dbCon = DBConnection.getInstance();

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = dbCon.getDbCon();

			StringBuilder insertQuery = new StringBuilder();
			insertQuery
			.append(" DELETE FROM FAVORITE ")
			.append(" WHERE ACC_NUM = ? AND AREA_NUM = ? ");

			pstmt = conn.prepareStatement(insertQuery.toString());

			// 바인드 변수 할당
			pstmt.setInt(1, acc_num);
			pstmt.setInt(2, area_num);

			flag = pstmt.executeUpdate() != 0;

		} finally {
			dbCon.dbClose(conn, pstmt, null);
		} // end try-finally

		return flag;
	}// deleteFavorite

}// class
