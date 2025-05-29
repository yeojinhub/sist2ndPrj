package GasStation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import DTO.LoginDTO;
import DTO.PetrolDTO;
import DTO.RangeDTO;

public class PetrolDAO {
	
	/**
	 * 주유소 페이지에 <select> 태그 <option>으로 사용할 노선 구하기 (중복 제거)
	 * @return
	 * @throws SQLException
	 */
	public List<String> selectAllRoute(RangeDTO rDTO) throws SQLException{
		List<String> list = new ArrayList<String>();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = null;

		DBConnection dbCon = DBConnection.getInstance();

		try {
			conn = dbCon.getDbCon();

			// SQL문 작성
			String selectQuery = "SELECT DISTINCT ROUTE FROM AREA";
			pstmt = conn.prepareStatement(selectQuery);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				list.add(rs.getString("ROUTE"));
			}// end while

		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		} // end try-finally
		
		return list;
	}// selectAllRoute
	
	/**
	 * 모든 주유소 정보를 얻어오는 메소드
	 * @return
	 * @throws SQLException
	 */
	public List<PetrolDTO> selectAllPetrol(RangeDTO rDTO) throws SQLException{
		List<PetrolDTO> list = new ArrayList<PetrolDTO>();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = null;

		DBConnection dbCon = DBConnection.getInstance();

		try {
			conn = dbCon.getDbCon();

			// SQL문 작성
			StringBuilder selectQuery = new StringBuilder();
			selectQuery.append(" SELECT * FROM")
						.append(" (SELECT A.AREA_NUM, NAME, A.TEL, ROUTE, GASOLINE, DIESEL, LPG, ELECT, HYDRO")
						.append(" FROM AREA A, PETROL P")
						.append(" WHERE A.AREA_NUM = P.AREA_NUM AND A.AREA_NUM BETWEEN ? AND ?) ");
			
			if (rDTO.getRoute() != null) {
				selectQuery.append(" WHERE INSTR(ROUTE,?) != 0 ");
			}// end if
			
			if (rDTO.getRoute() != null && rDTO.getKeyword() != null) {
				selectQuery.append(" AND INSTR(NAME,?) != 0 ");
			}// end if
			
			if (rDTO.getElect() != null && rDTO.getElect().equals("O")) {
				selectQuery.append(" AND ELECT = 'O' ");
			}// end if
			
			if (rDTO.getHydro() != null && rDTO.getHydro().equals("O")) {
				selectQuery.append(" AND HYDRO = 'O' ");
			}// end if
			
			System.out.println(rDTO);
			System.out.println(selectQuery.toString());
			
//			pstmt = conn.prepareStatement(selectQuery.toString());
//			
//			int bindParam = 1;
//			// 바인드 변수 할당
//			pstmt.setInt(bindParam++, rDTO.getStartNum());
//			pstmt.setInt(bindParam++, rDTO.getEndNum());
//			
//			if (rDTO.getRoute() != null) {
//				pstmt.setString(bindParam++, rDTO.getRoute());
//			}// end if
//			
//			if (rDTO.getRoute() != null && rDTO.getKeyword() != null) {
//				pstmt.setString(bindParam++, rDTO.getRoute());
//				pstmt.setString(bindParam++, rDTO.getRoute());
//			}// end if
//			
//			
//			rs = pstmt.executeQuery();
//
//			while (rs.next()) {
//				PetrolDTO pDTO = new PetrolDTO();
//				pDTO.setArea_num(rs.getInt("AREA_NUM"));
//				pDTO.setName(rs.getString("NAME"));
//				pDTO.setTel(rs.getString("TEL"));
//				pDTO.setRoute(rs.getString("ROUTE"));
//				pDTO.setGasoline(rs.getString("GASOLINE"));
//				pDTO.setDiesel(rs.getString("DIESEL"));
//				pDTO.setLpg(rs.getString("LPG"));
//				pDTO.setElect(rs.getString("ELECT"));
//				pDTO.setHydro(rs.getString("HYDRO"));
//				list.add(pDTO);
//			}// end while

		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		} // end try-finally
		
		return list;
	}// selectAllPetrol
	
	/****************** pagination ***********************/
	
	/**
	 * 1. 총 레코드(데이터)의 수를 구합니다.
	 * @return
	 * @throws SQLException
	 */
	public int selectTotalCount() throws SQLException{
		int cnt = 0;
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = null;

		DBConnection dbCon = DBConnection.getInstance();

		try {
			conn = dbCon.getDbCon();

			// SQL문 작성
			StringBuilder selectQuery = new StringBuilder();
			selectQuery.append(" SELECT COUNT(*) CNT ")
						.append(" FROM PETROL ");

			pstmt = conn.prepareStatement(selectQuery.toString());

			rs = pstmt.executeQuery();

			if (rs.next()) {
				cnt = rs.getInt("CNT");
			}// end if
			
		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		} // end try-finally
		
		return cnt;
	}// selectTotalCount
	
	/****************** pagination ***********************/
	
}// class
