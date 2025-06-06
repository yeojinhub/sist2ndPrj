package user.account.forgot;

import java.sql.SQLException;

import kr.co.sist.cipher.DataDecryption;
import kr.co.sist.cipher.DataEncryption;

public class ForgotService {

	public boolean searchEmailCheck(String email) {
		boolean flag = false;
		
		ForgotDAO fDAO = new ForgotDAO();
		
		// DB(암호화된 이메일)에 접근해 일치 여부를 확인하기 위해 암호화처리
		String myKey = "asdf1234asdf1234";
		DataEncryption de = new DataEncryption(myKey);
		
		try {
			email = de.encrypt(email);
		} catch (Exception e) {
			System.err.println("암호화 실패 사유 : " + e.getMessage());
		}// end try
		
		try {
			flag = fDAO.selectEmailCheck(email);
		} catch (SQLException e) {
			e.printStackTrace();
		}// end try
		
		return flag;
	}// searchEmailCheck
	
}// class
