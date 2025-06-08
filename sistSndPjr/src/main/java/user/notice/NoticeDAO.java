package user.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import user.DBConnection.DBConnection;

public class NoticeDAO {
	
	public int selectTotalCount(user.util.RangeDTO rDTO)throws SQLException{
		int cnt = 0;
		
		DBConnection db = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
		//1.JNDI 사용객체 생성
		//2.DBCP에서 연결객체얻기(DataSource)
		//3.Connection얻기
			con = db.getDbCon();
		//4.쿼리문 생성객체 얻기
			StringBuilder selectNumQuery = new StringBuilder();
			selectNumQuery
			.append("	select count(not_num) cnt	")
			.append("	from notice	");
			
			//검색키워드가 존재
			if(rDTO.getKeyword() != null && !"".equals(rDTO.getKeyword())) {
				selectNumQuery.append("where instr(").append(rDTO.getFieldName())
				.append(" ,?) != 0");
			}
			
			pstmt = con.prepareStatement(selectNumQuery.toString());

			//5.바인드변수에 값 할당
			if(rDTO.getKeyword() != null && !"".equals(rDTO.getKeyword())) {
				pstmt.setString(1, rDTO.getKeyword());
			}
			
		//6.쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			if(rs.next()) { //검색결과 있으면 true | false
				cnt = rs.getInt("cnt");
			}
			
		}finally {
		//7.연결 끊기
			db.dbClose(con, pstmt, rs);
		}
		
		return cnt;
	}
	
		/**
		 * 시작번호와 끝번호 사이에 있는 레코드를 얻는일
		 * @param rDTO
		 * @return
		 * @throws SQLException
		 */
		public List<NoticeDTO> selectNotice(user.util.RangeDTO rDTO)throws SQLException{
		
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		
		DBConnection db = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
		//1.JNDI 사용객체 생성
		//2.DBCP에서 연결객체얻기(DataSource)
		//3.Connection얻기
			con = db.getDbCon();
		//4.쿼리문 생성객체 얻기
			StringBuilder selectNotice = new StringBuilder();
			selectNotice
			.append("	select not_num, title, content, name, input_date, status_type	")
			.append("	from(select not_num, title, content, name, input_date, status_type, 	")
			.append("	row_number() over(order by not_num desc) rnum 	")
			.append("	from notice	");
			
			if(rDTO.getKeyword() != null && !"".equals(rDTO.getKeyword())) {
				selectNotice.append("where instr(").append(rDTO.getFieldName())
				.append(" ,?) != 0");
			}
			
			selectNotice.append(")	where rnum between ? and ?	");
			
			pstmt = con.prepareStatement(selectNotice.toString());
		//5.바인드변수에 값 할당
			int bindInd = 1;
			if(rDTO.getKeyword() != null && !"".equals(rDTO.getKeyword())) {
				pstmt.setString(bindInd++, rDTO.getKeyword());
			}
			pstmt.setInt(bindInd++, rDTO.getStartNum());
			pstmt.setInt(bindInd++, rDTO.getEndNum());
			
		//6.쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			NoticeDTO nDTO = null;
			while( rs.next()) {
				nDTO = new NoticeDTO();
				nDTO.setNot_num(rs.getInt("not_num"));
				nDTO.setTitle(rs.getString("title"));
				nDTO.setContent(rs.getString("content"));
				nDTO.setName(rs.getString("name"));
				nDTO.setInput_date(rs.getDate("input_date"));
				nDTO.setStatus_type(rs.getString("status_type"));
				
				list.add(nDTO);
			}
		}finally {
		//7.연결 끊기
			db.dbClose(con, pstmt, rs);
		}
			

		return list;
		
	}
	
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
			.append("	order by not_num desc	");
			
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
	
	public List<NoticeDTO> selectMainNotice()throws SQLException{
		
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		
		DBConnection db = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			
			con = db.getDbCon();
			
			StringBuilder selectMainNotice = new StringBuilder();
			selectMainNotice
			.append("	select not_num,title,input_date ")
			.append("	from notice	")
			.append("	order by not_num desc	")
			.append("	fetch first 4 rows only	");
			
			pstmt = con.prepareStatement( selectMainNotice.toString() );
			
			rs = pstmt.executeQuery();
			
			NoticeDTO nDTO = null;
			while( rs.next() ) {
				nDTO = new NoticeDTO();
				nDTO.setNot_num( rs.getInt("not_num"));
				nDTO.setTitle( rs.getString("title"));
				nDTO.setInput_date( rs.getDate("input_date"));
				
				list.add(nDTO);
			}
			
		}finally {
			db.dbClose(con, pstmt, rs);
		}
		
		
		return list;
	}
	
}
