package Board;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Account.AccountDTO;
import DBConnection.DBConnection;

public class FaqDAO {

	private static FaqDAO faqDAO;
	
	private FaqDAO() {
		
	} //FaqDAO
	
	public static FaqDAO getInstance() {
		if( faqDAO == null ) {
			faqDAO = new FaqDAO();
		} //end if
		
		return faqDAO;
	} //getInstance
	
	/**
	 * 전체 faq 게시물 조회
	 * @return faqList 조회한 전체 faq 게시물 리스트
	 * @throws SQLException 예외처리
	 */
	public List<FaqDTO> selectAllFaq() throws SQLException {
		List<FaqDTO> faqList = new ArrayList<FaqDTO>();
		
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
			.append("	select	faq_num, title, name, input_date	")
			.append("	from	faq	")
			;
			
			pstmt = con.prepareStatement(selectAllQuery.toString());
			
			// 5. bind 변수에 값 할당
			// 6. 쿼리문 수행 후 결과 얻기.
			rs=pstmt.executeQuery();
			
			FaqDTO faqDTO=null;
			
			while( rs.next() ) {
				faqDTO = new FaqDTO();
				faqDTO.setFaq_num(rs.getInt("faq_num"));;
				faqDTO.setTitle(rs.getString("title"));
				faqDTO.setName(rs.getString("name"));
				faqDTO.setInput_date(rs.getDate("input_date"));
				
				faqList.add(faqDTO);
			} //end while
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return faqList;
	} //selectAllFaq
	
	/**
	 * 단일 faq 게시물 조회
	 * @param num 조회할 faq 게시물 번호
	 * @return faqList 조회한 단일 faq 게시물 정보
	 * @throws SQLException 예외처리
	 */
	public FaqDTO selectOneFaq(int num) throws SQLException {
		System.out.println("DAO에서의 게시판 번호 : "+num);
		FaqDTO faqDTO = null;
		
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
			.append("	select	faq_num, title, content, name, input_date	")
			.append("	from	faq	")
			.append("	where	faq_num=?	")
			;
			
			pstmt = con.prepareStatement(selectOneQuery.toString());
			
			// 5. bind 변수에 값 할당
			pstmt.setInt(1, num);
			
			// 6. 쿼리문 수행 후 결과 얻기.
			rs=pstmt.executeQuery();
			
			while( rs.next() ) {
				faqDTO = new FaqDTO();
				faqDTO.setFaq_num(num);
				faqDTO.setTitle(rs.getString("title"));
				faqDTO.setContent(rs.getString("content"));
				faqDTO.setName(rs.getString("name"));
				faqDTO.setInput_date(rs.getDate("input_date"));
			} //end while
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return faqDTO;
	} //selectOneFaq

	public void insertFaq(FaqDTO faqDTO) throws SQLException {

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
			.append("	insert	into	faq	")
			.append("	(faq_num, title, content, name, input_date, acc_num)	")
			.append("	values(SEQ_FAQ_NUM.NEXTVAL,?,?,?,?,?)	")
			;
			pstmt = con.prepareStatement(insertQuery.toString());

			// 5. bind 변수에 값 할당
			pstmt.setString(1, faqDTO.getTitle());
			pstmt.setString(2, faqDTO.getContent());
			pstmt.setString(3, faqDTO.getName());
			pstmt.setDate(4, faqDTO.getInput_date());
			pstmt.setInt(5, faqDTO.getAcc_num());

			// 6. 쿼리문 수행 후 결과 얻기.
			rs = pstmt.executeQuery();

		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} // end try finally

	} // insertFaq

} // class
