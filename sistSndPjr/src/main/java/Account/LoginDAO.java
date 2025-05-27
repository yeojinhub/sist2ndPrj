package Account;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DBConnection.DBConnection;
import DTO.LoginDTO;

public class LoginDAO {

	public LoginDTO selectLogin(String email, String pass) throws SQLException {
		LoginDTO lDTO = null;

		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = null;

		DBConnection dbCon = DBConnection.getInstance();

		try {
			conn = dbCon.getDbCon();

			// SQL문 작성
			StringBuilder selectQuery = new StringBuilder();
			selectQuery
						.append("	SELECT NAME, TEL 	")
						.append("	FROM ACCOUNT WHERE USER_EMAIL = ? AND PASS = ?	");

			pstmt = conn.prepareStatement(selectQuery.toString());

			pstmt.setString(1, email);
			pstmt.setString(2, pass);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				lDTO = new LoginDTO();
				lDTO.setName(rs.getString("NAME"));
				lDTO.setTel(rs.getString("TEL"));
				lDTO.setUser_email(email);
				lDTO.setPass(pass);
			}// end if

		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		} // end try-finally

		return lDTO;
	}// selectLogin

}// class
