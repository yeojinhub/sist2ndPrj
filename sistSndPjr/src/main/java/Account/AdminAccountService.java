package Account;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminAccountService {
	
	/**
	 * 전체 사용자 계정 조회
	 * @return userList 조회한 전체 사용자 계정 리스트
	 */
	public List<AccountDTO> selectAllUser() {
		List<AccountDTO> userList = new ArrayList<AccountDTO>();
		AdminAccountDAO accountDAO = AdminAccountDAO.getInstance();
		
		try {
			userList = accountDAO.selectAllUser();
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return userList;
	} //selectAllUser
	
	/**
	 * 단일 사용자 계정 조회
	 * @param acc_num 조회할 사용자 계정 번호
	 * @return userDTO 조회한 사용자 계정 정보
	 */
	public AccountDTO searchOneUser(int acc_num) {
		AccountDTO userDTO=null;
		
		AdminAccountDAO userDAO=AdminAccountDAO.getInstance();
		
		try {
			userDTO = userDAO.selectOneUser(acc_num);
		} catch (SQLException e) {
			e.printStackTrace();
		}  //end try catch
		
		return userDTO;
		
	} //searchOneUser
	
	/**
	 * 사용자 계정 등록
	 * @param userDTO 등록할 사용자 계정 정보
	 * @return flag 성공시 true, 실패시 false 반환
	 */
	public boolean addUser(AccountDTO userDTO) {
		boolean flag = false;
		
		AdminAccountDAO userDAO = AdminAccountDAO.getInstance();
		
		try {
			userDAO.insertUser(userDTO);
			flag = true;
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return flag;
	} //addUser
	
	/**
	 * 전체 관리자 계정 조회
	 * @return adminList 조회한 전체 관리자 계정 리스트
	 */
	public List<AccountDTO> selectAllAdmin() {
		List<AccountDTO> adminList = new ArrayList<AccountDTO>();
		AdminAccountDAO accountDAO = AdminAccountDAO.getInstance();
		
		try {
			adminList = accountDAO.selectAllAdmin();
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return adminList;
	} //selectAllAdmin

} //class
