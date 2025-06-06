package user.notice.faq;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import user.DBConnection.DBConnection;

public class FAQDAO {
	
public List<FAQDTO> selectAllFAQ()throws SQLException{
		
		List<FAQDTO> list = new ArrayList<FAQDTO>();
		
		DBConnection db = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			
			con = db.getDbCon();
			
			StringBuilder selectAllFAQ = new StringBuilder();
			selectAllFAQ
			.append("	select faq_num, title, content, name, input_date, acc_num	")
			.append("	from faq	");
			
			pstmt = con.prepareStatement( selectAllFAQ.toString() );
			
			rs = pstmt.executeQuery();
			
			FAQDTO fDTO = null;
			while( rs.next() ) {
				fDTO = new FAQDTO();
				fDTO.setFaq_num( rs.getInt("faq_num"));
				fDTO.setTitle( rs.getString("title"));
				fDTO.setContent( rs.getString("content"));
				fDTO.setName( rs.getString("name"));
				fDTO.setInput_date( rs.getDate("input_date"));
				fDTO.setAcc_num( rs.getInt("acc_num"));
				
				list.add(fDTO);
			}
			
		}finally {
			db.dbClose(con, pstmt, rs);
		}
		
		
		return list;
	}

}
