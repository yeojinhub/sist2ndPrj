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
 
  }// class
