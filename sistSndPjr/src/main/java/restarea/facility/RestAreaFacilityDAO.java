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

	public List<String> selectAllRoute() throws SQLException {
		List<String> list = new ArrayList<String>();

		DBConnection db = DBConnection.getInstance();

		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
			// 1.JNDI 사용객체 생성
			// 2.DBCP에서 연결객체얻기(DataSource)
			// 3.Connection얻기
			con = db.getDbCon();
			// 4.쿼리문 생성객체 얻기
			StringBuilder selectQuery = new StringBuilder();
			selectQuery.append("	SELECT DISTINCT ROUTE	")
							.append("	FROM AREA	");

			pstmt = con.prepareStatement(selectQuery.toString());

			// 6.쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();

			while(rs.next()) {
				list.add(rs.getString("ROUTE"));
			}// end while

		} finally {
			// 7.연결 끊기
			db.dbClose(con, pstmt, rs);
		}

		return list;
	}// selectAllRoute

	public int selectTotalCount(DTO.RangeDTO rDTO) throws SQLException {
		int cnt = 0;
	    DBConnection db = DBConnection.getInstance();

	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    Connection con = null;
	    try {
	        con = db.getDbCon();

	        StringBuilder selectQuery = new StringBuilder();
	        selectQuery.append(" SELECT COUNT(*) CNT ")
	                   .append(" FROM AREA ");

	        // 동적 조건 리스트
	        List<String> conditions = new ArrayList<>();
	        List<Object> params = new ArrayList<>();

	        String route = rDTO.getRoute();
	        String keyword = rDTO.getKeyword();
	        String repair = rDTO.getRepair();
	        String truck = rDTO.getTruck();

	        if (route != null && !route.equals("select")) {
	            conditions.add("INSTR(ROUTE, ?) != 0");
	            params.add(route);
	        }
	        if (keyword != null && !keyword.isEmpty()) {
	            conditions.add("INSTR(NAME, ?) != 0");
	            params.add(keyword);
	        }
	        if (repair != null) {
	            conditions.add("REPAIR = 'O'");
	        }
	        if (truck != null) {
	            conditions.add("TRUCK = 'O'");
	        }

	        // 조건이 있으면 AND로 붙이기
	        if (!conditions.isEmpty()) {
	        	selectQuery.append(" WHERE ");
	            selectQuery.append(String.join(" AND ", conditions));
	        }

	        pstmt = con.prepareStatement(selectQuery.toString());

	        // 바인드 변수 세팅
	        int idx = 1;
	        for (Object param : params) {
	            pstmt.setString(idx++, param.toString());
	        }

	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            cnt = rs.getInt("cnt");
	        }
	    } finally {
	        db.dbClose(con, pstmt, rs);
	    }
	    return cnt;
	}// selectTotalCount

	/**
	 * 시작번호와 끝번호 사이에 있는 레코드를 얻는일
	 * 
	 * @param rDTO
	 * @return
	 * @throws SQLException
	 */
	public List<AreaFacilityDTO> selectFacility(DTO.RangeDTO rDTO) throws SQLException {

		List<AreaFacilityDTO> list = new ArrayList<AreaFacilityDTO>();

		DBConnection db = DBConnection.getInstance();

	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    Connection con = null;
	    try {
	        con = db.getDbCon();

	        StringBuilder query = new StringBuilder();
	        query.append(" SELECT * FROM ( ")
	             .append(" SELECT ")
	             .append(" AREA_NUM, FEED, SLEEP, SHOWER, LAUNDRY, CLINIC, PHARMACY, SHELTER, SALON, REPAIR, TRUCK, TEMP, NAME, ROUTE, TEL, ")
	             .append(" ROW_NUMBER() OVER(ORDER BY AREA_NUM) RNUM ")
	             .append(" FROM ( ")
	             .append(" SELECT AREA_NUM, FEED, SLEEP, SHOWER, LAUNDRY, CLINIC, PHARMACY, SHELTER, SALON, REPAIR, TRUCK, TEMP, NAME, ROUTE, TEL ")
	             .append(" FROM AREA ");

	        List<Object> params = new ArrayList<>();
	        List<String> conditions = new ArrayList<>(); // 조건 리스트 생성

	        // 조건 추가 방식 변경
	        if (rDTO.getRoute() != null && !rDTO.getRoute().equals("select")) {
	            conditions.add("INSTR(ROUTE, ?) != 0");
	            params.add(rDTO.getRoute());
	        }
	        if (rDTO.getKeyword() != null && !rDTO.getKeyword().isEmpty()) {
	            conditions.add("INSTR(NAME, ?) != 0");
	            params.add(rDTO.getKeyword());
	        }
	        if (rDTO.getRepair() != null) {
	            conditions.add("REPAIR = 'O'");
	        }
	        if (rDTO.getTruck() != null) {
	            conditions.add("TRUCK = 'O'");
	        }

	        // ▼ WHERE 조건 추가 로직 변경
	        if (!conditions.isEmpty()) {
	            query.append(" WHERE ");
	            query.append(String.join(" AND ", conditions));
	        }

	        query.append("   ) ") // 서브쿼리 닫기
	             .append(" ) ")  // ROW_NUMBER() 서브쿼리 닫기
	             .append(" WHERE RNUM BETWEEN ? AND ? ");

	        pstmt = con.prepareStatement(query.toString());

	        // 바인드 변수 세팅
	        int idx = 1;
	        for (Object param : params) {
	            pstmt.setString(idx++, param.toString());
	        }
	        pstmt.setInt(idx++, rDTO.getStartNum()); // 시작 row
	        pstmt.setInt(idx, rDTO.getEndNum());     // 끝 row

	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	        	AreaFacilityDTO dto = new AreaFacilityDTO();
	            dto.setArea_num(rs.getInt("AREA_NUM"));
	            dto.setFeed(rs.getString("FEED"));
	            dto.setSleep(rs.getString("SLEEP"));
	            dto.setShower(rs.getString("SHOWER"));
	            dto.setLaundry(rs.getString("LAUNDRY"));
	            dto.setClinic(rs.getString("CLINIC"));
	            dto.setPharmacy(rs.getString("PHARMACY"));
	            dto.setShelter(rs.getString("SHELTER"));
	            dto.setSalon(rs.getString("SALON"));
	            dto.setRepair(rs.getString("REPAIR"));
	            dto.setTruck(rs.getString("TRUCK"));
	            dto.setTemp(rs.getString("TEMP"));
	            dto.setName(rs.getString("NAME"));
	            dto.setRoute(rs.getString("ROUTE"));
	            dto.setTel(rs.getString("TEL"));
	            list.add(dto);
	        }
	    } finally {
	        db.dbClose(con, pstmt, rs);
	    }
	        
	    return list;

	}

	public List<AreaFacilityDTO> selectAllAreaFacility() throws SQLException {

		List<AreaFacilityDTO> list = new ArrayList<AreaFacilityDTO>();

		DBConnection db = DBConnection.getInstance();

		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;

		try {

			con = db.getDbCon();

			StringBuilder selectAllAreaFacility = new StringBuilder();
			selectAllAreaFacility.append("	select *	").append(
					"	from(select f.AREA_NUM,f.FEED,f.SLEEP,f.SHOWER,f.LAUNDRY,f.CLINIC,f.PHARMACY,f.SHELTER,f.SALON,f.REPAIR,f.WASH,f.TRUCK,f.TEMP, 	")
					.append("	a.NAME,a.ROUTE,a.TEL 	")
					.append("	from facility f join area a on f.area_num = a.area_num)	sub	")
					.append("	order by name	");

			pstmt = con.prepareStatement(selectAllAreaFacility.toString());

			rs = pstmt.executeQuery();

			AreaFacilityDTO afDTO = null;
			while (rs.next()) {
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
				afDTO.setTruck(rs.getString("truck"));
				afDTO.setTemp(rs.getString("temp"));
				afDTO.setName(rs.getString("name"));
				afDTO.setRoute(rs.getString("route"));
				afDTO.setTel(rs.getString("tel"));

				list.add(afDTO);
			}

		} finally {
			db.dbClose(con, pstmt, rs);
		}

		return list;
	}

}
