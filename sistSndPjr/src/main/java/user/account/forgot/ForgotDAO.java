package user.account.forgot;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import user.DBConnection.DBConnection;

public class ForgotDAO {

	public boolean selectEmailCheck(String email) throws SQLException{
		boolean flag = false;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = dbCon.getDbCon();
			
			StringBuilder selectQuery = new StringBuilder();
			selectQuery	.append(" SELECT * ")
						.append(" FROM ACCOUNT ")
						.append(" WHERE USER_EMAIL = ? ");
			
			pstmt = conn.prepareStatement(selectQuery.toString());
			
			// 바인드 변수 할당
			pstmt.setString(1, email);
			
			rs = pstmt.executeQuery();
			
			flag = rs.next();
			
		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		}// end try-finally
		
		return flag;
	}// selectEmailCheck
	
}// class
