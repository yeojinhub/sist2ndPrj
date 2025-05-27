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

public class PetrolDAO {

	/**
	 * 모든 주유소 정보를 얻어오는 메소드
	 * @return
	 * @throws SQLException
	 */
	public List<PetrolDTO> selectAllPetrol() throws SQLException{
		List<PetrolDTO> list = new ArrayList<PetrolDTO>();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = null;

		DBConnection dbCon = DBConnection.getInstance();

		try {
			conn = dbCon.getDbCon();

			// SQL문 작성
			StringBuilder selectQuery = new StringBuilder();
			selectQuery.append(" SELECT A.AREA_NUM, NAME, A.TEL, ROUTE, GASOLINE, DIESEL, LPG, ELECT, HYDRO")
						.append(" FROM AREA A, PETROL P")
						.append(" WHERE A.AREA_NUM = P.AREA_NUM ");

			pstmt = conn.prepareStatement(selectQuery.toString());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				PetrolDTO pDTO = new PetrolDTO();
				pDTO.setArea_num(rs.getInt("AREA_NUM"));
				pDTO.setName(rs.getString("NAME"));
				pDTO.setTel(rs.getString("TEL"));
				pDTO.setRoute(rs.getString("ROUTE"));
				pDTO.setGasoline(rs.getString("GASOLINE"));
				pDTO.setDiesel(rs.getString("DIESEL"));
				pDTO.setLpg(rs.getString("LPG"));
				pDTO.setElect(rs.getString("ELECT"));
				pDTO.setHydro(rs.getString("HYDRO"));
				list.add(pDTO);
			}// end while

		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		} // end try-finally
		
		return list;
	}// selectAllPetrol
	
}// class
