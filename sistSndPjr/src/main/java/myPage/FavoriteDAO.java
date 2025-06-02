package myPage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import DTO.FavoriteDTO;

public class FavoriteDAO {
	public List<FavoriteDTO> selectFavorite(String email) throws SQLException {
	    List<FavoriteDTO> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    DBConnection dbCon = DBConnection.getInstance();

	    try {
	        conn = dbCon.getDbCon();

	        StringBuilder selectQuery = new StringBuilder();
	        selectQuery.append("SELECT f.fav_num, f.acc_num, f.area_num, ")
	                   .append("       f.name AS area_name, a.route AS area_path ")
	                   .append("  FROM favorite f ")
	                   .append("  JOIN area a ON f.area_num = a.area_num ")
	                   .append(" WHERE f.acc_num = ( ")
	                   .append("     SELECT acc_num ")
	                   .append("       FROM account ")
	                   .append("      WHERE USER_EMAIL = ? ")
	                   .append(" )");

	        pstmt = conn.prepareStatement(selectQuery.toString());
	        pstmt.setString(1, email);

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
