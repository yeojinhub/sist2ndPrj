package Admin.Area;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import Pagination.PaginationDTO;

public class FoodDAO {

	private static FoodDAO fDAO;
	
	private FoodDAO() {
		
	} //FoodDAO
	
	public static FoodDAO getInstance() {
		if( fDAO == null ) {
			fDAO = new FoodDAO();
		} //end if
		
		return fDAO;
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
	public List<FoodDTO> selectAreasByPage(PaginationDTO pagination) throws SQLException {
		List<FoodDTO> areaList = new ArrayList<FoodDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder selectPageQuery = new StringBuilder();
			selectPageQuery
			.append("	SELECT * FROM (	")
			.append("		SELECT ROWNUM as rnum, area_num, name, route, total_food, operation_time	")
			.append("		FROM (	")
			.append("			SELECT a.area_num, a.name, a.route,	")
			.append("				COUNT(f.food_num) as total_food,	")
			.append("				a.operation_time	")
			.append("			FROM area a	")
			.append("			LEFT JOIN food f ON f.area_num = a.area_num	")
			.append("			group by a.area_num, a.name, a.route, a.operation_time	")
			.append("			ORDER BY a.route ASC, a.area_num DESC	")
			.append("		) WHERE ROWNUM <= ?	")
			.append("	) WHERE rnum >= ?	")
			;
			
			pstmt = con.prepareStatement(selectPageQuery.toString());
			pstmt.setInt(1, pagination.getEndRowNum());
			pstmt.setInt(2, pagination.getStartRowNum());
			
			rs = pstmt.executeQuery();
			
			FoodDTO areaDTO = null;
			
			while( rs.next() ) {
				areaDTO = new FoodDTO();
				areaDTO.setAreaNum(rs.getInt("area_num"));
				areaDTO.setAreaName(rs.getString("name"));
				areaDTO.setAreaRoute(rs.getString("route"));
				areaDTO.setTotalFood(rs.getInt("total_food"));
				areaDTO.setOperationTime(rs.getString("operation_time"));
				
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
	public List<FoodDTO> searchAreasByPage(String searchType, String searchKeyword, PaginationDTO pagination) throws SQLException {
	    List<FoodDTO> areaList = new ArrayList<FoodDTO>();
	    
	    DBConnection dbCon = DBConnection.getInstance();
	    
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    Connection con = null;
	    
	    try {
	        con = dbCon.getDbCon();
	        
	        StringBuilder searchQuery = new StringBuilder();
	        searchQuery
	            .append("SELECT * FROM (")
	            .append("    SELECT ROWNUM as rnum, area_num, name, route, total_food, operation_time")
	            .append("    FROM (")
	            .append("        SELECT a.area_num, a.name, a.route,")
	            .append("            COUNT(f.food_num) as total_food,")
	            .append("            a.operation_time")
	            .append("        FROM area a")
	            .append("        LEFT JOIN food f ON f.area_num = a.area_num");
	        
	        // 검색어가 null이 아닌 경우에만 조건 추가
	        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
	            switch (searchType) {
	                case "name":
	                    searchQuery.append(" WHERE a.name LIKE ?");
	                    break;
	                case "route":
	                    searchQuery.append(" WHERE a.route LIKE ?");
	                    break;
	            }
	        }
	        
	        searchQuery
	            .append("        GROUP BY a.area_num, a.name, a.route, a.operation_time")
	            .append("        ORDER BY a.route ASC, a.area_num DESC")
	            .append("    ) WHERE ROWNUM <= ?")
	            .append(") WHERE rnum >= ?");
	        
	        pstmt = con.prepareStatement(searchQuery.toString());
	        
	        int paramIndex = 1;
	        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
	            pstmt.setString(paramIndex++, "%" + searchKeyword + "%");
	        }
	        pstmt.setInt(paramIndex++, pagination.getEndRowNum());
	        pstmt.setInt(paramIndex, pagination.getStartRowNum());
	        
	        rs = pstmt.executeQuery();
	        
	        FoodDTO areaDTO = null;
	        while(rs.next()) {
	            areaDTO = new FoodDTO();
	            areaDTO.setAreaNum(rs.getInt("area_num"));
	            areaDTO.setAreaName(rs.getString("name"));
	            areaDTO.setAreaRoute(rs.getString("route"));
	            areaDTO.setTotalFood(rs.getInt("total_food"));
	            areaDTO.setOperationTime(rs.getString("operation_time"));
	            
	            areaList.add(areaDTO);
	        }
	    } finally {
	        dbCon.dbClose(con, pstmt, rs);
	    }
	    
	    return areaList;
	}
	
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
	public List<FoodDTO> searchAreasByPageOracle12c(String searchType, String searchKeyword, PaginationDTO pagination) throws SQLException {
		List<FoodDTO> areaList = new ArrayList<FoodDTO>();
		
		DBConnection dbCon = DBConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			con = dbCon.getDbCon();
			
			StringBuilder searchQuery = new StringBuilder();
			searchQuery
			.append("	select	a.area_num, a.name, a.route,	")
			.append("	COUNT(f.food_num) as total_food,	")
			.append("	a.operation_time	")
			.append("	from	area a	")
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
			.append("	LEFT JOIN food f ON f.area_num = a.area_num	")
			.append("	group by a.area_num, a.name, a.route, a.operation_time	")
			.append("	order by a.route	")
			.append("	OFFSET ? ROWS FETCH NEXT ? ROWS ONLY	");
			
			pstmt = con.prepareStatement(searchQuery.toString());
			
			int paramIndex = 1;
			if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
				pstmt.setString(paramIndex++, "%" + searchKeyword + "%");
			} //end if
			pstmt.setInt(paramIndex++, pagination.getOffset());
			pstmt.setInt(paramIndex++, pagination.getPageSize());
			
			rs = pstmt.executeQuery();
			
			FoodDTO areaDTO = null;
			while( rs.next() ) {
				areaDTO = new FoodDTO();
				areaDTO.setAreaNum(rs.getInt("area_num"));
				areaDTO.setAreaName(rs.getString("name"));
				areaDTO.setAreaRoute(rs.getString("route"));
				areaDTO.setTotalFood(rs.getInt("total_food"));
				areaDTO.setOperationTime(rs.getString("operation_time"));
				
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
	public List<FoodDTO> selectAllArea() throws SQLException {
		List<FoodDTO> areaList = new ArrayList<FoodDTO>();

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
			.append("	select	a.area_num, a.name, a.route,	")
			.append("	COUNT(f.food_num) as total_food,	")
			.append("	a.operation_time	")
			.append("	from	area a	")
			.append("	LEFT JOIN food f ON f.area_num = a.area_num	")
			.append("	group by a.area_num, a.name, a.route, a.operation_time	")
			.append("	order by a.route	")
			;

			pstmt = con.prepareStatement(selectAllQuery.toString());

			// 5. bind 변수에 값 할당
			// 6. 쿼리문 수행 후 결과 얻기.
			rs = pstmt.executeQuery();

			FoodDTO aDTO = null;

			while (rs.next()) {
				aDTO = new FoodDTO();
				aDTO.setAreaNum(rs.getInt("area_num"));
				aDTO.setAreaName(rs.getString("name"));
				aDTO.setAreaRoute(rs.getString("route"));
				aDTO.setTotalFood(rs.getInt("total_food"));
				aDTO.setOperationTime(rs.getString("operation_time"));

				areaList.add(aDTO);
			} // end while

		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} // end try finally

		return areaList;
	} //selectAllArea
	
	/**
	 * 전체 먹거리 조회
	 * @param num 조회할 휴게소 번호
	 * @return areaList 조회한 전체 먹거리 리스트
	 * @throws SQLException 예외처리
	 */
	public List<FoodDTO> selectAllFood(int num) throws SQLException {
		List<FoodDTO> foodList = new ArrayList<FoodDTO>();

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
			.append("	SELECT f.food_num, f.name AS food_name, f.price, f.image, f.area_num,	")
			.append("	a.name AS area_name	")
			.append("	from	food f	")
			.append("	LEFT JOIN area a on a.area_num = f.area_num	")
			.append("	where f.area_num = ?	")
			.append("	order by f.name	")
			;

			pstmt = con.prepareStatement(selectAllQuery.toString());

			// 5. bind 변수에 값 할당
			pstmt.setInt(1, num);
			
			// 6. 쿼리문 수행 후 결과 얻기.
			rs = pstmt.executeQuery();

			FoodDTO fDTO = null;

			while (rs.next()) {
				fDTO = new FoodDTO();
				fDTO.setFoodNum(rs.getInt("food_num"));
				fDTO.setFoodName(rs.getString("food_name"));
				fDTO.setFoodPrice(rs.getString("price"));
				fDTO.setFoodImage(rs.getBlob("image"));
				fDTO.setAreaNum(rs.getInt("area_num"));
				fDTO.setAreaName(rs.getString("area_name"));

				foodList.add(fDTO);
			} // end while

		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, rs);
		} // end try finally

		return foodList;
	} //selectAllFood
	
	/**
	 * 음식 삭제
	 * @param foodNumList 삭제할 음식 번호 리스트
	 * @return flagNum 성공시 1, 실패시 0 반환
	 * @throws SQLException 예외처리
	 */
	public int deleteFood(List<Integer> foodNumList) throws SQLException {
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
			.append("	delete	from food	")
			.append("	where food_num in (	")
			;
			
			int count = 0;
			for(int i=0; i<foodNumList.size(); i++) {
				if( i == foodNumList.size()-1 ) {
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
				pstmt.setInt(j+1, foodNumList.get(j) );
			} //end for

			// 6. 쿼리문 수행 후 결과 얻기.
			flagNum = pstmt.executeUpdate();

		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(con, pstmt, null);
		} // end try finally

		return flagNum;
	} // deleteFood

} //class
