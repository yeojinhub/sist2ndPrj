package user.mypage.favorite;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import user.DBConnection.DBConnection;

public class FavoriteDAO {
//	public List<FavoriteDTO> selectFavorite(String email) throws SQLException {
//	    List<FavoriteDTO> list = new ArrayList<>();
//	    Connection conn = null;
//	    PreparedStatement pstmt = null;
//	    ResultSet rs = null;
//
//	    DBConnection dbCon = DBConnection.getInstance();
//
//	    try {
//	        conn = dbCon.getDbCon();
//
//	        StringBuilder selectQuery = new StringBuilder();
//	        selectQuery.append("SELECT f.fav_num, f.acc_num, f.area_num, ")
//	                   .append("       f.name AS area_name, a.route AS area_path ")
//	                   .append("  FROM favorite f ")
//	                   .append("  JOIN area a ON f.area_num = a.area_num ")
//	                   .append(" WHERE f.acc_num = ( ")
//	                   .append("     SELECT acc_num ")
//	                   .append("       FROM account ")
//	                   .append("      WHERE USER_EMAIL = ? ")
//	                   .append(" )");
//
//	        pstmt = conn.prepareStatement(selectQuery.toString());
//	        pstmt.setString(1, email);
//
//	        rs = pstmt.executeQuery();
//
//	        while (rs.next()) {
//	            FavoriteDTO dto = new FavoriteDTO();
//	            dto.setFav_num(rs.getInt("fav_num"));
//	            dto.setAcc_num(rs.getInt("acc_num"));
//	            dto.setArea_num(rs.getInt("area_num"));
//	            dto.setArea_name(rs.getString("area_name"));
//	            dto.setArea_path(rs.getString("area_path"));
//	            list.add(dto);
//	        }
//
//	    } finally {
//	        dbCon.dbClose(conn, pstmt, rs);
//	    }
//
//	    return list;
//	}
	public List<FavoriteDTO> selectFavoriteWithPaging(String email, int startRow, int endRow) throws SQLException {
	    List<FavoriteDTO> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    DBConnection dbCon = DBConnection.getInstance();

	    try {
	        conn = dbCon.getDbCon();

	        StringBuilder sql = new StringBuilder();
	        sql.append("SELECT * FROM (")
	           .append("  SELECT ROWNUM rnum, inner_query.* FROM (")
	           .append("    SELECT f.fav_num, f.acc_num, f.area_num, a.name AS area_name, a.route AS area_path ")
	           .append("      FROM favorite f ")
	           .append("      JOIN area a ON f.area_num = a.area_num ")
	           .append("     WHERE f.acc_num = (")
	           .append("       SELECT acc_num FROM account WHERE user_email = ?")
	           .append("     ) ")
	           .append("     ORDER BY f.fav_num DESC ")
	           .append("  ) inner_query ")
	           .append(") ")
	           .append("WHERE rnum BETWEEN ? AND ?");

	        pstmt = conn.prepareStatement(sql.toString());
	        pstmt.setString(1, email);
	        pstmt.setInt(2, startRow);
	        pstmt.setInt(3, endRow);

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            FavoriteDTO dto = new FavoriteDTO();
	            dto.setFav_num(rs.getInt("fav_num"));
	            dto.setAcc_num(rs.getInt("acc_num"));
	            dto.setArea_num(rs.getInt("area_num"));
	            dto.setArea_name(rs.getString("area_name"));
	            dto.setArea_path(rs.getString("area_path"));
	            list.add(dto);
	        }

	    } finally {
	        dbCon.dbClose(conn, pstmt, rs);
	    }

	    return list;
	}
	
	public int selectFavoriteCnt(String email) throws SQLException {
	    int count = 0;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    DBConnection dbCon = DBConnection.getInstance();

	    try {
	        conn = dbCon.getDbCon();
	        String sql = "SELECT COUNT(*) FROM favorite WHERE acc_num = (SELECT acc_num FROM account WHERE user_email = ?)";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, email);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            count = rs.getInt(1);
	        }

	    } finally {
	        dbCon.dbClose(conn, pstmt, rs);
	    }

	    return count;
	}
	
	public int deleteFavorite(List<Integer> favNums) throws SQLException {
	    if (favNums == null || favNums.isEmpty()) return 0;

	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    DBConnection dbCon = DBConnection.getInstance();
	    int deletedCount = 0;

	    try {
	        conn = dbCon.getDbCon();

	        StringBuilder deleteQuery = new StringBuilder();
	        deleteQuery.append("DELETE FROM favorite WHERE fav_num IN (");
	        
	        // fav_num 개수에 맞게 물음표(?) 채우기
	        for (int i = 0; i < favNums.size(); i++) {
	        	deleteQuery.append("?");
	            if (i < favNums.size() - 1) {
	            	deleteQuery.append(", ");
	            }
	        }
	        deleteQuery.append(")");

	        pstmt = conn.prepareStatement(deleteQuery.toString());

	        // 파라미터 바인딩
	        for (int i = 0; i < favNums.size(); i++) {
	            pstmt.setInt(i + 1, favNums.get(i));
	        }

	        deletedCount = pstmt.executeUpdate();

	    } finally {
	        dbCon.dbClose(conn, pstmt, null);
	    }

	    return deletedCount;
	}
}
