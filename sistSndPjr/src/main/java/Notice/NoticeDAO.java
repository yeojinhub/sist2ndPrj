package Notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import Pagination.PaginationDTO;

public class NoticeDAO {

    private static NoticeDAO noticeDAO;

    private NoticeDAO() {
        // 생성자 private: 외부에서 new 사용 못 하도록
    }

    public static NoticeDAO getInstance() {
        if(noticeDAO==null) {
        	noticeDAO=new NoticeDAO();
        }
        return noticeDAO;
    }
	
	public List<NoticeDTO> getNoticeList() {
		List<NoticeDTO> noticeList = new ArrayList<>();

		DBConnection dbCon = DBConnection.getInstance();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuilder noticeArray = new StringBuilder();
		noticeArray
		.append("	SELECT n.NOT_NUM,n.TITLE,n.CONTENT,a.NAME AS name,n.INPUT_DATE,n.STATUS_TYPE,n.ACC_NUM	")
		.append("	FROM NOTICE	n")
		.append("	JOIN ACCOUNT a ON n.ACC_NUM=a.ACC_NUM	")
		.append("	ORDER BY n.NOT_NUM DESC	");

		try {
			conn = dbCon.getDbCon();
			pstmt = conn.prepareStatement(noticeArray.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				NoticeDTO nDTO = new NoticeDTO();
				nDTO.setNot_num(rs.getInt("not_num"));
				nDTO.setTitle(rs.getString("title"));
				nDTO.setContent(rs.getString("content"));
				nDTO.setName(rs.getString("name"));
				nDTO.setInput_date(rs.getDate("input_date"));
				nDTO.setStatus_type(rs.getString("status_type"));
				nDTO.setAcc_num(rs.getInt("acc_num"));

				noticeList.add(nDTO);

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

		return noticeList;
	}//getNoticeList
	
	//detail로 넘어가는 것
	public NoticeDTO getNoticeOne(int notNum) {
		
		NoticeDTO nDTO=null;
		
		DBConnection dbCon = DBConnection.getInstance();

		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs=null;
		
		StringBuilder noticeOne = new StringBuilder();
		noticeOne
		.append("	SELECT n.NOT_NUM,n.TITLE,n.CONTENT,a.NAME AS name,n.INPUT_DATE,n.STATUS_TYPE,n.ACC_NUM	")
		.append("	FROM NOTICE	n")
		.append("	JOIN ACCOUNT a ON n.ACC_NUM=a.ACC_NUM	")
		.append("	WHERE n.NOT_NUM=?	");
		
		try {
			conn = dbCon.getDbCon();
			pstmt = conn.prepareStatement(noticeOne.toString());
			pstmt.setInt(1,notNum);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				nDTO=new NoticeDTO();
				nDTO.setNot_num(rs.getInt("not_num"));
				nDTO.setTitle(rs.getString("title"));
				nDTO.setContent(rs.getString("content"));
				nDTO.setName(rs.getString("name"));
				nDTO.setInput_date(rs.getDate("input_date"));
				nDTO.setStatus_type(rs.getString("status_type"));
				nDTO.setAcc_num(rs.getInt("acc_num"));
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
		return nDTO;
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

    // 공지사항 추가
    public boolean insertNotice(NoticeDTO ntDTO) throws SQLException {
        DBConnection dbCon = DBConnection.getInstance();
        Connection con = null;
        PreparedStatement pstmt = null;
        
        StringBuilder insertNoticeList = new StringBuilder();
        
        insertNoticeList
        .append("	INSERT INTO NOTICE (NOT_NUM, TITLE, CONTENT, NAME, INPUT_DATE, STATUS_TYPE, ACC_NUM)	")
        .append("	VALUES ( SEQ_NOT_NUM.NEXTVAL, ?, ?, ?, SYSDATE, ?, ?)	");
        
        try {
            con = dbCon.getDbCon();
            pstmt = con.prepareStatement(insertNoticeList.toString());
                     
            pstmt.setString(1, ntDTO.getTitle());
            pstmt.setString(2, ntDTO.getContent());
            pstmt.setString(3, ntDTO.getName());
            pstmt.setString(4, ntDTO.getStatus_type());
            pstmt.setInt(5, ntDTO.getAcc_num());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.out.println("공지 추가 오류: " + e.getMessage());
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
    public boolean deletNotice(int notNum) throws SQLException {
    	DBConnection dbCon = DBConnection.getInstance();
    	Connection con =null;
    	PreparedStatement pstmt =null;
    	
    	StringBuilder deledteNoticeList =new StringBuilder();
    	
    	deledteNoticeList
        .append("	DELETE FROM NOTICE	")
        .append("	WHERE NOT_NUM=?	");
    	
    	try{
    	con = dbCon.getDbCon();
        pstmt = con.prepareStatement(deledteNoticeList.toString());
        
        pstmt.setInt(1, notNum);
        int result=pstmt.executeUpdate();
        return result>0;
    	}finally {
    		dbCon.dbClose(con, pstmt, null);
  
		}
    	
    }//deletNotice
    
    
    //updeate
    public boolean updateNotice(NoticeDTO ntDTO) {
        DBConnection dbCon = DBConnection.getInstance();
        
    	Connection con =null;
    	PreparedStatement pstmt =null;
        
        StringBuilder updateNoticeList = new StringBuilder();
        
        updateNoticeList
        .append("	UPDATE NOTICE SET TITLE=?, CONTENT=?, STATUS_TYPE=?	")
        .append("	WHERE NOT_NUM=?	");
        
        try {
        	con = dbCon.getDbCon();
            pstmt = con.prepareStatement(updateNoticeList.toString());
            		 
            pstmt.setString(1, ntDTO.getTitle());
            pstmt.setString(2, ntDTO.getContent());
            pstmt.setString(3, ntDTO.getStatus_type());
            pstmt.setInt(4, ntDTO.getNot_num());  // ACC_NUM 설정
            
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
	public int getTotalNoticeCount() throws SQLException {
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
			.append("	FROM notice	");
			
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
	public List<NoticeDTO> selectNoticeByPage(PaginationDTO pagination) throws SQLException {
		List<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder selectPageQuery = new StringBuilder();
			selectPageQuery
			.append("	SELECT * FROM (	")
			.append("		SELECT ROWNUM as rnum, not_num, title, content, name, input_date, status_type,acc_num	")
			.append("		FROM (	")
			.append("			SELECT not_num, title, content, name, input_date, status_type, acc_num	")
			.append("			FROM notice	")
			.append("			ORDER BY not_num DESC	")
			.append("		) WHERE ROWNUM <= ?	")
			.append("	) WHERE rnum >= ?	")
			;
			
			pstmt = con.prepareStatement(selectPageQuery.toString());
			pstmt.setInt(1, pagination.getEndRowNum());
			pstmt.setInt(2, pagination.getStartRowNum());
			
			rs = pstmt.executeQuery();
			
			NoticeDTO noticeDTO = null;
			
			while( rs.next() ) {
				noticeDTO = new NoticeDTO();
				noticeDTO.setNot_num(rs.getInt("not_num"));
				noticeDTO.setTitle(rs.getString("title"));
				noticeDTO.setContent(rs.getString("content"));
				noticeDTO.setName(rs.getString("name"));
				noticeDTO.setInput_date(rs.getDate("input_date"));
				noticeDTO.setStatus_type(rs.getString("status_type"));
				noticeDTO.setAcc_num(rs.getInt("acc_num"));
				
				noticeList.add(noticeDTO);
			} //end while
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return noticeList;
	} //selectUsersByPage

	/**
	 * 검색 조건에 따른 공지사항 수를 조회합니다.
	 * @param searchType 검색 유형 (name, email, tel)
	 * @param searchKeyword 검색어
	 * @return 검색 조건에 맞는 사용자 수
	 * @throws SQLException 예외처리
	 */
	public int getSearchNoticeCount(String searchType, String searchKeyword,String statusType) throws SQLException {
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
			.append("	FROM notice	")
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
	public List<NoticeDTO> searchNoticeByPage(String searchType, String searchKeyword,String statusType, PaginationDTO pagination) throws SQLException {
		List<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder searchQuery = new StringBuilder();
			searchQuery
			.append("	SELECT * FROM (	")
			.append("		SELECT ROWNUM as rnum, not_num, title, content, name, input_date, status_type,acc_num	")
			.append("		FROM (	")
			.append("			SELECT	not_num, title, content, name, input_date, status_type,acc_num	")
			.append("			FROM notice	")
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
			
			NoticeDTO noticeDTO = null;
			
			while( rs.next() ) {
				noticeDTO = new NoticeDTO();
				noticeDTO.setNot_num(rs.getInt("not_num"));
				noticeDTO.setTitle(rs.getString("title"));
				noticeDTO.setContent(rs.getString("content"));
				noticeDTO.setName(rs.getString("name"));
				noticeDTO.setInput_date(rs.getDate("input_date"));
				noticeDTO.setStatus_type(rs.getString("status_type"));
				noticeDTO.setAcc_num(rs.getInt("acc_num"));
				
				noticeList.add(noticeDTO);
			} //end while
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return noticeList;
	} //searchUsersByPage

} //class