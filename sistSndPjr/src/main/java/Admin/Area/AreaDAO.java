package Admin.Area;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import Pagination.PaginationDTO;

public class AreaDAO {
	
private static AreaDAO areaDAO;
	
	private AreaDAO() {
		
	} //AreaDAO
	
	public static AreaDAO getInstance() {
		if( areaDAO == null ) {
			areaDAO = new AreaDAO();
		} //end if
		
		return areaDAO;
	} //getInstance

	/**
	 * 전체 휴게소 수를 조회합니다.
	 * @return 전체 휴게소 수
	 * @throws SQLException 예외처리
	 */
	public int getTotalAreaCount() throws SQLException {
		int totalCount = 0;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder countQuery = new StringBuilder();
			countQuery
			.append("	SELECT COUNT(*) as total_count	")
			.append("	from area	")
			;
			
			pstmt = con.prepareStatement(countQuery.toString());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				totalCount = rs.getInt("total_count");
			} //end if
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return totalCount;
	} //getTotalAreaCount
	
	/**
	 * 페이지네이션을 적용하여 휴게소 목록을 조회합니다. (Oracle 11g 이하 - ROWNUM 사용)
	 * @param pagination 페이지네이션 정보
	 * @return 페이지에 해당하는 휴게소 목록
	 * @throws SQLException 예외처리
	 */
	public List<AreaDTO> selectAreasByPage(PaginationDTO pagination) throws SQLException {
		List<AreaDTO> areaList = new ArrayList<AreaDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder selectPageQuery = new StringBuilder();
			selectPageQuery
			.append("	SELECT * FROM (	")
			.append("		SELECT ROWNUM as rnum, area_num, name, route, tel, operation_time	")
			.append("		FROM (	")
			.append("			SELECT area_num, name, route, tel, operation_time	")
			.append("			FROM area	")
			.append("			ORDER BY route ASC, area_num DESC	")
			.append("		) WHERE ROWNUM <= ?	")
			.append("	) WHERE rnum >= ?	")
			;
			
			pstmt = con.prepareStatement(selectPageQuery.toString());
			pstmt.setInt(1, pagination.getEndRowNum());
			pstmt.setInt(2, pagination.getStartRowNum());
			
			rs = pstmt.executeQuery();
			
			AreaDTO areaDTO = null;
			
			while( rs.next() ) {
				areaDTO = new AreaDTO();
				areaDTO.setArea_num(rs.getInt("area_num"));
				areaDTO.setName(rs.getString("name"));
				areaDTO.setRoute(rs.getString("route"));
				areaDTO.setTel(rs.getString("tel"));
				areaDTO.setOperation_time(rs.getString("operation_time"));
				
				areaList.add(areaDTO);
			} //end while
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return areaList;
	} //selectAreasByPage
	
	/**
	 * 검색 조건에 따른 휴게소 목록을 페이지네이션으로 조회합니다. (Oracle 11g 이하 - ROWNUM 사용)
	 * @param searchType 검색 유형 (name, email, tel)
	 * @param searchKeyword 검색어
	 * @param pagination 페이지네이션 정보
	 * @return 검색 조건과 페이지에 해당하는 휴게소 목록
	 * @throws SQLException 예외처리
	 */
	public List<AreaDTO> searchAreasByPage(String searchType, String searchKeyword, PaginationDTO pagination) throws SQLException {
		List<AreaDTO> areaList = new ArrayList<AreaDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder searchQuery = new StringBuilder();
			searchQuery
			.append("	SELECT * FROM (	")
			.append("		SELECT ROWNUM as rnum, area_num, name, route, tel, operation_time	")
			.append("		FROM (	")
			.append("			SELECT area_num, name, route, tel, operation_time	")
			.append("			FROM area	")
			;
			
			// 검색어가 null이 아닌 경우에만 조건 추가 (PaginationUtil에서 이미 처리됨)
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				switch (searchType) {
					case "name":
						searchQuery.append("	where name LIKE ?	");
						break;
					case "route":
						searchQuery.append("	where route LIKE ?	");
						break;
				} //end switch
			} //end if
			
			searchQuery.append("			ORDER BY route	");
			searchQuery.append("		) WHERE ROWNUM <= ?	");
			searchQuery.append("	) WHERE rnum >= ?	");
			
			pstmt = con.prepareStatement(searchQuery.toString());
			
			int paramIndex = 1;
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				pstmt.setString(paramIndex++, "%" + searchKeyword + "%");
			} //end if
			pstmt.setInt(paramIndex++, pagination.getEndRowNum());
			pstmt.setInt(paramIndex, pagination.getStartRowNum());
			
			rs = pstmt.executeQuery();
			
			AreaDTO areaDTO = null;
			while( rs.next() ) {
				areaDTO = new AreaDTO();
				areaDTO.setArea_num(rs.getInt("area_num"));
				areaDTO.setName(rs.getString("name"));
				areaDTO.setRoute(rs.getString("route"));
				areaDTO.setTel(rs.getString("tel"));
				areaDTO.setOperation_time(rs.getString("operation_time"));
				
				areaList.add(areaDTO);
			} //end while
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return areaList;
	} //searchAreasByPage
	
	/**
	 * 검색 조건에 따른 휴게소 수를 조회합니다.
	 * @param searchType 검색 유형 (route, name)
	 * @param searchKeyword 검색어
	 * @return 검색 조건에 맞는 휴게소 수
	 * @throws SQLException 예외처리
	 */
	public int getSearchAreaCount(String searchType, String searchKeyword) throws SQLException {
		int totalCount = 0;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder countQuery = new StringBuilder();
			countQuery
			.append("	SELECT COUNT(*) as total_count	")
			.append("	FROM area	")
			;
			
			// 검색어가 null이 아닌 경우에만 조건 추가 (PaginationUtil에서 이미 처리됨)
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				switch (searchType) {
					case "name":
						countQuery.append("	where name LIKE ?	");
						break;
					case "route":
						countQuery.append("	where route LIKE ?	");
						break;
				} //end switch
			} //end if
			
			pstmt = con.prepareStatement(countQuery.toString());
			
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				pstmt.setString(1, "%" + searchKeyword + "%");
			} //end if
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				totalCount = rs.getInt("total_count");
			} //end if
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return totalCount;
	} //getSearchAreaCount
	
	/**
	 * 검색 조건에 따른 휴게소 목록을 페이지네이션으로 조회합니다. (Oracle 12c 이상)
	 * @param searchType 검색 유형 (name, email, tel)
	 * @param searchKeyword 검색어
	 * @param pagination 페이지네이션 정보
	 * @return 검색 조건과 페이지에 해당하는 휴게소 목록
	 * @throws SQLException 예외처리
	 */
	public List<AreaDTO> searchAreasByPageOracle12c(String searchType, String searchKeyword, PaginationDTO pagination) throws SQLException {
		List<AreaDTO> areaList = new ArrayList<AreaDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder searchQuery = new StringBuilder();
			searchQuery
			.append("	SELECT area_num, name, route, tel, operation_time	")
			.append("	FROM area	")
			;
			
			// 검색어가 null이 아닌 경우에만 조건 추가 (PaginationUtil에서 이미 처리됨)
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				switch (searchType) {
					case "name":
						searchQuery.append("	where name LIKE ?	");
						break;
					case "route":
						searchQuery.append("	where route LIKE ?	");
						break;
				} //end switch
			} //end if
			
			searchQuery.append("	ORDER BY route	");
			searchQuery.append("	OFFSET ? ROWS FETCH NEXT ? ROWS ONLY	");
			
			pstmt = con.prepareStatement(searchQuery.toString());
			
			int paramIndex = 1;
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				pstmt.setString(paramIndex++, "%" + searchKeyword + "%");
			} //end if
			pstmt.setInt(paramIndex++, pagination.getOffset());
			pstmt.setInt(paramIndex++, pagination.getPageSize());
			
			rs = pstmt.executeQuery();
			
			AreaDTO areaDTO = null;
			while( rs.next() ) {
				areaDTO = new AreaDTO();
				areaDTO.setArea_num(rs.getInt("area_num"));
				areaDTO.setName(rs.getString("name"));
				areaDTO.setRoute(rs.getString("route"));
				areaDTO.setTel(rs.getString("tel"));
				areaDTO.setOperation_time(rs.getString("operation_time"));
				
				areaList.add(areaDTO);
			} //end while
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return areaList;
	} //searchAreasByPageOracle12c
	
	
	/**
	 * 전체 휴게소 상세정보 조회
	 * @return areaList 조회한 전체 휴게소 상세정보 리스트
	 * @throws SQLException 예외처리
	 */
	public List<AreaDTO> selectAllArea() throws SQLException {
		List<AreaDTO> areaList = new ArrayList<AreaDTO>();

		DBConnection dbCon = DBConnection.getInstance();

		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;

		try {
			// 1. JNDI 사용객체 생성.
			// 2. DBCP에서 연결객체 얻기(DataSource).
			// 3. Connection 얻기.
			con = dbCon.getDbCon();

			// 4. 쿼리문 생성객체 얻기.
			StringBuilder selectAllQuery = new StringBuilder();
			selectAllQuery
			.append("	select	area_num, name, route, tel, operation_time	")
			.append("	from	area	")
			;

			pstmt = con.prepareStatement(selectAllQuery.toString());

			// 5. bind 변수에 값 할당
			// 6. 쿼리문 수행 후 결과 얻기.
			rs = pstmt.executeQuery();

			AreaDTO areaDTO = null;

			while (rs.next()) {
				areaDTO = new AreaDTO();
				areaDTO.setArea_num(rs.getInt("area_num"));
				areaDTO.setName(rs.getString("name"));
				areaDTO.setRoute(rs.getString("route"));
				areaDTO.setTel(rs.getString("tel"));
				areaDTO.setOperation_time(rs.getString("operation_time"));

				areaList.add(areaDTO);
			} // end while

		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} // end try finally
		
		return areaList;
	} //selectAllArea
	
	/**
	 * 단일 휴게소 상세정보 조회
	 * @param num 조회할 휴게소 번호
	 * @return areaDTO 조회한 휴게소 상세정보
	 * @throws SQLException 예외처리
	 */
	public AreaDTO selectOneArea(int num) throws SQLException {
		AreaDTO areaDTO = null;
		
		DBConnection dbCon = DBConnection.getInstance();

		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;

		try {
			// 1. JNDI 사용객체 생성.
			// 2. DBCP에서 연결객체 얻기(DataSource).
			// 3. Connection 얻기.
			con = dbCon.getDbCon();

			// 4. 쿼리문 생성객체 얻기.
			StringBuilder selectOneQuery = new StringBuilder();
			selectOneQuery
			.append("	select	*	")
			.append("	from	area	")
			.append("	where	area_num=?	")
			;

			pstmt = con.prepareStatement(selectOneQuery.toString());

			// 5. bind 변수에 값 할당
			pstmt.setInt(1, num);
			
			// 6. 쿼리문 수행 후 결과 얻기.
			rs = pstmt.executeQuery();

			if (rs.next()) {
				areaDTO = new AreaDTO();
				areaDTO.setArea_num(rs.getInt("area_num"));
				areaDTO.setName(rs.getString("name"));
				areaDTO.setAddr(rs.getString("addr"));
				areaDTO.setTel(rs.getString("tel"));
				areaDTO.setRoute(rs.getString("route"));
				areaDTO.setOperation_time(rs.getString("operation_time"));
				areaDTO.setFeed(rs.getString("FEED"));
				areaDTO.setSleep(rs.getString("sleep"));
				areaDTO.setShower(rs.getString("shower"));
				areaDTO.setLaundry(rs.getString("laundry"));
				areaDTO.setClinic(rs.getString("clinic"));
				areaDTO.setPharmacy(rs.getString("pharmacy"));
				areaDTO.setShelter(rs.getString("shelter"));
				areaDTO.setSalon(rs.getString("salon"));
				areaDTO.setAgricultural(rs.getString("agricultural"));
				areaDTO.setRepair(rs.getString("repair"));
				areaDTO.setTruck(rs.getString("truck"));
				areaDTO.setTemp(rs.getString("temp"));
				areaDTO.setLat(rs.getString("lat"));
				areaDTO.setLng(rs.getString("lng"));
			} // end if
			
			

		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} // end try finally
		
		return areaDTO;
	} //selectOneArea
	
	/**
	 * 휴게소 상세정보 등록
	 * @param areaDTO 등록할 휴게소 상세정보
	 * @throws SQLException 예외처리
	 */
	public void insertArea(AreaDTO areaDTO)  throws SQLException {
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			// 1. JNDI 사용객체 생성.
			// 2. DBCP에서 연결객체 얻기(DataSource).
			// 3. Connection 얻기.
			con = dbCon.getDbCon();
			
			// 4. 쿼리문 생성객체 얻기.
			StringBuilder insertQuery = new StringBuilder();
			insertQuery
			.append("	insert	into	area	")
			.append("	(area_num, name, addr, tel, route, operation_time,	")
			.append("	feed, sleep, shower, laundry, clinic, pharmacy, shelter, salon,	")
			.append("	agricultural, repair, truck, temp, lat, lng)	")
			.append("	values((select MAX(area_num) as area_num from area)+1,	")
			.append("	?,?,?,?,?,	")
			.append("	?,?,?,?,?,?,?,?,	")
			.append("	?,?,?,?,?,?)	")
			;
			
			pstmt = con.prepareStatement(insertQuery.toString());
			
			// 5. bind 변수에 값 할당
			pstmt.setString(1, areaDTO.getName());
			pstmt.setString(2, areaDTO.getAddr());
			pstmt.setString(3, areaDTO.getTel());
			pstmt.setString(4, areaDTO.getRoute());
			pstmt.setString(5, areaDTO.getOperation_time());
			pstmt.setString(6, areaDTO.getFeed());
			pstmt.setString(7, areaDTO.getSleep());
			pstmt.setString(8, areaDTO.getShower());
			pstmt.setString(9, areaDTO.getLaundry());
			pstmt.setString(10, areaDTO.getClinic());
			pstmt.setString(11, areaDTO.getPharmacy());
			pstmt.setString(12, areaDTO.getShelter());
			pstmt.setString(13, areaDTO.getSalon());
			pstmt.setString(14, areaDTO.getAgricultural());
			pstmt.setString(15, areaDTO.getRepair());
			pstmt.setString(16, areaDTO.getTruck());
			pstmt.setString(17, areaDTO.getTemp());
			pstmt.setString(18, areaDTO.getLat());
			pstmt.setString(19, areaDTO.getLng());

			// 6. 쿼리문 수행 후 결과 얻기.
			rs=pstmt.executeQuery();
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
	} //insertArea
	
	/**
	 * 휴게소 상세정보 수정
	 * @param areaDTO 수정할 휴게소 상세정보
	 * @return flagNum 성공시 1, 실패시 0 반환
	 * @throws SQLException 예외처리
	 */
	public int updateArea(AreaDTO areaDTO) throws SQLException {
		int flagNum = 0;
		
		DBConnection dbCon = DBConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			// 1. JNDI 사용객체 생성.
			// 2. DBCP에서 연결객체 얻기(DataSource).
			// 3. Connection 얻기.
			con = dbCon.getDbCon();
			
			// 4. 쿼리문 생성객체 얻기.
			StringBuilder updateQuery = new StringBuilder();
			updateQuery
			.append("	update	area	")
			.append("	set temp=?	")
			.append("	where	area_num=?	")
			;
			
			pstmt = con.prepareStatement(updateQuery.toString());
			
			// 5. bind 변수에 값 할당
			pstmt.setString(1, areaDTO.getTemp());
			pstmt.setInt(2, areaDTO.getArea_num());
			
			// 6. 쿼리문 수행 후 결과 얻기.
			flagNum = pstmt.executeUpdate();
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, null);
		} //end try finally
		
		return flagNum;
	} //updateArea
	
	/**
	 * 휴게소 상세정보 삭제
	 * @param areaList 삭제할 휴게소 번호 리스트
	 * @return flagNum 성공시 1, 실패시 0 반환
	 * @throws SQLException 예외처리
	 */
	public int deleteArea(List<Integer> areaList) throws SQLException {
		int flagNum = 0;

		DBConnection dbCon = DBConnection.getInstance();

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			// 1. JNDI 사용객체 생성.
			// 2. DBCP에서 연결객체 얻기(DataSource).
			// 3. Connection 얻기.
			con = dbCon.getDbCon();

			// 4. 쿼리문 생성객체 얻기.
			StringBuilder deleteQuery = new StringBuilder();
			deleteQuery
			.append("	delete	from area	")
			.append("	where area_num in (	")
			;
			
			int count = 0;
			for(int i=0; i<areaList.size(); i++) {
				if( i == areaList.size()-1 ) {
					deleteQuery
					.append("	?	")
					;
				} else {
					deleteQuery
					.append("	?,	")
					;
				} //end if else
				count ++;
			} //end for
			
			deleteQuery
			.append("	)	")
			;

			pstmt = con.prepareStatement(deleteQuery.toString());

			// 5. bind 변수에 값 할당
			for(int j=0; j<count; j++) {
				pstmt.setInt(j+1, areaList.get(j) );
			} //end for

			// 6. 쿼리문 수행 후 결과 얻기.
			flagNum = pstmt.executeUpdate();

		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, null);
		} // end try finally

		return flagNum;
	} // deleteArea

} //class
