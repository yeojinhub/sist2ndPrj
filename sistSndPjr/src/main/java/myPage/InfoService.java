package myPage;

import java.sql.SQLException;

import kr.co.sist.cipher.DataEncryption;

public class InfoService {
	// 회원 탈퇴 메서드
	public void deleteUser(String email) {
		InfoDAO userDAO = new InfoDAO();
        try {
            userDAO.deleteUser(email);
        } catch (SQLException e) {
        	e.printStackTrace();
        }
    }//deleteUser
	
	public void changePassword(String email, String newRawPassword) {
        try {
        	String pass = DataEncryption.messageDigest("SHA-256", newRawPassword); // 암호화
            InfoDAO iDAO = new InfoDAO();
            iDAO.updatePass(email, pass);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    }
	
	public void changeAccount(String name, String tel, String email) {
		InfoDAO iDAO = new InfoDAO();
		try {
			iDAO.updateAccount(name, tel, email);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		};
	}
}
