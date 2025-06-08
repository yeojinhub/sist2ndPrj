package user.account.login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import user.DBConnection.DBConnection;

public class LoginDAO {

	/**
	 * 사용자로부터 이메일과 비밀번호를 입력받아 일치하는 데이터 조회.
	 * @param email 입력받은 이메일
	 * @param pass 입력받은 비밀번호
	 * @return 데이터 유무, 아이디와 비밀번호가 일치하지 않는다면 lDTO는 null 이다.
	 * @throws SQLException
	 */
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
						.append("	SELECT ACC_NUM ,NAME, TEL 	")
						.append("	FROM ACCOUNT WHERE USER_EMAIL = ? AND PASS = ?	");

			pstmt = conn.prepareStatement(selectQuery.toString());

			pstmt.setString(1, email);
			pstmt.setString(2, pass);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				lDTO = new LoginDTO();
				lDTO.setAcc_num(rs.getInt("ACC_NUM"));
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
	
	public boolean selectCheckWithdraw(String email) throws SQLException{
		boolean chkWithdraw = false;
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = null;

		DBConnection dbCon = DBConnection.getInstance();

		try {
			conn = dbCon.getDbCon();

			// SQL문 작성
			StringBuilder selectQuery = new StringBuilder();
			selectQuery
						.append("	SELECT WITHDRAW 	")
						.append("	FROM ACCOUNT WHERE USER_EMAIL = ?	");

			pstmt = conn.prepareStatement(selectQuery.toString());

			pstmt.setString(1, email);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				chkWithdraw = rs.getString("WITHDRAW").equals("Y");
			}// end if
			
		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		} // end try-finally
		
		return chkWithdraw;
	}

}// class