package Answer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DBConnection.DBConnection;

public class AnswerDAO {

    private static AnswerDAO instance;

    private AnswerDAO() {
    	
    }

    public static AnswerDAO getInstance() {
        if (instance == null) {
            instance = new AnswerDAO();
        }
        return instance;
    }

    // 답변 등르 및 상태변경
    public AnswerDTO insertAnswer(int inqNum, String content, String writer) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement updateStmt = null;

        try {
            conn = DBConnection.getInstance().getDbCon(); 
            conn.setAutoCommit(false);

            // 1. 답변 등록
            StringBuilder insertAnswerList= new StringBuilder();
            insertAnswerList
            .append("	INSERT INTO answer (inq_num, content, name, input_date)	")
            .append("	VALUES (?, ?, ?, SYSDATE)	");
            
            
            pstmt = conn.prepareStatement(insertAnswerList.toString());
            pstmt.setInt(1, inqNum);
            pstmt.setString(2, content);
            pstmt.setString(3, writer);
            int result1 = pstmt.executeUpdate();

            // 2. 문의 싱태 업데이트 - 대기, 답변완료
            StringBuilder updateAnswerStatus= new StringBuilder();
            updateAnswerStatus
            .append("	UPDATE inquiry	")
            .append("	SET status_type = '답변완료'	")
            .append("	WHERE inq_num = ?	");
            
            updateStmt = conn.prepareStatement(updateAnswerStatus.toString());
            updateStmt.setInt(1, inqNum);
            int result2 = updateStmt.executeUpdate();

            if (result1 > 0 && result2 > 0) {
                conn.commit();
                // 답변 다시 조회해서 리턴 - 안하면 안보임
                return getAnswerByInquiryNum(inqNum);
            } else {
                conn.rollback();
                return null;
            }
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (updateStmt != null) updateStmt.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }


    // 답변 조회
    public AnswerDTO getAnswerByInquiryNum(int inqNum) throws SQLException {
        
        StringBuilder getAnswerNum=new StringBuilder();
        getAnswerNum
        .append("	SELECT *			")
        .append("	FROM answer			")
        .append("	WHERE inq_num = ?	");
        
        try (Connection conn =  DBConnection.getInstance().getDbCon(); 
             PreparedStatement pstmt = conn.prepareStatement(getAnswerNum.toString())) {
            pstmt.setInt(1, inqNum);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                AnswerDTO dto = new AnswerDTO();
                dto.setInq_num(rs.getInt("inq_num"));
                dto.setContent(rs.getString("content"));
                dto.setName(rs.getString("name"));
                dto.setInput_date(rs.getDate("input_date")); 
                return dto;
            }
        }
        return null;
    }
}