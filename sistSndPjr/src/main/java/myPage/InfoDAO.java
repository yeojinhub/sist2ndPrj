package myPage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DBConnection.DBConnection;
import DTO.InfoDTO;
import DTO.LoginDTO;

public class InfoDAO {
	public InfoDTO selectInfo (String email) throws SQLException {
		InfoDTO iDTO = null;
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		DBConnection dbCon = DBConnection.getInstance();

		try {
			conn = dbCon.getDbCon();

			// SQL문 작성
			StringBuilder selectQuery = new StringBuilder();
			selectQuery
						.append("	SELECT NAME, EMAIL ,TEL 	")
						.append("	FROM ACCOUNT WHERE USER_EMAIL = ?	");

			pstmt = conn.prepareStatement(selectQuery.toString());


			rs = pstmt.executeQuery();

			if (rs.next()) {
				iDTO = new InfoDTO();
				
			}// end if

		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		} // end try-finally
		
		return iDTO;
	}
}
