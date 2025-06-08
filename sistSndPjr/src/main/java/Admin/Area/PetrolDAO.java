package Admin.Area;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import Pagination.PaginationDTO;

public class PetrolDAO {

	private static PetrolDAO petDTO;
	
	private PetrolDAO() {
		
	} //PetrolDAO
	
	public static PetrolDAO getInstance() {
		if( petDTO == null ) {
			petDTO = new PetrolDAO();
		} //end if
		
		return petDTO;
	} //getInstance
	
	/**
	 * 전체 주유소 수를 조회합니다.
	 * @return 전체 주유소 수
	 * @throws SQLException 예외처리
	 */
	public int getTotalPetrolCount() throws SQLException {
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
			.append("	from petrol	")
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
	} //getTotalPetrolCount
	
	/**
	 * 페이지네이션을 적용하여 주유소 목록을 조회합니다. (Oracle 11g 이하 - ROWNUM 사용)
	 * @param pagination 페이지네이션 정보
	 * @return 페이지에 해당하는 주유소 목록
	 * @throws SQLException 예외처리
	 */
	public List<PetrolDTO> selectPetrolsByPage(PaginationDTO pagination) throws SQLException {
		List<PetrolDTO> petList = new ArrayList<PetrolDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder selectPageQuery = new StringBuilder();
			selectPageQuery
			.append("	SELECT * FROM (	")
			.append("		SELECT ROWNUM as rnum, pet_num, name, route,	")
			.append("		gasoline, diesel, lpg, elect, hydro,	")
			.append("		operation_time, area_num	")
			.append("		FROM (	")
			.append("			select	p.pet_num, a.name, a.route,	")
			.append("			p.gasoline, p.diesel, p.lpg, p.elect, p.hydro,	")
			.append("			a.operation_time, p.area_num	")
			.append("			FROM petrol p	")
			.append("			LEFT JOIN area a ON a.area_num = p.area_num	")
			.append("			ORDER BY a.route ASC, area_num DESC	")
			.append("		) WHERE ROWNUM <= ?	")
			.append("	) WHERE rnum >= ?	")
			;
			
			pstmt = con.prepareStatement(selectPageQuery.toString());
			pstmt.setInt(1, pagination.getEndRowNum());
			pstmt.setInt(2, pagination.getStartRowNum());
			
			rs = pstmt.executeQuery();
			
			PetrolDTO petDTO = null;
			
			while( rs.next() ) {
				petDTO = new PetrolDTO();
				petDTO.setPetNum(rs.getInt("pet_num"));
				petDTO.setAreaName(rs.getString("name"));
				petDTO.setAreaRoute(rs.getString("route"));
				petDTO.setGasoline(rs.getString("gasoline"));
				petDTO.setDiesel(rs.getString("diesel"));
				petDTO.setLpg(rs.getString("lpg"));
				petDTO.setElect(rs.getString("elect"));
				petDTO.setHydro(rs.getString("hydro"));
				petDTO.setOperationTime(rs.getString("operation_time"));
				petDTO.setAreaNum(rs.getInt("area_num"));
				
				petList.add(petDTO);
			} //end while
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return petList;
	} //selectPetrolsByPage
	
	/**
	 * 검색 조건에 따른 주유소 목록을 페이지네이션으로 조회합니다. (Oracle 11g 이하 - ROWNUM 사용)
	 * @param searchType 검색 유형 (name, email, tel)
	 * @param searchKeyword 검색어
	 * @param pagination 페이지네이션 정보
	 * @return 검색 조건과 페이지에 해당하는 주유소 목록
	 * @throws SQLException 예외처리
	 */
	public List<PetrolDTO> searchPetrolsByPage(String searchType, String searchKeyword, PaginationDTO pagination) throws SQLException {
		List<PetrolDTO> petList = new ArrayList<PetrolDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder searchQuery = new StringBuilder();
			searchQuery
			.append("	SELECT * FROM (	")
			.append("		select ROWNUM as rnum, pet_num, name, route,	")
			.append("		gasoline, diesel, lpg, elect, hydro,	")
			.append("		operation_time, area_num	")
			.append("		from (	")
			.append("			select	p.pet_num, a.name, a.route,	")
			.append("			p.gasoline, p.diesel, p.lpg, p.elect, p.hydro,	")
			.append("			a.operation_time, p.area_num	")
			.append("			from	petrol p	")
			.append("			LEFT JOIN area a ON a.area_num = p.area_num	")
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
			
			searchQuery
			.append("			order by a.route	")
			.append("		) WHERE ROWNUM <= ?	")
			.append("	) WHERE rnum >= ?	");
			
			pstmt = con.prepareStatement(searchQuery.toString());
			
			int paramIndex = 1;
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				pstmt.setString(paramIndex++, "%" + searchKeyword + "%");
			} //end if
			pstmt.setInt(paramIndex++, pagination.getEndRowNum());
			pstmt.setInt(paramIndex, pagination.getStartRowNum());
			
