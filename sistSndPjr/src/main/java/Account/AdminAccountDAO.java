package Account;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import Pagination.PaginationDTO;

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
			.append("	(acc_num, name, user_email, pass, tel, input_date, withdraw, ROLLTYPE)	")
			.append("	values(SEQ_ACC_NUM.NEXTVAL,?,?,?,?,?,'N',1)	")
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
	 * 사용자 계정 수정
	 * @param userDTO 
	 * @return flagNum 성공시 1, 실패시 0
	 * @throws SQLException 예외처리
	 */
	public int updateUser(AccountDTO userDTO) throws SQLException {
		int flagNum = 0;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			// 1. JNDI 사용객체 생성.
			// 2. DBCP에서 연결객체 얻기(DataSource).
			// 3. Connection 얻기.
			con = dbCon.getDbCon();
			
			// 4. 쿼리문 생성객체 얻기.
			StringBuilder updateQuery = new StringBuilder();
			updateQuery
			.append("	update	account	")
			.append("	set name=?,	tel=?	")
			.append("	where	acc_num=?	")
			;
			
			pstmt = con.prepareStatement(updateQuery.toString());
			
			// 5. bind 변수에 값 할당
			pstmt.setString(1, userDTO.getName());
			pstmt.setString(2, userDTO.getTel());
			pstmt.setInt(3, userDTO.getAcc_num());
			
			// 6. 쿼리문 수행 후 결과 얻기.
			flagNum = pstmt.executeUpdate();
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, null);
		} //end try finally
		
		return flagNum;
		
	} //updateUser
	
	/**
	 * 사용자 계정 삭제
	 * @param userDTO 
	 * @return flagNum 성공시 1, 실패시 0
	 * @throws SQLException 예외처리
	 */
	public int deleteUser(int accNum) throws SQLException {
		int flagNum = 0;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			// 1. JNDI 사용객체 생성.
			// 2. DBCP에서 연결객체 얻기(DataSource).
			// 3. Connection 얻기.
			con = dbCon.getDbCon();
			
			// 4. 쿼리문 생성객체 얻기.
			StringBuilder deleteQuery = new StringBuilder();
			deleteQuery
			.append("	delete	from	account	")
			.append("	where	acc_num=?	")
			;
			
			pstmt = con.prepareStatement(deleteQuery.toString());
			
			// 5. bind 변수에 값 할당
			pstmt.setInt(1, accNum);
			
			// 6. 쿼리문 수행 후 결과 얻기.
			flagNum = pstmt.executeUpdate();
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, null);
		} //end try finally
		
		return flagNum;
		
	} //deleteUser
	
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
	
	/**
	 * 단일 관리자 계정 조회
	 * @param num 조회할 관리자 계정 번호
	 * @return adminDTO 조회한 관리자 계정 정보
	 * @throws SQLException 예외처리
	 */
	public AccountDTO selectOneAdmin(int num) throws SQLException {
		AccountDTO adminDTO = null;
		
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
			.append("	select	acc_num, name, adm_id, pass, tel, input_date	")
			.append("	from	account	")
			.append("	where	acc_num=?	")
			;
			
			pstmt = con.prepareStatement(selectOneQuery.toString());
			
			// 5. bind 변수에 값 할당
			pstmt.setInt(1, num);
			
			// 6. 쿼리문 수행 후 결과 얻기.
			rs=pstmt.executeQuery();
			
			while( rs.next() ) {
				adminDTO = new AccountDTO();
				adminDTO.setAcc_num(rs.getInt("acc_num"));;
				adminDTO.setName(rs.getString("name"));
				adminDTO.setAdm_id(rs.getString("adm_id"));
				adminDTO.setPass(rs.getString("pass"));
				adminDTO.setTel(rs.getString("tel"));
				adminDTO.setInput_date(rs.getDate("input_date"));
			} //end while
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return adminDTO;
	} //selectOneAdmin
	
	/**
	 * 관리자 계정 수정
	 * @param adminDTO 
	 * @return flagNum 성공시 1, 실패시 0
	 * @throws SQLException 예외처리
	 */
	public int updateAdmin(AccountDTO adminDTO) throws SQLException {
		int flagNum = 0;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			// 1. JNDI 사용객체 생성.
			// 2. DBCP에서 연결객체 얻기(DataSource).
			// 3. Connection 얻기.
			con = dbCon.getDbCon();
			
			// 4. 쿼리문 생성객체 얻기.
			StringBuilder updateQuery = new StringBuilder();
			updateQuery
			.append("	update	account	")
			.append("	set name=?,	tel=?	")
			.append("	where	acc_num=?	")
			;
			
			pstmt = con.prepareStatement(updateQuery.toString());
			
			// 5. bind 변수에 값 할당
			pstmt.setString(1, adminDTO.getName());
			pstmt.setString(2, adminDTO.getTel());
			pstmt.setInt(3, adminDTO.getAcc_num());
			
			// 6. 쿼리문 수행 후 결과 얻기.
			flagNum = pstmt.executeUpdate();
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, null);
		} //end try finally
		
		return flagNum;
		
	} //updateAdmin
	
	/**
	 * 전체 유저 수를 조회합니다.
	 * @return 전체 유저 수
	 * @throws SQLException 예외처리
	 */
	public int getTotalUserCount() throws SQLException {
		int totalCount = 0;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder countQuery = new StringBuilder();
			countQuery
			.append("	SELECT COUNT(*) as total_count	")
			.append("	FROM account	")
			.append("	WHERE ROLLTYPE = 1	")
			.append("	  AND withdraw = 'N'	")
			;
			
			pstmt = con.prepareStatement(countQuery.toString());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				totalCount = rs.getInt("total_count");
			}
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		}
		
		return totalCount;
	} //getTotalUserCount
	
	/**
	 * 페이지네이션을 적용하여 사용자 목록을 조회합니다. (Oracle 11g 이하 - ROWNUM 사용)
	 * @param pagination 페이지네이션 정보
	 * @return 페이지에 해당하는 사용자 목록
	 * @throws SQLException 예외처리
	 */
	public List<AccountDTO> selectUsersByPage(PaginationDTO pagination) throws SQLException {
		List<AccountDTO> userList = new ArrayList<AccountDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder selectPageQuery = new StringBuilder();
			selectPageQuery
			.append("	SELECT * FROM (	")
			.append("		SELECT ROWNUM as rnum, acc_num, name, user_email, tel, input_date	")
			.append("		FROM (	")
			.append("			SELECT acc_num, name, user_email, tel, input_date	")
			.append("			FROM account	")
			.append("			WHERE ROLLTYPE = 1	")
			.append("			  AND withdraw = 'N'	")
			.append("			ORDER BY input_date DESC	")
			.append("		) WHERE ROWNUM <= ?	")
			.append("	) WHERE rnum >= ?	")
			;
			
			pstmt = con.prepareStatement(selectPageQuery.toString());
			pstmt.setInt(1, pagination.getEndRowNum());
			pstmt.setInt(2, pagination.getStartRowNum());
			
			rs = pstmt.executeQuery();
			
			AccountDTO accountDTO = null;
			
			while( rs.next() ) {
				accountDTO = new AccountDTO();
				accountDTO.setAcc_num(rs.getInt("acc_num"));
				accountDTO.setName(rs.getString("name"));
				accountDTO.setUser_email(rs.getString("user_email"));
				accountDTO.setTel(rs.getString("tel"));
				accountDTO.setInput_date(rs.getDate("input_date"));
				
				userList.add(accountDTO);
			} //end while
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return userList;
	} //selectUsersByPage
	
	/**
	 * 검색 조건에 따른 사용자 수를 조회합니다.
	 * @param searchType 검색 유형 (name, email, tel)
	 * @param searchKeyword 검색어
	 * @return 검색 조건에 맞는 사용자 수
	 * @throws SQLException 예외처리
	 */
	public int getSearchUserCount(String searchType, String searchKeyword) throws SQLException {
		int totalCount = 0;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder countQuery = new StringBuilder();
			countQuery
			.append("	SELECT COUNT(*) as total_count	")
			.append("	FROM account	")
			.append("	WHERE ROLLTYPE = 1	")
			.append("	  AND withdraw = 'N'	")
			;
			
			// 검색어가 null이 아닌 경우에만 조건 추가 (PaginationUtil에서 이미 처리됨)
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				switch (searchType) {
					case "name":
						countQuery.append("	AND name LIKE ?	");
						break;
					case "email":
						countQuery.append("	AND user_email LIKE ?	");
						break;
					case "tel":
						countQuery.append("	AND tel LIKE ?	");
						break;
				}
			}
			
			pstmt = con.prepareStatement(countQuery.toString());
			
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				pstmt.setString(1, "%" + searchKeyword + "%");
			}
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				totalCount = rs.getInt("total_count");
			}
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		}
		
		return totalCount;
	} //getSearchUserCount
	
	/**
	 * 검색 조건에 따른 사용자 목록을 페이지네이션으로 조회합니다. (Oracle 12c 이상)
	 * @param searchType 검색 유형 (name, email, tel)
	 * @param searchKeyword 검색어
	 * @param pagination 페이지네이션 정보
	 * @return 검색 조건과 페이지에 해당하는 사용자 목록
	 * @throws SQLException 예외처리
	 */
	public List<AccountDTO> searchUsersByPageOracle12c(String searchType, String searchKeyword, PaginationDTO pagination) throws SQLException {
		List<AccountDTO> userList = new ArrayList<AccountDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder searchQuery = new StringBuilder();
			searchQuery
			.append("	SELECT acc_num, name, user_email, tel, input_date	")
			.append("	FROM account	")
			.append("	WHERE ROLLTYPE = 1	")
			.append("	  AND withdraw = 'N'	")
			;
			
			// 검색어가 null이 아닌 경우에만 조건 추가 (PaginationUtil에서 이미 처리됨)
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				switch (searchType) {
					case "name":
						searchQuery.append("	AND name LIKE ?	");
						break;
					case "email":
						searchQuery.append("	AND user_email LIKE ?	");
						break;
					case "tel":
						searchQuery.append("	AND tel LIKE ?	");
						break;
				}
			}
			
			searchQuery.append("	ORDER BY input_date DESC	");
			searchQuery.append("	OFFSET ? ROWS FETCH NEXT ? ROWS ONLY	");
			
			pstmt = con.prepareStatement(searchQuery.toString());
			
			int paramIndex = 1;
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				pstmt.setString(paramIndex++, "%" + searchKeyword + "%");
			}
			pstmt.setInt(paramIndex++, pagination.getOffset());
			pstmt.setInt(paramIndex, pagination.getPageSize());
			
			rs = pstmt.executeQuery();
			
			AccountDTO accountDTO = null;
			
			while( rs.next() ) {
				accountDTO = new AccountDTO();
				accountDTO.setAcc_num(rs.getInt("acc_num"));
				accountDTO.setName(rs.getString("name"));
				accountDTO.setUser_email(rs.getString("user_email"));
				accountDTO.setTel(rs.getString("tel"));
				accountDTO.setInput_date(rs.getDate("input_date"));
				
				userList.add(accountDTO);
			} //end while
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return userList;
	} //searchUsersByPageOracle12c
	
	/**
	 * 검색 조건에 따른 사용자 목록을 페이지네이션으로 조회합니다. (Oracle 11g 이하 - ROWNUM 사용)
	 * @param searchType 검색 유형 (name, email, tel)
	 * @param searchKeyword 검색어
	 * @param pagination 페이지네이션 정보
	 * @return 검색 조건과 페이지에 해당하는 사용자 목록
	 * @throws SQLException 예외처리
	 */
	public List<AccountDTO> searchUsersByPage(String searchType, String searchKeyword, PaginationDTO pagination) throws SQLException {
		List<AccountDTO> userList = new ArrayList<AccountDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder searchQuery = new StringBuilder();
			searchQuery
			.append("	SELECT * FROM (	")
			.append("		SELECT ROWNUM as rnum, acc_num, name, user_email, tel, input_date	")
			.append("		FROM (	")
			.append("			SELECT acc_num, name, user_email, tel, input_date	")
			.append("			FROM account	")
			.append("			WHERE ROLLTYPE = 1	")
			.append("			  AND withdraw = 'N'	")
			;
			
			// 검색어가 null이 아닌 경우에만 조건 추가 (PaginationUtil에서 이미 처리됨)
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				switch (searchType) {
					case "name":
						searchQuery.append("	AND name LIKE ?	");
						break;
					case "email":
						searchQuery.append("	AND user_email LIKE ?	");
						break;
					case "tel":
						searchQuery.append("	AND tel LIKE ?	");
						break;
				}
			}
			
			searchQuery.append("			ORDER BY input_date DESC	");
			searchQuery.append("		) WHERE ROWNUM <= ?	");
			searchQuery.append("	) WHERE rnum >= ?	");
			
			pstmt = con.prepareStatement(searchQuery.toString());
			
			int paramIndex = 1;
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				pstmt.setString(paramIndex++, "%" + searchKeyword + "%");
			}
			pstmt.setInt(paramIndex++, pagination.getEndRowNum());
			pstmt.setInt(paramIndex, pagination.getStartRowNum());
			
			rs = pstmt.executeQuery();
			
			AccountDTO accountDTO = null;
			
			while( rs.next() ) {
				accountDTO = new AccountDTO();
				accountDTO.setAcc_num(rs.getInt("acc_num"));
				accountDTO.setName(rs.getString("name"));
				accountDTO.setUser_email(rs.getString("user_email"));
				accountDTO.setTel(rs.getString("tel"));
				accountDTO.setInput_date(rs.getDate("input_date"));
				
				userList.add(accountDTO);
			} //end while
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return userList;
	} //searchUsersByPage

} //class