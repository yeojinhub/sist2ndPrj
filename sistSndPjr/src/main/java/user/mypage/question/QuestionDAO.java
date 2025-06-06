package user.mypage.question;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import user.DBConnection.DBConnection;


public class QuestionDAO {
	
	  public List<QuestionDTO> selectQuestionByEmailWithPaging(String email, String type, String keyword, int startRow, int endRow) throws SQLException {
		    List<QuestionDTO> list = new ArrayList<>();
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;

		    DBConnection dbCon = DBConnection.getInstance();

		    try {
		        conn = dbCon.getDbCon();

		        StringBuilder sql = new StringBuilder();
		        sql.append("SELECT * FROM (")
		           .append("    SELECT ROWNUM rnum, inner_query.* FROM (")
		           .append("        SELECT i.inq_num, i.title, i.acc_num, i.content, i.status_type, i.input_date, i.name, ")
		           .append("               a.content AS answer_content ")
		           .append("          FROM inquiry i ")
		           .append("          LEFT OUTER JOIN answer a ON i.inq_num = a.inq_num ")
		           .append("         WHERE i.acc_num = (SELECT acc_num FROM account WHERE user_email = ?) ");

		        if (type != null && keyword != null && !keyword.trim().isEmpty()) {
		            if ("제목".equals(type)) {
		                sql.append("AND i.title LIKE ? ");
		            } else if ("내용".equals(type)) {
		                sql.append("AND i.content LIKE ? ");
		            }
		        }

		        sql.append("         ORDER BY i.input_date DESC ")
		           .append("    ) inner_query ")
		           .append(") ")
		           .append("WHERE rnum BETWEEN ? AND ?");

		        pstmt = conn.prepareStatement(sql.toString());
		        int paramIndex = 1;

		        pstmt.setString(paramIndex++, email);

		        if (type != null && keyword != null && !keyword.trim().isEmpty()) {
		            pstmt.setString(paramIndex++, "%" + keyword.trim() + "%");
		        }

		        pstmt.setInt(paramIndex++, startRow);
		        pstmt.setInt(paramIndex++, endRow);

		        rs = pstmt.executeQuery();

		        while (rs.next()) {
		            QuestionDTO qDTO = new QuestionDTO();
		            qDTO.setInq_num(rs.getInt("inq_num"));
		            qDTO.setTitle(rs.getString("title"));
		            qDTO.setAcc_num(rs.getInt("acc_num"));
		            qDTO.setContent(rs.getString("content"));
		            qDTO.setStatus(rs.getString("status_type"));
		            qDTO.setInput_date(rs.getDate("input_date"));
		            qDTO.setName(rs.getString("name"));
		            qDTO.setAnswer_content(rs.getString("answer_content"));
		            list.add(qDTO);
		        }

		    } finally {
		        dbCon.dbClose(conn, pstmt, rs);
		    }

		    return list;
		}

	
	public int selectQuestionCnt(String email, String type, String keyword) throws SQLException {
	    int cnt = 0;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    DBConnection dbCon = DBConnection.getInstance();

	    try {
	        conn = dbCon.getDbCon();

	        StringBuilder selectQuery = new StringBuilder();
	        selectQuery.append("SELECT i.inq_num, i.title, i.acc_num, i.content, i.status_type, i.input_date, i.name, ")
	                   .append("       a.content AS answer_content ")
	                   .append("  FROM inquiry i ")
	                   .append("  LEFT OUTER JOIN answer a ON i.inq_num = a.inq_num ")
	                   .append(" WHERE i.acc_num = (SELECT acc_num FROM account WHERE user_email = ?) ");

	        if (type != null && keyword != null && !keyword.trim().isEmpty()) {
	            if ("제목".equals(type)) {
	                selectQuery.append("AND i.title LIKE ? ");
	            } else if ("내용".equals(type)) {
	                selectQuery.append("AND i.content LIKE ? ");
	            }
	        }

	        selectQuery.append("ORDER BY i.input_date DESC");

	        pstmt = conn.prepareStatement(selectQuery.toString());
	        pstmt.setString(1, email);

	        if (type != null && keyword != null && !keyword.trim().isEmpty()) {
	            pstmt.setString(2, "%" + keyword.trim() + "%");
	        }

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            cnt++;
	        }

	    } finally {
	        dbCon.dbClose(conn, pstmt, rs);
	    }

	    return cnt;
	}
	
	
	public QuestionDTO selectQuestionDetail(int inqNum) throws SQLException {
	    QuestionDTO dto = null;

	    DBConnection dbCon = DBConnection.getInstance();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        conn = dbCon.getDbCon();

	        StringBuilder sql = new StringBuilder();
	        sql.append("SELECT i.inq_num, i.title, i.content, i.name, i.input_date, i.status_type, ")
	           .append("       a.content AS answer_content ")
	           .append("  FROM inquiry i ")
	           .append("  LEFT OUTER JOIN answer a ON i.inq_num = a.inq_num ")
	           .append(" WHERE i.inq_num = ?");

	        pstmt = conn.prepareStatement(sql.toString());
	        pstmt.setInt(1, inqNum);

	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            dto = new QuestionDTO();
	            dto.setInq_num(rs.getInt("inq_num"));
	            dto.setTitle(rs.getString("title"));
	            dto.setContent(rs.getString("content"));
	            dto.setName(rs.getString("name"));
	            dto.setInput_date(rs.getDate("input_date"));
	            dto.setStatus(rs.getString("status_type"));
	            dto.setAnswer_content(rs.getString("answer_content")); // null이면 JSP에서 안내 문구 출력
	        }

	    } finally {
	        dbCon.dbClose(conn, pstmt, rs);
	    }

	    return dto;
	}
	
	public void insertQuestion(String email, String name, String title, String content) throws SQLException {
	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    DBConnection dbCon = DBConnection.getInstance();

	    try {
	        conn = dbCon.getDbCon();

	        StringBuilder insertQuery = new StringBuilder();
	        insertQuery.append("INSERT INTO inquiry (inq_num, acc_num, name, title, content) ")
            .append("VALUES ( ")
            .append("SEQ_INQ_NUM.NEXTVAL, ")
            .append("(SELECT acc_num FROM account WHERE user_email = ?), ")
            .append("?, ?, ? )");

	        pstmt = conn.prepareStatement(insertQuery.toString());
	        
	        pstmt.setString(1, email);   // acc_num을 찾기 위한 email
	        pstmt.setString(2, name);    // name은 JSP에서 확보
	        pstmt.setString(3, title);   // 제목
	        pstmt.setString(4, content); // 내용

	        
	        pstmt.executeUpdate();

	    } finally {
	        dbCon.dbClose(conn, pstmt, null);
	    }
	}
	
	public void deleteQuestion(int inqNum) throws SQLException {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    DBConnection dbCon = DBConnection.getInstance();

	    try {
	        conn = dbCon.getDbCon();
	        String sql = "DELETE FROM inquiry WHERE inq_num = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, inqNum);
	        pstmt.executeUpdate();
	    } finally {
	        dbCon.dbClose(conn, pstmt, null);
	    }
	}


}
