package Account;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import DTO.LoginDTO;
import kr.co.sist.cipher.DataEncryption;

public class LoginService {

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
	
}// class
