package myPage;

import java.sql.SQLException;

import kr.co.sist.cipher.DataEncryption;

public class InfoService {
	// 회원 탈퇴 메서드
	public void deleteUser(String email) {
        try {
            InfoDAO userDAO = new InfoDAO();
            userDAO.deleteUser(email);
        } catch (SQLException e) {
            throw new RuntimeException("회원 탈퇴 중 오류 발생", e);
        }
    }//deleteUser
	
	public void changePassword(String email, String newRawPassword) {
        try {
            String pass = DataEncryption.messageDigest("SHA-256", newRawPassword); // 암호화
            InfoDAO iDAO = new InfoDAO();
            iDAO.updatePass(email, pass);
        } catch (Exception e) {
            throw new RuntimeException("비밀번호 변경 중 오류 발생", e);
        }
    }
}
