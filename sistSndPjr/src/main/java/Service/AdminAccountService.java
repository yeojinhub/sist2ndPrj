package Service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DAO.AdminAccountDAO;
import DTO.AccountDTO;

public class AdminAccountService {
	
	public List<AccountDTO> selectAllUser() {
		List<AccountDTO> userList = new ArrayList<AccountDTO>();
		AdminAccountDAO accountDAO = AdminAccountDAO.getInstance();
		
		try {
			accountDAO.selectAllUser();
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return userList;
	} //selectAllUser

} //class
