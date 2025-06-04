package Inquiry;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import Pagination.PaginationDTO;

public class InquiryDAO {

    private static InquiryDAO inquiryDAO;

    private InquiryDAO() {
    }

    public static InquiryDAO getInstance() {
        if(inquiryDAO==null) {
        	inquiryDAO=new InquiryDAO();
        }
        return inquiryDAO;
    }//getInstance
    
	public List<InquiryDTO> getInquiryList() {
		List<InquiryDTO> inquiryList = new ArrayList<>();

		DBConnection dbCon = DBConnection.getInstance();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuilder inquiryArray = new StringBuilder();
		inquiryArray
		.append("	SELECT i.inq_NUM,i.TITLE,i.CONTENT,a.NAME AS name,i.INPUT_DATE,i.STATUS_TYPE,i.ACC_NUM	")
		.append("	FROM INQUIRY	i")
		.append("	JOIN ACCOUNT a ON i.ACC_NUM=a.ACC_NUM	")
		.append("	ORDER BY i.inq_NUM DESC	");

		try {
			conn = dbCon.getDbCon();
			pstmt = conn.prepareStatement(inquiryArray.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				InquiryDTO nDTO = new InquiryDTO();
				nDTO.setInq_num(rs.getInt("inq_num"));
				nDTO.setTitle(rs.getString("title"));
				nDTO.setContent(rs.getString("content"));
				nDTO.setName(rs.getString("name"));
				nDTO.setInput_date(rs.getDate("input_date"));
				nDTO.setStatus_type(rs.getString("status_type"));
				nDTO.setAcc_num(rs.getInt("acc_num"));

				inquiryList.add(nDTO);

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

		return inquiryList;
	}//getNoticeList
	
	//detail로 넘어가는 것
	public InquiryDTO getInquiryOne(int inqNum) {
		
		InquiryDTO iDTO=null;
		
		DBConnection dbCon = DBConnection.getInstance();

		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs=null;
		
		StringBuilder inquiryOne = new StringBuilder();
		inquiryOne
		.append("	SELECT i.INQ_NUM,i.TITLE,i.CONTENT,a.NAME AS name,i.INPUT_DATE,i.STATUS_TYPE,i.ACC_NUM	")
		.append("	FROM INQUIRY	i")
		.append("	JOIN ACCOUNT a ON i.ACC_NUM=a.ACC_NUM	")
		.append("	WHERE i.INQ_NUM=?	");
		
		try {
			conn = dbCon.getDbCon();
			pstmt = conn.prepareStatement(inquiryOne.toString());
			pstmt.setInt(1,inqNum);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				iDTO=new InquiryDTO();
				iDTO.setInq_num(rs.getInt("inq_num"));
				iDTO.setTitle(rs.getString("title"));
				iDTO.setContent(rs.getString("content"));
				iDTO.setName(rs.getString("name"));
				iDTO.setInput_date(rs.getDate("input_date"));
				iDTO.setStatus_type(rs.getString("status_type"));
				iDTO.setAcc_num(rs.getInt("acc_num"));
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
		return iDTO;
	}//getNoticeOne


	

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

    // 공지사항 추가-문의 안해도 됨
    public boolean insertInquiry(InquiryDTO iDTO) throws SQLException {
        DBConnection dbCon = DBConnection.getInstance();
        Connection con = null;
        PreparedStatement pstmt = null;
        
        StringBuilder insertInquiryList = new StringBuilder();
        
        insertInquiryList
        .append("	INSERT INTO INQUIRY (INQ_NUM, TITLE, CONTENT, NAME, INPUT_DATE, STATUS_TYPE, ACC_NUM)	")
        .append("	VALUES ( SEQ_INQ_NUM.NEXTVAL, ?, ?, ?, SYSDATE, ?, ?)	");
        
        try {
            con = dbCon.getDbCon();
            pstmt = con.prepareStatement(insertInquiryList.toString());
                     
            pstmt.setString(1, iDTO.getTitle());
            pstmt.setString(2, iDTO.getContent());
            pstmt.setString(3, iDTO.getName());
            pstmt.setString(4, iDTO.getStatus_type());
            pstmt.setInt(5, iDTO.getAcc_num());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.out.println("문의 추가 오류: " + e.getMessage());
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
    }
    
    //delete
    public boolean deleteInquiry(int inqNum) throws SQLException {
    	DBConnection dbCon = DBConnection.getInstance();
    	Connection con =null;
    	PreparedStatement pstmt =null;
    	
    	StringBuilder deleteInquiryeList =new StringBuilder();
    	
    	deleteInquiryeList
        .append("	DELETE FROM INQUIRY	")
        .append("	WHERE INQ_NUM=?	");
    	
    	try{
    	con = dbCon.getDbCon();
        pstmt = con.prepareStatement(deleteInquiryeList.toString());
        
        pstmt.setInt(1, inqNum);
        int result=pstmt.executeUpdate();
        return result>0;
    	}finally {
    		dbCon.dbClose(con, pstmt, null);
  
		}
    	
    }//deletNotice
    
    
    //updeate - 안해도됨
    public boolean updateInquiry(InquiryDTO iDTO) {
        DBConnection dbCon = DBConnection.getInstance();
        
    	Connection con =null;
    	PreparedStatement pstmt =null;
        
        StringBuilder updateInquiryList = new StringBuilder();
        
        updateInquiryList
        .append("	UPDATE INQUIRY SET TITLE=?, CONTENT=?, STATUS_TYPE=?	")
        .append("	WHERE INQ_NUM=?	");
        
        try {
        	con = dbCon.getDbCon();
            pstmt = con.prepareStatement(updateInquiryList.toString());
            		 
            pstmt.setString(1, iDTO.getTitle());
            pstmt.setString(2, iDTO.getContent());
            pstmt.setString(3, iDTO.getStatus_type());
            pstmt.setInt(4, iDTO.getInq_num());  // ACC_NUM 설정
            
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
	public int getTotalInquiryCount() throws SQLException {
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
			.append("	FROM INQUIRY	");
			
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
	public List<InquiryDTO> selectInquiryByPage(PaginationDTO pagination) throws SQLException {
		List<InquiryDTO> inquiryList = new ArrayList<InquiryDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder selectPageQuery = new StringBuilder();
			selectPageQuery
			.append("	SELECT * FROM (	")
			.append("		SELECT ROWNUM as rnum, inq_num, title, content, name, input_date, status_type,acc_num	")
			.append("		FROM (	")
			.append("			SELECT inq_num, title, content, name, input_date, status_type, acc_num	")
			.append("			FROM INQUIRY	")
			.append("			ORDER BY inq_num DESC	")
			.append("		) WHERE ROWNUM <= ?	")
			.append("	) WHERE rnum >= ?	")
			;
			
			pstmt = con.prepareStatement(selectPageQuery.toString());
			pstmt.setInt(1, pagination.getEndRowNum());
			pstmt.setInt(2, pagination.getStartRowNum());
			
			rs = pstmt.executeQuery();
			
			InquiryDTO iDTO = null;
			
			while( rs.next() ) {
				iDTO = new InquiryDTO();
				iDTO.setInq_num(rs.getInt("inq_num"));
				iDTO.setTitle(rs.getString("title"));
				iDTO.setContent(rs.getString("content"));
				iDTO.setName(rs.getString("name"));
				iDTO.setInput_date(rs.getDate("input_date"));
				iDTO.setStatus_type(rs.getString("status_type"));
				iDTO.setAcc_num(rs.getInt("acc_num"));
				
				inquiryList.add(iDTO);
			} //end while
			
			System.out.println(inquiryList);
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return inquiryList;
	} //selectUsersByPage

	/**
	 * 검색 조건에 따른 공지사항 수를 조회합니다.
	 * @param searchType 검색 유형 (name, email, tel)
	 * @param searchKeyword 검색어
	 * @return 검색 조건에 맞는 사용자 수
	 * @throws SQLException 예외처리
	 */
	public int getSearchInquiryCount(String searchType, String searchKeyword,String statusType) throws SQLException {
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
			.append("	FROM INQUIRY	")
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
			
			if (statusType != null && !statusType.trim().isEmpty() && !"all".equals(statusType)) {
				countQuery.append("	AND status_type=?	");
				paramList.add(statusType);
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
	public List<InquiryDTO> searchInquiryByPage(String searchType, String searchKeyword,String statusType, PaginationDTO pagination) throws SQLException {
		List<InquiryDTO> inquiryList = new ArrayList<InquiryDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder searchQuery = new StringBuilder();
			searchQuery
			.append("	SELECT * FROM (	")
			.append("		SELECT ROWNUM as rnum, inq_num, title, content, name, input_date, status_type,acc_num	")
			.append("		FROM (	")
			.append("			SELECT	inq_num, title, content, name, input_date, status_type,acc_num	")
			.append("			FROM INQUIRY	")
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
			
			//상태조건추가
			if (statusType != null && !statusType.trim().isEmpty() && !"all".equals(statusType)) {
				searchQuery.append("	AND status_type=?	");
				paramList.add(statusType);
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
			
			InquiryDTO iDTO = null;
			
			while( rs.next() ) {
				iDTO = new InquiryDTO();
				iDTO.setInq_num(rs.getInt("inq_num"));
				iDTO.setTitle(rs.getString("title"));
				iDTO.setContent(rs.getString("content"));
				iDTO.setName(rs.getString("name"));
				iDTO.setInput_date(rs.getDate("input_date"));
				iDTO.setStatus_type(rs.getString("status_type"));
				iDTO.setAcc_num(rs.getInt("acc_num"));
				
				inquiryList.add(iDTO);
			} //end while
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return inquiryList;
	} //searchUsersByPage

    

}
