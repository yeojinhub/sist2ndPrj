package user.restarea.detail.food;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import user.DBConnection.DBConnection;

public class RestAreaDetailFoodDAO {

	public List<AreaDetailFoodDTO> selectAllFood(int area_num) throws SQLException{
		List<AreaDetailFoodDTO> list = new ArrayList<AreaDetailFoodDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = dbCon.getDbCon();
			
			String selectQuery = " SELECT * FROM FOOD WHERE AREA_NUM = ? ";
			
			pstmt = conn.prepareStatement(selectQuery);
			
			// 바인드 변수 할당
			pstmt.setInt(1, area_num);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				AreaDetailFoodDTO adfDTO = new AreaDetailFoodDTO();
				adfDTO.setArea_num(rs.getInt("AREA_NUM"));
				adfDTO.setFood_num(rs.getInt("FOOD_NUM"));
				adfDTO.setPrice(String.format("%,d원", rs.getInt("PRICE")));
				adfDTO.setName(rs.getString("NAME"));
				list.add(adfDTO);
			}// end while
			
		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		}// end try-finally
		
		return list;
	}// selectAllFood
	
}
