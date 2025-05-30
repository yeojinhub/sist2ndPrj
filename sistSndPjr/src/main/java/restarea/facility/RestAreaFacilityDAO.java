package restarea.facility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import DTO.AreaFacilityDTO;
import DTO.FacilityDTO;
import DTO.NoticeDTO;

public class RestAreaFacilityDAO {
	
	public int selectTotalCount( DTO.RangeDTO rDTO)throws SQLException{
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
			.append("	select count(area_num) cnt	")
			.append("	from facility	");
			
			pstmt = con.prepareStatement(selectNumQuery.toString());

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
	public List<AreaFacilityDTO> selectFacility(DTO.RangeDTO rDTO)throws SQLException{
	
	List<AreaFacilityDTO> list = new ArrayList<AreaFacilityDTO>();
	
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
		StringBuilder selectAreaFacility = new StringBuilder();
		selectAreaFacility
		.append("	select *	")
		.append("	from(select f.AREA_NUM,f.FEED,f.SLEEP,f.SHOWER,f.LAUNDRY,f.CLINIC,f.PHARMACY,f.SHELTER,f.SALON,f.REPAIR,f.WASH,f.TRUCK,f.TEMP, 	")
		.append("	a.NAME,a.ROUTE,a.TEL, 	")
		.append("	row_number() over(order by f.area_num) rnum	")
		.append("	from facility f join area a on f.area_num = a.area_num)	sub	")
		.append("	where rnum between ? and ?	");
		
		pstmt = con.prepareStatement(selectAreaFacility.toString());
	//5.바인드변수에 값 할당
		int bindInd = 1;
		pstmt.setInt(bindInd++, rDTO.getStartNum());
		pstmt.setInt(bindInd++, rDTO.getEndNum());
		
	//6.쿼리문 수행 후 결과 얻기
		rs = pstmt.executeQuery();
		
		AreaFacilityDTO afDTO = null;
		while( rs.next()) {
			afDTO = new AreaFacilityDTO();
			afDTO.setArea_num(rs.getInt("area_num"));
			afDTO.setFeed(rs.getString("feed"));
			afDTO.setSleep(rs.getString("sleep"));
			afDTO.setShower(rs.getString("shower"));
			afDTO.setLaundry(rs.getString("laundry"));
			afDTO.setClinic(rs.getString("clinic"));
			afDTO.setPharmacy(rs.getString("pharmacy"));
			afDTO.setShelter(rs.getString("shelter"));
			afDTO.setSalon(rs.getString("salon"));
			afDTO.setRepair(rs.getString("repair"));
			afDTO.setWash(rs.getString("wash"));
			afDTO.setTruck(rs.getString("truck"));
			afDTO.setTemp(rs.getString("temp"));
			afDTO.setName(rs.getString("name"));
			afDTO.setRoute(rs.getString("route"));
			afDTO.setTel(rs.getString("tel"));
			
			
			list.add(afDTO);
		}
	}finally {
	//7.연결 끊기
		db.dbClose(con, pstmt, rs);
	}
		

	return list;
	
}
	
	
	public List<AreaFacilityDTO> selectAllAreaFacility()throws SQLException{
		
		List<AreaFacilityDTO> list = new ArrayList<AreaFacilityDTO>();
		
		DBConnection db = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			
			con = db.getDbCon();
			
			StringBuilder selectAllAreaFacility = new StringBuilder();
			selectAllAreaFacility
			.append("	select *	")
			.append("	from(select f.AREA_NUM,f.FEED,f.SLEEP,f.SHOWER,f.LAUNDRY,f.CLINIC,f.PHARMACY,f.SHELTER,f.SALON,f.REPAIR,f.WASH,f.TRUCK,f.TEMP, 	")
			.append("	a.NAME,a.ROUTE,a.TEL 	")
			.append("	from facility f join area a on f.area_num = a.area_num)	sub	")
			.append("	order by name	");
			
			pstmt = con.prepareStatement( selectAllAreaFacility.toString() );
			
			rs = pstmt.executeQuery();
			
			AreaFacilityDTO afDTO = null;
			while( rs.next() ) {
				afDTO = new AreaFacilityDTO();
				afDTO.setArea_num(rs.getInt("area_num"));
				afDTO.setFeed(rs.getString("feed"));
				afDTO.setSleep(rs.getString("sleep"));
				afDTO.setShower(rs.getString("shower"));
				afDTO.setLaundry(rs.getString("laundry"));
				afDTO.setClinic(rs.getString("clinic"));
				afDTO.setPharmacy(rs.getString("pharmacy"));
				afDTO.setShelter(rs.getString("shelter"));
				afDTO.setSalon(rs.getString("salon"));
				afDTO.setRepair(rs.getString("repair"));
				afDTO.setWash(rs.getString("wash"));
				afDTO.setTruck(rs.getString("truck"));
				afDTO.setTemp(rs.getString("temp"));
				afDTO.setName(rs.getString("name"));
				afDTO.setRoute(rs.getString("route"));
				afDTO.setTel(rs.getString("tel"));
				
				
				list.add(afDTO);
			}
			
		}finally {
			db.dbClose(con, pstmt, rs);
		}
		
		
		return list;
	}
	
}
