package user.account.login;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import kr.co.sist.cipher.DataEncryption;

public class LoginService {

	/**
	 * 사용자로부터 이메일과 비밀번호를 입력받아 일치하는 데이터 조회. (암호화 진행 포함)
	 * @param email 입력받은 이메일
	 * @param pass 입력받은 비밀번호
	 * @return 데이터 유무, 아이디와 비밀번호가 일치하지 않는다면 lDTO는 null 이다.
	 */
	public LoginDTO searchLogin(String email, String pass) {
		LoginDTO lDTO = new LoginDTO();
		
		LoginDAO lDAO = new LoginDAO();

		// 이메일 암호화
		String myKey = "asdf1234asdf1234";
		DataEncryption de = new DataEncryption(myKey);
		try {
			email = (de.encrypt(email));
		} catch (Exception e) {
			e.printStackTrace();
		}// end try-catch

		// 비밀번호 암호화
		try {
			pass = (DataEncryption.messageDigest("SHA-256", pass));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}// end try-catch

		try {
			lDTO = lDAO.selectLogin(email, pass);
		} catch (SQLException e) {
			e.printStackTrace();
		}// end try-catch
		
		return lDTO;
	}// searchLogin
	
	public boolean searchCheckWithdraw(String email) {
		boolean chkWithdraw = false;
		
		LoginDAO lDAO = new LoginDAO();
		
		String myKey = "asdf1234asdf1234";
		DataEncryption de = new DataEncryption(myKey);
		
		try {
			email = de.encrypt(email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			chkWithdraw = lDAO.selectCheckWithdraw(email);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return chkWithdraw;
	}
	
}// class