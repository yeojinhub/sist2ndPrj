package user.gasstation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import user.DBConnection.DBConnection;
import user.account.login.LoginDTO;
import user.util.RangeDTO;

public class PetrolDAO {

	/**
	 * 주유소 페이지에 <select> 태그 <option>으로 사용할 노선 구하기 (중복 제거)
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<String> selectAllRoute(RangeDTO rDTO) throws SQLException {
		List<String> list = new ArrayList<String>();

		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = null;

		DBConnection dbCon = DBConnection.getInstance();

		try {
			conn = dbCon.getDbCon();

			// SQL문 작성
			String selectQuery = "SELECT DISTINCT ROUTE FROM AREA";
			pstmt = conn.prepareStatement(selectQuery);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				list.add(rs.getString("ROUTE"));
			} // end while

		} finally {
			dbCon.dbClose(conn, pstmt, rs);
		} // end try-finally

		return list;
	}// selectAllRoute

	/**
	 * 모든 주유소 정보를 얻어오는 메소드
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<PetrolDTO> selectAllPetrol(RangeDTO rDTO) throws SQLException {
	    List<PetrolDTO> list = new ArrayList<>();
	    List<String> conditions = new ArrayList<>();
	    List<Object> params = new ArrayList<>();

	    DBConnection dbCon = DBConnection.getInstance();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        conn = dbCon.getDbCon();
	        
	        StringBuilder selectQuery = new StringBuilder();
	        selectQuery.append("SELECT * FROM (")
	                   .append("  SELECT ROW_NUMBER() OVER (ORDER BY A.AREA_NUM) RNUM, ")
	                   .append("         A.AREA_NUM, NAME, A.TEL, ROUTE, ")
	                   .append("         GASOLINE, DIESEL, LPG, ELECT, HYDRO ")
	                   .append("  FROM AREA A ")
	                   .append("  INNER JOIN PETROL P ON A.AREA_NUM = P.AREA_NUM ");

	        //--- 조건 처리 시작 ---//
	        String route = rDTO.getRoute();
	        String keyword = rDTO.getKeyword();
	        String elect = rDTO.getElect();
	        String hydro = rDTO.getHydro();

	        // [변경점 1] "select" 값 필터링
	        if (route != null && !route.isEmpty() && !"select".equals(route)) {
	            conditions.add("INSTR(ROUTE, ?) != 0");
	            params.add(route);
	        }
	        if (keyword != null && !keyword.isEmpty()) {
	            conditions.add("INSTR(NAME, ?) != 0");
	            params.add(keyword);
	        }
	        if ("O".equals(elect)) {
	            conditions.add("ELECT = 'O'");
	        }
	        if ("O".equals(hydro)) {
	            conditions.add("HYDRO = 'O'");
	        }

	        //--- WHERE 조건 조립 ---//
	        if (!conditions.isEmpty()) {
	            selectQuery.append(" WHERE ");
	            selectQuery.append(String.join(" AND ", conditions));
	        }
	        //--- 조건 처리 끝 ---//

	        selectQuery.append(") WHERE RNUM BETWEEN ? AND ? ");

	        pstmt = conn.prepareStatement(selectQuery.toString());
	        
	        // [변경점 2] 파라미터 바인딩 자동화
	        int paramIndex = 1;
	        for (Object param : params) {
	            pstmt.setString(paramIndex++, param.toString());
	        }
	        pstmt.setInt(paramIndex++, rDTO.getStartNum());
	        pstmt.setInt(paramIndex++, rDTO.getEndNum());

	        rs = pstmt.executeQuery();
	        
	        while (rs.next()) {
	            PetrolDTO pDTO = new PetrolDTO();
	            pDTO.setArea_num(rs.getInt("AREA_NUM"));
	            pDTO.setName(rs.getString("NAME"));
	            pDTO.setTel(rs.getString("TEL"));
	            pDTO.setRoute(rs.getString("ROUTE"));
	            pDTO.setGasoline(rs.getString("GASOLINE"));
	            pDTO.setDiesel(rs.getString("DIESEL"));
	            pDTO.setLpg(rs.getString("LPG"));
	            pDTO.setElect(rs.getString("ELECT"));
	            pDTO.setHydro(rs.getString("HYDRO"));
	            list.add(pDTO);
	        }
	    } finally {
	        dbCon.dbClose(conn, pstmt, rs);
	    }
	    return list;
	}


	/****************** pagination ***********************/

	/**
	 * 1. 총 레코드(데이터)의 수를 구합니다.
	 * 
	 * @return
	 * @throws SQLException
	 */
	public int selectTotalCount(RangeDTO rDTO) throws SQLException {
	    int cnt = 0;
	    List<String> conditions = new ArrayList<>();
	    List<Object> params = new ArrayList<>();

	    DBConnection dbCon = DBConnection.getInstance();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        conn = dbCon.getDbCon();
	        
	        StringBuilder selectQuery = new StringBuilder();
	        selectQuery.append("SELECT COUNT(*) CNT ")
	                   .append("FROM AREA A ")
	                   .append("INNER JOIN PETROL P ON A.AREA_NUM = P.AREA_NUM ");

	        //--- 조건 처리 시작 ---//
	        String route = rDTO.getRoute();
	        String keyword = rDTO.getKeyword();
	        String elect = rDTO.getElect();
	        String hydro = rDTO.getHydro();

	        // [개선점 1] "select" 값 필터링 추가
	        if (route != null && !route.isEmpty() && !"select".equals(route)) {
	            conditions.add("INSTR(ROUTE, ?) != 0");
	            params.add(route);
	        }
	        if (keyword != null && !keyword.isEmpty()) {
	            conditions.add("INSTR(NAME, ?) != 0");
	            params.add(keyword);
	        }
	        if ("O".equals(elect)) {
	            conditions.add("ELECT = 'O'");
	        }
	        if ("O".equals(hydro)) {
	            conditions.add("HYDRO = 'O'");
	        }

	        //--- WHERE 조건 조립 ---//
	        if (!conditions.isEmpty()) {
	            selectQuery.append(" WHERE ");
	            selectQuery.append(String.join(" AND ", conditions));
	        }
	        //--- 조건 처리 끝 ---//

	        pstmt = conn.prepareStatement(selectQuery.toString());
	        
	        // [개선점 2] 바인드 변수 자동 처리
	        for (int i = 0; i < params.size(); i++) {
	            pstmt.setString(i + 1, params.get(i).toString());
	        }

	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            cnt = rs.getInt("CNT");
	        }
	    } finally {
	        dbCon.dbClose(conn, pstmt, rs);
	    }
	    return cnt;
	}

	/****************** pagination ***********************/

}// class
