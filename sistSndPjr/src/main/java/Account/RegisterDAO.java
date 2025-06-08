package Account;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DBConnection.DBConnection;

public class RegisterDAO {
	
	/**
	 * 회원가입 시 이메일(ID) 중복 확인
	 * : DB에 저장된 암호화 이메일(ID)를 비교하기 위해 매개변수로 암호화된 이메일(ID)를 받는다.
	 * @param id 암호화된 이메일(ID)
	 * @return
	 * @throws SQLException
	 */
	public boolean selectIdCheck(String id) throws SQLException {
		boolean flag = false;
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		try {
			conn = dbCon.getDbCon();
			
			// SQL문 작성
			StringBuilder selectQuery = new StringBuilder();
			selectQuery
			.append("	SELECT USER_EMAIL	")
			.append("	FROM ACCOUNT WHERE USER_EMAIL = ?	");
			
			pstmt = conn.prepareStatement(selectQuery.toString());
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			flag = rs.next();
			
		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		}// end try-finally
		
		return flag;
	}// selectIdCheck

	/**
	 * 회원가입 insert문
	 * @param aDTO 회원가입 페이지에서 받아온 정보 (이름, 이메일 등)
	 * @throws SQLException
	 */
	public void insertAccount(AccountDTO aDTO) throws SQLException{
		
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		try {
			conn = dbCon.getDbCon();
			
			// SQL문 작성
			StringBuilder insertQuery = new StringBuilder();
			insertQuery
			.append("	INSERT INTO ACCOUNT(ACC_NUM, NAME, USER_EMAIL, PASS, TEL, ROLLTYPE)	")
			.append("	VALUES(SEQ_ACC_NUM.NEXTVAL ,?, ?, ?, ?, 1)	");
			
			pstmt = conn.prepareStatement(insertQuery.toString());			
			
			// 바인드 변수 할당
			pstmt.setString(1, aDTO.getName());
			pstmt.setString(2, aDTO.getUser_email());
			pstmt.setString(3, aDTO.getPass());
			pstmt.setString(4, aDTO.getTel());
			
			pstmt.executeQuery();
			
		} finally {
			dbCon.dbClose(conn, pstmt, null);
		}// end try-finally
		
	}// insertRegister
	
}// class