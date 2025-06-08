package AdminLogin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DBConnection.DBConnection;

public class LoginDAO {

	private static LoginDAO lDAO;

	private LoginDAO() {

	}

	public static LoginDAO getInstance() {
		if (lDAO == null) {
			lDAO = new LoginDAO();
		}
		return lDAO;
	}

	public LoginResultDTO selectLogin(LoginDTO lDTO) throws SQLException {
		LoginResultDTO lrDTO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		DBConnection db = DBConnection.getInstance();

		try {
			// 1.JNDI 사용 객체 생성
			// 2. dBCP에서 연결객체 얻기 (DataSource)
			// 3. connection 얻기
			con = db.getDbCon();
			// 4. 쿼리문 생성객체 얻기
			StringBuilder selectLoginInfo = new StringBuilder();
			selectLoginInfo.append("	SELECT ADM_ID,NAME, ROLLTYPE	").append("	FROM ACCOUNT	")
					.append("	WHERE ADM_ID = ? AND PASS = ?	");

			pstmt = con.prepareStatement(selectLoginInfo.toString());
			// 5. 바인드변수에 값 할당
			pstmt.setString(1, lDTO.getAdm_id());
			pstmt.setString(2, lDTO.getPass());
			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();

			if (rs.next()) {
				lrDTO = new LoginResultDTO();
				lrDTO.setAdm_id(rs.getString("adm_id"));
				
				lrDTO.setName(rs.getString("name"));
				lrDTO.setRollType(rs.getInt("ROLLTYPE"));
			}
			// 검색결과 있으면 DTO 객체에 값을 생성
		} finally {
			// 7. 연결 끊기
			db.dbClose(con, pstmt, rs);
		}

		return lrDTO;
	}// selectId
}