			rs = pstmt.executeQuery();
			
			PetrolDTO petDTO = null;
			while( rs.next() ) {
				petDTO = new PetrolDTO();
				petDTO.setAreaNum(rs.getInt("area_num"));
				petDTO.setAreaName(rs.getString("name"));
				petDTO.setAreaRoute(rs.getString("route"));
				petDTO.setGasoline(rs.getString("gasoline"));
				petDTO.setDiesel(rs.getString("diesel"));
				petDTO.setLpg(rs.getString("lpg"));
				petDTO.setElect(rs.getString("elect"));
				petDTO.setHydro(rs.getString("hydro"));
				petDTO.setAreaNum(rs.getInt("area_num"));
				petDTO.setOperationTime(rs.getString("operation_time"));
				
				petList.add(petDTO);
			} //end while
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return petList;
	} //searchPetrolsByPage
	
	/**
	 * 검색 조건에 따른 주유소 수를 조회합니다.
	 * @param searchType 검색 유형 (route, name)
	 * @param searchKeyword 검색어
	 * @return 검색 조건에 맞는 주유소 수
	 * @throws SQLException 예외처리
	 */
	public int getSearchPetrolCount(String searchType, String searchKeyword) throws SQLException {
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
			.append("	FROM petrol	")
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
	} //getSearchPetrolCount
	
	/**
	 * 검색 조건에 따른 주유소 목록을 페이지네이션으로 조회합니다. (Oracle 12c 이상)
	 * @param searchType 검색 유형 (name, email, tel)
	 * @param searchKeyword 검색어
	 * @param pagination 페이지네이션 정보
	 * @return 검색 조건과 페이지에 해당하는 주유소 목록
	 * @throws SQLException 예외처리
	 */
	public List<PetrolDTO> searchPetrolsByPageOracle12c(String searchType, String searchKeyword, PaginationDTO pagination) throws SQLException {
		List<PetrolDTO> petList = new ArrayList<PetrolDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder searchQuery = new StringBuilder();
			searchQuery
			.append("	select	p.pet_num, a.name, a.route,	")
			.append("	p.gasoline, p.diesel, p.lpg, p.elect, p.hydro,	")
			.append("	a.operation_time, p.area_num	")
			.append("	from	petrol p	")
			.append("	LEFT JOIN area a ON a.area_num = p.area_num	")
			.append("	order by a.route	")
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
			
			PetrolDTO petDTO = null;
			while( rs.next() ) {
				petDTO = new PetrolDTO();
				petDTO.setPetNum(rs.getInt("pet_num"));
				petDTO.setAreaName(rs.getString("name"));
				petDTO.setAreaRoute(rs.getString("route"));
				petDTO.setGasoline(rs.getString("gasoline"));
				petDTO.setDiesel(rs.getString("diesel"));
				petDTO.setLpg(rs.getString("lpg"));
				petDTO.setElect(rs.getString("elect"));
				petDTO.setHydro(rs.getString("hydro"));
				petDTO.setOperationTime(rs.getString("operation_time"));
				petDTO.setAreaNum(rs.getInt("area_num"));
				
				petList.add(petDTO);
			} //end while
			
		} finally {
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
		return petList;
	} //searchPetrolsByPageOracle12c
	
	/**
	 * 전체 주유소 조회
	 * @return petList 전체 주유소 리스트
	 * @throws SQLException 예외처리
	 */
	public List<PetrolDTO> selectAllPetrol() throws SQLException {
		List<PetrolDTO> petList = new ArrayList<PetrolDTO>();
		
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
			.append("	select	p.pet_num, a.name, a.route,	")
			.append("	p.gasoline, p.diesel, p.lpg, p.elect, p.hydro,	")
			.append("	a.operation_time, p.area_num	")
			.append("	from	petrol p	")
			.append("	LEFT JOIN area a ON a.area_num = p.area_num	")
			.append("	order by a.route	")
			;
			
			pstmt = con.prepareStatement(selectAllQuery.toString());

			// 5. bind 변수에 값 할당
			// 6. 쿼리문 수행 후 결과 얻기.
			rs = pstmt.executeQuery();

			PetrolDTO petDTO = null;

			while (rs.next()) {
				petDTO = new PetrolDTO();
				petDTO.setPetNum(rs.getInt("pet_num"));
				petDTO.setAreaName(rs.getString("name"));
				petDTO.setAreaRoute(rs.getString("route"));
				petDTO.setGasoline(rs.getString("gasoline"));
				petDTO.setDiesel(rs.getString("diesel"));
				petDTO.setLpg(rs.getString("lpg"));
				petDTO.setElect(rs.getString("elect"));
				petDTO.setHydro(rs.getString("hydro"));
				petDTO.setOperationTime(rs.getString("operation_time"));

				petList.add(petDTO);
			} // end while

		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} // end try finally
		
		return petList;
	} //selectAllPetrol
	
	/**
	 * 단일 주유소 조회
	 * @param num 조회할 주유소 번호
	 * @return petDTO 단일 주유소 상세정보
	 * @throws SQLException 예외처리
	 */
	public PetrolDTO selectOnePetrol(int num) throws SQLException {
		System.out.println("DAO num : "+num);
		
		PetrolDTO petDTO = null;
		
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
			.append("	select	p.pet_num, a.name, a.route, a.tel,	")
			.append("	p.gasoline, p.diesel, p.lpg, p.elect, p.hydro,	")
			.append("	a.operation_time	")
			.append("	from	petrol p	")
			.append("	LEFT JOIN area a ON a.area_num = p.area_num	")
			.append("	where	p.pet_num=?	")
			;
			System.out.println("Query :"+selectOneQuery);
			
			pstmt = con.prepareStatement(selectOneQuery.toString());

			// 5. bind 변수에 값 할당
			pstmt.setInt(1, num);
			
			// 6. 쿼리문 수행 후 결과 얻기.
			rs = pstmt.executeQuery();

			while (rs.next()) {
				petDTO = new PetrolDTO();
				petDTO.setPetNum(rs.getInt("pet_num"));
				petDTO.setAreaName(rs.getString("name"));;
				petDTO.setAreaRoute(rs.getString("route"));
				petDTO.setAreaTel(rs.getString("tel"));
				petDTO.setGasoline(rs.getString("gasoline"));
				petDTO.setDiesel(rs.getString("diesel"));
				petDTO.setLpg(rs.getString("lpg"));
				petDTO.setElect(rs.getString("elect"));
				petDTO.setHydro(rs.getString("hydro"));
				petDTO.setOperationTime(rs.getString("operation_time"));
			} // end while
			System.out.println("DAO dto : "+petDTO);
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} // end try finally
		
		return petDTO;
	} //selectOnePetrol
	
	/**
	 * 주유소 등록
	 * @param petDTO 등록할 주유소 상세정보
	 * @throws SQLException 예외처리
	 */
	public void insertPetrol(PetrolDTO petDTO)  throws SQLException {
		
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
			pstmt.setString(1, petDTO.getAreaName());
			pstmt.setString(2, petDTO.getAreaRoute());
			pstmt.setString(3, petDTO.getAreaTel());
			pstmt.setString(4, petDTO.getOperationTime());
			pstmt.setString(5, petDTO.getAreaAddr());
			pstmt.setString(6, petDTO.getAreaLat());
			pstmt.setString(7, petDTO.getAreaLng());
			pstmt.setString(8, petDTO.getGasoline());
			pstmt.setString(9, petDTO.getDiesel());
			pstmt.setString(10, petDTO.getLpg());
			pstmt.setString(11, petDTO.getElect());
			pstmt.setString(12, petDTO.getHydro());
			
			// 6. 쿼리문 수행 후 결과 얻기.
			rs=pstmt.executeQuery();
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} //end try finally
		
	} //insertPetrol
	
	public int updatePetrol(PetrolDTO petDTO) throws SQLException {
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
			.append("	update	petrol	")
			.append("	set gasoline=?, diesel=?, lpg=?, elect=?, hydro=?	")
			.append("	where	pet_num=?	")
			;

			pstmt = con.prepareStatement(updateQuery.toString());
			
			// 5. bind 변수에 값 할당
			pstmt.setString(1, petDTO.getGasoline());
			pstmt.setString(2, petDTO.getDiesel());
			pstmt.setString(3, petDTO.getLpg());
			pstmt.setString(4, petDTO.getElect());
			pstmt.setString(5, petDTO.getHydro());
			pstmt.setInt(6, petDTO.getPetNum());
			
			// 6. 쿼리문 수행 후 결과 얻기.
			flagNum = pstmt.executeUpdate();
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, null);
		} //end try finally
		
		return flagNum;
	} //updatePetrol
	
	/**
	 * 주유소 삭제
	 * @param petNumList 삭제할 주유소 번호 리스트
	 * @return flagNum 성공시 1, 실패시 0 반환
	 * @throws SQLException 예외처리
	 */
	public int deletePetrol(List<Integer> petNumList) throws SQLException {
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
			.append("	delete	from petrol	")
			.append("	where pet_num in (	")
			;
			
			int count = 0;
			for(int i=0; i<petNumList.size(); i++) {
				if( i == petNumList.size()-1 ) {
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
				pstmt.setInt(j+1, petNumList.get(j) );
			} //end for

			// 6. 쿼리문 수행 후 결과 얻기.
			flagNum = pstmt.executeUpdate();

		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, null);
		} // end try finally

		return flagNum;
	} // deletePetrol
	
} //class
