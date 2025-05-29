package myPage;

import java.sql.Connection;
import java.sql.PreparedStatement;
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
			StringBuilder deleteQuery = new StringBuilder();
			deleteQuery
			.append("	UPDATE ACCOUNT SET WITHDRAW = 'Y' WHERE USER_EMAIL = ?	");
			
			pstmt = conn.prepareStatement(deleteQuery.toString());
			
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
			StringBuilder updateQuery = new StringBuilder();
			updateQuery
			.append("UPDATE ACCOUNT SET PASS = ? WHERE USER_EMAIL = ?	");
			pstmt = conn.prepareStatement(updateQuery.toString());
			pstmt.setString(1, pass);
			pstmt.setString(2, email);
			pstmt.executeUpdate();
		}finally {
			dbCon.dbClose(conn, pstmt, null);
		}
	}//updateUser
	
	public void updateAccount(String tel, String email) throws SQLException{
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		try {
			conn = dbCon.getDbCon();
			StringBuilder updateQuery = new StringBuilder();
			updateQuery.
			append("UPDATE ACCOUNT SET TEL = ?	").
			append("WHERE USER_EMAIL = ?	");
			pstmt = conn.prepareStatement(updateQuery.toString());
			pstmt.setString(1, tel);
			pstmt.setString(2, email);
			pstmt.executeUpdate();
			
		}finally {
			dbCon.dbClose(conn, pstmt, null);
		}
	}
}
