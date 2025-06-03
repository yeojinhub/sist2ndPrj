package Faq;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import Notice.NoticeDTO;
import Pagination.PaginationDTO;

public class FaqDAO {

    private static FaqDAO faqDAO;

    private FaqDAO() {
    }

    public static FaqDAO getInstance() {
        if(faqDAO==null) {
        	faqDAO=new FaqDAO();
        }
        return faqDAO;
    }
	
	public List<FaqDTO> getFaqList() {
		List<FaqDTO> faqList = new ArrayList<>();

		DBConnection dbCon = DBConnection.getInstance();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuilder faqArray = new StringBuilder();
		faqArray
		.append("	SELECT f.FAQ_NUM,f.TITLE,f.CONTENT,a.NAME AS name,f.INPUT_DATE,f.ACC_NUM	")
		.append("	FROM FAQ	f	")
		.append("	JOIN ACCOUNT a ON f.ACC_NUM=a.ACC_NUM	")
		.append("	ORDER BY f.FAQ_NUM DESC	");

		try {
			conn = dbCon.getDbCon();
			pstmt = conn.prepareStatement(faqArray.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				FaqDTO fDTO = new FaqDTO();
				fDTO.setFaq_num(rs.getInt("faq_num"));
				fDTO.setTitle(rs.getString("title"));
				fDTO.setContent(rs.getString("content"));
				fDTO.setName(rs.getString("name"));
				fDTO.setInput_date(rs.getDate("input_date"));
				fDTO.setAcc_num(rs.getInt("acc_num"));

				faqList.add(fDTO);

			} // while

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				dbCon.dbClose(conn, pstmt, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return faqList;
	}//getFaqList
	
	//detail로 넘어가는 것
	public FaqDTO getFaqOne(int faqNum) {
		
		FaqDTO fDTO=null;
		
		DBConnection dbCon = DBConnection.getInstance();

		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs=null;
		
		StringBuilder faqOne = new StringBuilder();
		faqOne
		.append("	SELECT f.FAQ_NUM,f.TITLE,f.CONTENT,a.NAME AS name,f.INPUT_DATE,f.ACC_NUM	")
		.append("	FROM FAQ	f	")
		.append("	JOIN ACCOUNT a ON f.ACC_NUM=a.ACC_NUM	")
		.append("	WHERE f.FAQ_NUM=?	");
		
		try {
			conn = dbCon.getDbCon();
			pstmt = conn.prepareStatement(faqOne.toString());
			pstmt.setInt(1,faqNum);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				fDTO=new FaqDTO();
				fDTO.setFaq_num(rs.getInt("faq_num"));
				fDTO.setTitle(rs.getString("title"));
				fDTO.setContent(rs.getString("content"));
				fDTO.setName(rs.getString("name"));
				fDTO.setInput_date(rs.getDate("input_date"));
				fDTO.setAcc_num(rs.getInt("acc_num"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				dbCon.dbClose(conn, pstmt, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return fDTO;
	}//getFaqOne
	

    // ADM_ID로 ACC_NUM을 찾는 메서드
    public int getAccNumByAdmId(String admId) throws SQLException {
        DBConnection dbCon = DBConnection.getInstance();
        String query = "SELECT ACC_NUM FROM ACCOUNT WHERE ADM_ID = ?";
        try (Connection con = dbCon.getDbCon();
             PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, admId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("ACC_NUM");
                } else {
                    throw new SQLException("ADM_ID에 해당하는 ACC_NUM을 찾을 수 없습니다.");
                }
            }
        }
    }

    // 공지사항 추가
    public boolean insertFaq(FaqDTO fDTO) throws SQLException {
        DBConnection dbCon = DBConnection.getInstance();
        Connection con = null;
        PreparedStatement pstmt = null;
        
        StringBuilder insertFaqList = new StringBuilder();
        
        insertFaqList
        .append("	INSERT INTO FAQ (FAQ_NUM, TITLE, CONTENT, NAME, INPUT_DATE, ACC_NUM)	")
        .append("	VALUES ( SEQ_FAQ_NUM.NEXTVAL, ?, ?, ?, SYSDATE, ?)	");
        
        try {
            con = dbCon.getDbCon();
            pstmt = con.prepareStatement(insertFaqList.toString());
                     
            pstmt.setString(1, fDTO.getTitle());
            pstmt.setString(2, fDTO.getContent());
            pstmt.setString(3, fDTO.getName());
            pstmt.setInt(4, fDTO.getAcc_num());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.out.println("FAQ 추가 오류: " + e.getMessage());
            e.printStackTrace();
            throw e;
        } finally {
            // 리소스 해제 - 중요!
            try {
                dbCon.dbClose(con, pstmt, null);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }//insertFaq
    
    
    //delete
    public boolean deleteFaq(int faqNum) throws SQLException {
    	DBConnection dbCon = DBConnection.getInstance();
    	Connection con =null;
    	PreparedStatement pstmt =null;
    	
    	StringBuilder deleteFaqList =new StringBuilder();
    	
    	deleteFaqList
        .append("	DELETE FROM FAQ	")
        .append("	WHERE FAQ_NUM=?	");
    	
    	try{
    	con = dbCon.getDbCon();
        pstmt = con.prepareStatement(deleteFaqList.toString());
        
        pstmt.setInt(1, faqNum);
        int result=pstmt.executeUpdate();
        return result>0;
    	}finally {
    		dbCon.dbClose(con, pstmt, null);
  
		}
    	
    }//deletNotice
    
    
    //updeate
    public boolean updateFaq(FaqDTO fDTO) {
        DBConnection dbCon = DBConnection.getInstance();
        
    	Connection con =null;
    	PreparedStatement pstmt =null;
        
        StringBuilder updateFaqList = new StringBuilder();
        
        updateFaqList
        .append("	UPDATE FAQ SET TITLE=?, CONTENT=?	")
        .append("	WHERE 	FAQ_NUM=?	");
        
        try {
        	con = dbCon.getDbCon();
            pstmt = con.prepareStatement(updateFaqList.toString());
            		 
            pstmt.setString(1, fDTO.getTitle());
            pstmt.setString(2, fDTO.getContent());
            pstmt.setInt(3, fDTO.getFaq_num());  // ACC_NUM 설정
            
            return pstmt.executeUpdate() > 0;
        }catch (SQLException e) {
        	System.out.println(" 수정 오류"+e.getMessage());
        	return false;

        }finally {
        	try {
				dbCon.dbClose(con, pstmt, null);
			} catch (SQLException e) {
				e.printStackTrace();
			}
        }//finally
	
    }//updateNotice
    
    //pagination///////////////////////////////////////////////////////////////
 
	/**
	 * 전체 유저 수를 조회합니다.
	 * @return 전체 유저 수
	 * @throws SQLException 예외처리
	 */
	public int getTotalFaqCount() throws SQLException {
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
			.append("	FROM FAQ	");
			
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

	//페이지별 공지사항 조회
	/**
	 * 페이지네이션을 적용하여 사용자 목록을 조회합니다. (Oracle 11g 이하 - ROWNUM 사용)
	 * @param pagination 페이지네이션 정보
	 * @return 페이지에 해당하는 사용자 목록
	 * @throws SQLException 예외처리
	 */
	public List<FaqDTO> selectFaqByPage(PaginationDTO pagination) throws SQLException {
		List<FaqDTO> faqList = new ArrayList<FaqDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder selectPageQuery = new StringBuilder();
			selectPageQuery
			.append("	SELECT * FROM (	")
			.append("		SELECT ROWNUM as rnum, faq_num, title, content, name, input_date, acc_num	")
			.append("		FROM (	")
			.append("			SELECT faq_num, title, content, name, input_date, acc_num	")
			.append("			FROM FAQ	")
			.append("			ORDER BY FAQ_NUM DESC	")
			.append("		) WHERE ROWNUM <= ?	")
			.append("	) WHERE rnum >= ?	")
			;
			
			pstmt = con.prepareStatement(selectPageQuery.toString());
			pstmt.setInt(1, pagination.getEndRowNum());
			pstmt.setInt(2, pagination.getStartRowNum());
			
			rs = pstmt.executeQuery();
			
			FaqDTO fDTO = null;
			
			while( rs.next() ) {
				fDTO = new FaqDTO();
				fDTO.setFaq_num(rs.getInt("faq_num"));
				fDTO.setTitle(rs.getString("title"));
				fDTO.setContent(rs.getString("content"));
				fDTO.setName(rs.getString("name"));
				fDTO.setInput_date(rs.getDate("input_date"));
				fDTO.setAcc_num(rs.getInt("acc_num"));
				
				faqList.add(fDTO);
			} //end while
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return faqList;
	} //selectUsersByPage

	/**
	 * 검색 조건에 따른 공지사항 수를 조회합니다.
	 * @param searchType 검색 유형 (name, email, tel)
	 * @param searchKeyword 검색어
	 * @return 검색 조건에 맞는 사용자 수
	 * @throws SQLException 예외처리
	 */
	public int getSearchFaqCount(String searchType, String searchKeyword) throws SQLException {
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
			.append("	FROM	FAQ	")
			.append("	WHERE 1=1	");
			
			List<String> paramList=new ArrayList<String>();
			
			// 검색어가 null이 아닌 경우에만 조건 추가 (PaginationUtil에서 이미 처리됨)
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				switch (searchType) {
					case "title":
						countQuery.append("	AND title LIKE ?	");
						paramList.add("%"+searchKeyword+"%");
						break;
					case "content":
						countQuery.append("	AND content LIKE ?	");
						paramList.add("%"+searchKeyword+"%");
						break;
					case "author":
						countQuery.append("	AND name LIKE ?	");
						paramList.add("%"+searchKeyword+"%");
						break;
				}
			}
			
			pstmt = con.prepareStatement(countQuery.toString());
			
			for(int i=0; i<paramList.size();i++) {
				pstmt.setString(i+1, paramList.get(i));
			}
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				totalCount = rs.getInt("total_count");
			}
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		}
		
		return totalCount;
	} //getSearchNoticeCount
	
	//검색조건에 맞는 페이지별 공지사항 조회
	/**
	 * 검색 조건에 따른 사용자 목록을 페이지네이션으로 조회합니다. (Oracle 11g 이하 - ROWNUM 사용)
	 * @param searchType 검색 유형 (name, email, tel)
	 * @param searchKeyword 검색어
	 * @param pagination 페이지네이션 정보
	 * @return 검색 조건과 페이지에 해당하는 사용자 목록
	 * @throws SQLException 예외처리
	 */
	public List<FaqDTO> searchNoticeByPage(String searchType, String searchKeyword, PaginationDTO pagination) throws SQLException {
		List<FaqDTO> faqList = new ArrayList<FaqDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder searchQuery = new StringBuilder();
			searchQuery
			.append("	SELECT * FROM (	")
			.append("		SELECT ROWNUM as rnum, faq_num, title, content, name, input_date, acc_num	")
			.append("		FROM (	")
			.append("			SELECT	faq_num, title, content, name, input_date, acc_num	")
			.append("			FROM FAQ	")
			.append("			WHERE 1=1	");
			
			List<String> paramList=new ArrayList<String>();
			
			// 검색어가 null이 아닌 경우에만 조건 추가 (PaginationUtil에서 이미 처리됨)
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				switch (searchType) {
					case "title":
						searchQuery.append("	AND title LIKE ?	");
						paramList.add("%"+searchKeyword+"%");
						break;
					case "content":
						searchQuery.append("	AND content LIKE ?	");
						paramList.add("%"+searchKeyword+"%");
						break;
					case "author":
						searchQuery.append("	AND name LIKE ?	");
						paramList.add("%"+searchKeyword+"%");
						break;
				}
			}
			
			searchQuery.append("			ORDER BY input_date DESC	");
			searchQuery.append("		) WHERE ROWNUM <= ?	");
			searchQuery.append("	) WHERE rnum >= ?	");
			
			pstmt = con.prepareStatement(searchQuery.toString());
			
			int paramIndex = 1;
			for(String param : paramList) {
				pstmt.setString(paramIndex++, param);
			}
			
			pstmt.setInt(paramIndex++, pagination.getEndRowNum());
			pstmt.setInt(paramIndex, pagination.getStartRowNum());
			
			rs = pstmt.executeQuery();
			
			FaqDTO fDTO = null;
			
			while( rs.next() ) {
				fDTO = new FaqDTO();
				fDTO.setFaq_num(rs.getInt("faq_num"));
				fDTO.setTitle(rs.getString("title"));
				fDTO.setContent(rs.getString("content"));
				fDTO.setName(rs.getString("name"));
				fDTO.setInput_date(rs.getDate("input_date"));
				fDTO.setAcc_num(rs.getInt("acc_num"));
				
				faqList.add(fDTO);
			} //end while
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return faqList;
	} //searchUsersByPage

 
} //class