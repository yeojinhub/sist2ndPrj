package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import DTO.AccountDTO;

public class AdminAccountDAO {
	
	private static AdminAccountDAO accountDAO;
	
	private AdminAccountDAO () {
		
	} //AdminAccountDAO
	
	public static AdminAccountDAO getInstance() {
		if( accountDAO == null ) {
			accountDAO = new AdminAccountDAO();
		} //end if
		
		return accountDAO;
	} //getInstance
	
	/**
	 * 전체 유저
	 * @return userList
	 * @throws SQLException 예외처리
	 */
	public List<AccountDTO> selectAllUser() throws SQLException {
		List<AccountDTO> userList = new ArrayList<AccountDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			// 1. JNDI 사용객체 생성.
			// 2. DBCP에서 연결객체 얻기(DataSource).
			// 3. Connection 얻기.
			con = dbCon.getDbCon();
			
			// 4. 쿼리문 생성객체 얻기.
			StringBuilder selectAllQuery = new StringBuilder();
			selectAllQuery
			.append("	select	acc_num, name, user_email, tel, input_date	")
			.append("	from	account	")
			.append("	where	roletype=1	")
			.append("	and withdraw='N'	")
			;
			
			pstmt = con.prepareStatement(selectAllQuery.toString());
			
			// 5. bind 변수에 값 할당
			// 6. 쿼리문 수행 후 결과 얻기.
			rs=pstmt.executeQuery();
			
			AccountDTO accountDAO=null;
			
			while( rs.next() ) {
				accountDAO = new AccountDTO();
				accountDAO.setAcc_num(rs.getInt("acc_num"));;
				accountDAO.setName(rs.getString("name"));
				accountDAO.setUser_email(rs.getString("user_email"));
				accountDAO.setTel(rs.getString("tel"));
				accountDAO.setInput_date(rs.getDate("input_date"));
				
				userList.add(accountDAO);
			} //end while
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return userList;
	} //selectAllUser

} //class
