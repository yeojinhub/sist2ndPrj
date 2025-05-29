package Account;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import DTO.AccountDTO;
import kr.co.sist.cipher.DataDecryption;
import kr.co.sist.cipher.DataEncryption;

public class RegisterService {
	
	/**
	 * 회원가입 시 이메일(ID) 중복 확인
	 * : DB에 저장된 암호화 이메일(ID)를 비교하기 위해 매개변수로 암호화된 이메일(ID)를 받는다.
	 * @param id 암호화된 이메일(ID)
	 * @return
	 */
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

	/**
	 * 회원가입 insert문
	 * @param aDTO 회원가입 페이지에서 받아온 정보 (이름, 이메일 등)
	 * @return
	 */
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
		
		String user_email = aDTO.getEmail()+"@"+aDTO.getDomain();
		
		try {
			aDTO.setName(deInfo.encrypt(aDTO.getName()));
			aDTO.setUser_email(deInfo.encrypt(user_email));
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
