package Account;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;

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
	 * 전체 사용자 계정 조회
	 * @return userList 조회한 사용자 계정 리스트
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
			.append("	where	ROLLTYPE=1	")
			.append("	and withdraw='N'	")
			;
			
			pstmt = con.prepareStatement(selectAllQuery.toString());
			
			// 5. bind 변수에 값 할당
			// 6. 쿼리문 수행 후 결과 얻기.
			rs=pstmt.executeQuery();
			
			AccountDTO userDTO=null;
			
			while( rs.next() ) {
				userDTO = new AccountDTO();
				userDTO.setAcc_num(rs.getInt("acc_num"));;
				userDTO.setName(rs.getString("name"));
				userDTO.setUser_email(rs.getString("user_email"));
				userDTO.setTel(rs.getString("tel"));
				userDTO.setInput_date(rs.getDate("input_date"));
				
				userList.add(userDTO);
			} //end while
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return userList;
	} //selectAllUser
	
	/**
	 * 단일 사용자 계정 조회
	 * @param num 조회할 사용자 계정 번호
	 * @return userDTO 조회한 사용자 계정 정보
	 * @throws SQLException 예외처리
	 */
	public AccountDTO selectOneUser(int num) throws SQLException {
		AccountDTO userDTO = null;
		
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
			StringBuilder selectOneQuery = new StringBuilder();
			selectOneQuery
			.append("	select	acc_num, name, user_email, pass, tel, input_date, withdraw	")
			.append("	from	account	")
			.append("	where	acc_num=?	")
			;
			
			pstmt = con.prepareStatement(selectOneQuery.toString());
			
			// 5. bind 변수에 값 할당
			pstmt.setInt(1, num);
			
			// 6. 쿼리문 수행 후 결과 얻기.
			rs=pstmt.executeQuery();
			
			while( rs.next() ) {
				userDTO = new AccountDTO();
				userDTO.setAcc_num(rs.getInt("acc_num"));;
				userDTO.setName(rs.getString("name"));
				userDTO.setUser_email(rs.getString("user_email"));
				userDTO.setPass(rs.getString("pass"));
				userDTO.setTel(rs.getString("tel"));
				userDTO.setInput_date(rs.getDate("input_date"));
				userDTO.setWithdraw(rs.getString("withdraw"));
			} //end while
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return userDTO;
	} //selectOneUser
	
	/**
	 * 사용자 계정 등록
	 * @param userDTO
	 * @throws SQLException 예외처리
	 */
	public void insertUser(AccountDTO userDTO) throws SQLException {
		
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
			StringBuilder insertQuery = new StringBuilder();
			insertQuery
			.append("	insert	into	account	")
			.append("	(acc_num, name, user_email, pass, tel, input_date, withdraw, roletype)	")
			.append("	values(seq_acc_num.nextval,?,?,?,?,?,'N',1)	")
			;
			
			pstmt = con.prepareStatement(insertQuery.toString());
			
			// 5. bind 변수에 값 할당
			pstmt.setString(1, userDTO.getName());
			pstmt.setString(2, userDTO.getUser_email());
			pstmt.setString(3, userDTO.getPass());
			pstmt.setString(4, userDTO.getTel());
			pstmt.setDate(5, userDTO.getInput_date());

			// 6. 쿼리문 수행 후 결과 얻기.
			rs=pstmt.executeQuery();
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
	} //insertUser
	
	/**
	 * 전체 관리자 계정 조회
	 * @return adminList 조회한 관리자 계정 리스트
	 * @throws SQLException 예외처리
	 */
	public List<AccountDTO> selectAllAdmin() throws SQLException {
		List<AccountDTO> adminList = new ArrayList<AccountDTO>();
		
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
			.append("	select	acc_num, name, adm_id, tel, input_date	")
			.append("	from	account	")
			.append("	where	ROLLTYPE=0	")
			;
			
			pstmt = con.prepareStatement(selectAllQuery.toString());
			
			// 5. bind 변수에 값 할당
			// 6. 쿼리문 수행 후 결과 얻기.
			rs=pstmt.executeQuery();
			
			AccountDTO adminDTO=null;
			
			while( rs.next() ) {
				adminDTO = new AccountDTO();
				adminDTO.setAcc_num(rs.getInt("acc_num"));;
				adminDTO.setName(rs.getString("name"));
				adminDTO.setAdm_id(rs.getString("adm_id"));
				adminDTO.setTel(rs.getString("tel"));
				adminDTO.setInput_date(rs.getDate("input_date"));
				
				adminList.add(adminDTO);
			} //end while
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return adminList;
	} //selectAllAdmin

} //class
