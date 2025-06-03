package restarea.detail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DBConnection.DBConnection;
import DTO.AreaDetailDTO;

public class RestAreaDetailDAO {

	public AreaDetailDTO selectRestAreaDetail(int num) throws SQLException{
		AreaDetailDTO adDTO = null;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = dbCon.getDbCon();
			
			StringBuilder selectQuery = new StringBuilder();
			selectQuery
			.append(" SELECT A.AREA_NUM, NAME, ROUTE, ADDR, TEL, OPERATION_TIME, LAT, LNG, FEED, SLEEP, SHOWER, LAUNDRY, CLINIC, PHARMACY, SHELTER, SALON, REPAIR, WASH, TRUCK ")
			.append(" FROM AREA A, FACILITY F ")
			.append(" WHERE A.AREA_NUM = F.AREA_NUM AND A.AREA_NUM = ? ");
			
			pstmt = conn.prepareStatement(selectQuery.toString());
			
			// 바인드 변수 할당
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
			    adDTO = new AreaDetailDTO();
			    adDTO.setArea_num(rs.getInt("AREA_NUM"));
			    adDTO.setName(rs.getString("NAME"));
			    adDTO.setRoute(rs.getString("ROUTE"));
			    adDTO.setAddr(rs.getString("ADDR"));
			    adDTO.setTel(rs.getString("TEL"));
			    adDTO.setOperation_time(rs.getString("OPERATION_TIME"));
			    adDTO.setLat(rs.getFloat("LAT"));
			    adDTO.setLng(rs.getFloat("LNG"));
			    adDTO.setFeed(rs.getString("FEED"));
			    adDTO.setSleep(rs.getString("SLEEP"));
			    adDTO.setShower(rs.getString("SHOWER"));
			    adDTO.setLaundry(rs.getString("LAUNDRY"));
			    adDTO.setClinic(rs.getString("CLINIC"));
			    adDTO.setPharmacy(rs.getString("PHARMACY"));
			    adDTO.setShelter(rs.getString("SHELTER"));
			    adDTO.setSalon(rs.getString("SALON"));
			    adDTO.setRepair(rs.getString("REPAIR"));
			    adDTO.setWash(rs.getString("WASH"));
			    adDTO.setTruck(rs.getString("TRUCK"));
			}// end if
			
		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		}// end try-finally
		
		return adDTO;
	}// selectRestAreaDetail
	
}// class
