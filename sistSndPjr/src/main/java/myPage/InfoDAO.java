package myPage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DBConnection.DBConnection;

public class InfoDAO {
	public void deleteUser(String email) throws SQLException{
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		try {
			conn = dbCon.getDbCon();
			
			// SQL문 작성
			StringBuilder selectQuery = new StringBuilder();
			selectQuery
			.append("	DELETE FROM ACCOUNT WHERE USER_EMAIL = ?	");
			
			pstmt = conn.prepareStatement(selectQuery.toString());
			
			pstmt.setString(1, email);
			pstmt.executeUpdate(); 
			
		} finally {
			dbCon.dbClose(conn, pstmt, null);
		}// end try-finally
		
	}//deleteuser
	
	public void updatePass(String email, String pass) throws SQLException {
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		try {
			conn = dbCon.getDbCon();
			StringBuilder selectQuery = new StringBuilder();
			selectQuery
			.append("UPDATE ACCOUNT SET PASS = ? WHERE USER_EMAIL = ?	");
			pstmt = conn.prepareStatement(selectQuery.toString());
			pstmt.setString(1, pass);
			pstmt.setString(2, email);
			pstmt.executeUpdate();
		}finally {
			dbCon.dbClose(conn, pstmt, null);
		}
	}//updateUser
}
