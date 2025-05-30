package Account;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import kr.co.sist.cipher.DataEncryption;

public class RegisterService {
	
	public boolean searchIdCheck(String id) {
		boolean flag = false;
		
		RegisterDAO rDAO = new RegisterDAO();
		
		String myKey = "asdf1234asdf1234";
		DataEncryption de = new DataEncryption(myKey);
		
		try {
			id = de.encrypt(id);
		} catch (Exception e) {
			e.printStackTrace();
		}// end try-catch
		
		try {
			flag = rDAO.selectIdCheck(id);
		} catch (SQLException e) {
			e.printStackTrace();
		}// end try-catch
		
		return flag;
	}// searchIdCheck

	public boolean addAccount(AccountDTO aDTO) {
		boolean flag = false;
		
		RegisterDAO rDAO = new RegisterDAO();
		
		// 일방향 암호화 [SHA-256]
		try {
			aDTO.setPass(DataEncryption.messageDigest("SHA-256", aDTO.getPass()));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}// end try-catch
		
		// 양방향 암호화 [이름, 이메일, 전화번호]
		String myKey = "asdf1234asdf1234";
		DataEncryption deInfo = new DataEncryption(myKey);
		
		try {
			aDTO.setName(deInfo.encrypt(aDTO.getName()));
			aDTO.setUser_email(deInfo.encrypt(aDTO.getUser_email()));
			aDTO.setTel(deInfo.encrypt(aDTO.getTel()));
		} catch (Exception e) {
			e.printStackTrace();
		}// end try-catch
		
		// 암호화 완료 후 쿼리문 진행 (DAO)
		try {
			rDAO.insertAccount(aDTO);
			flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}// end try-catch
		
		return flag;
	}// addAccount
	
}// class
