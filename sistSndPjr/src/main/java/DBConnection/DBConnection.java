package DBConnection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBConnection {

	private static DBConnection dbCon;
	private static Context ctx;

	private DBConnection() {
	}// DBConnection

	public static DBConnection getInstance() {
		if (dbCon == null) {
			dbCon = new DBConnection();
			try {
				// 1. JNDI 사용객체를 생성
				ctx = new InitialContext();
			} catch (NamingException e) {
				e.printStackTrace();
			}
		} // end if
		
		return dbCon;
	}// getInstance

	public Connection getDbCon() {
		Connection conn = null;

		// 2. 이름으로(JNDI) DBCP에서 DB를 연결하고 있는 객체(DataSource)를 얻습니다.
		try {
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/dbcp");
			conn = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException se) {
			se.printStackTrace();
		} // end try-catch
		return conn;
	}

	public void dbClose(Connection conn, Statement stmt, ResultSet rs) throws SQLException{
		
		try {
			if (rs != null) {
				rs.close();
			} // end if
			if (stmt != null) {
				stmt.close();
			} // end if
		} finally {
			if (conn != null) {
				conn.close();
			} // end if
		}// end try-finally
		
		
	}// dbClose

}// class
