package Notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import DTO.NoticeDTO;

public class NoticeDAO {
	
	public List<NoticeDTO> selectAllNotice()throws SQLException{
		
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		
		DBConnection db = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			
			con = db.getDbCon();
			
			StringBuilder selectAllNotice = new StringBuilder();
			selectAllNotice
			.append("	select not_num, title, content, name, input_date, status_type	")
			.append("	from notice	")
			.append("	order by input_date desc	");
			
			pstmt = con.prepareStatement( selectAllNotice.toString() );
			
			rs = pstmt.executeQuery();
			
			NoticeDTO nDTO = null;
			while( rs.next() ) {
				nDTO = new NoticeDTO();
				nDTO.setNot_num( rs.getInt("not_num"));
				nDTO.setTitle( rs.getString("title"));
				nDTO.setContent( rs.getString("content"));
				nDTO.setName( rs.getString("name"));
				nDTO.setInput_date( rs.getDate("input_date"));
				nDTO.setStatus_type( rs.getString("status_type"));
				
				list.add(nDTO);
			}
			
		}finally {
			db.dbClose(con, pstmt, rs);
		}
		
		
		return list;
	}
	
	public NoticeDTO selectOneNotice(int num) throws SQLException {
		
		NoticeDTO nDTO = null;
		
		DBConnection db = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			
			con = db.getDbCon();
			
			StringBuilder selectOneNotice = new StringBuilder();
			selectOneNotice
			.append("	select not_num, title, content, name, input_date, status_type	")
			.append("	from notice	")
			.append("	where not_num=?	");
			
			pstmt = con.prepareStatement(selectOneNotice.toString());
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
				nDTO = new NoticeDTO();
				nDTO.setNot_num( rs.getInt("not_num"));
				nDTO.setTitle( rs.getString("title"));
				nDTO.setContent( rs.getString("content"));
				nDTO.setName( rs.getString("name"));
				nDTO.setInput_date(rs.getDate("input_date"));
				nDTO.setStatus_type( rs.getString("status_type"));
				
			}
			
		}finally {
			db.dbClose(con, pstmt, rs);
		}
		
		return nDTO;
		
	}
	
}
