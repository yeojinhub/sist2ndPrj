package user.restarea.detail;

import java.sql.SQLException;

public class RestAreaDetailService {
	
	/**
	 * ID 파라미터로 디테일 조회
	 * @param num ID파라미터
	 * @return
	 */
	public AreaDetailDTO searchRestAreaDetail(int num) {
		AreaDetailDTO adDTO = null;
		
		RestAreaDetailDAO radDAO = new RestAreaDetailDAO();
		
		try {
			adDTO = radDAO.selectRestAreaDetail(num);
			
			if (adDTO.getName().contains("(")) {
				String name = adDTO.getName();
				
				adDTO.setDirection(name.substring(name.indexOf("("),name.lastIndexOf(")"))+")");
				adDTO.setName(name.substring(0,name.lastIndexOf("("))+"휴게소");
			} else {
				adDTO.setName(adDTO.getName()+"휴게소");
			}// end else-if
			
			if (adDTO.getTemp() == null) {
				adDTO.setTemp("없음");
			}// end if
			
		} catch (SQLException e) {
			e.printStackTrace();
		}// end try-catch
		
		return adDTO;
	}// searchRestAreaDetail
	
	public boolean searchFavorite(String email, int area_num) {
		boolean flag = false;
		
		RestAreaDetailDAO radDAO = new RestAreaDetailDAO();
		
		try {
			flag = radDAO.selectFavorite(email, area_num);
		} catch (SQLException e) {
			e.printStackTrace();
		}// end try-catch
		
		return flag;
	}// searchFavorite
	
	public boolean addFavorite(String restareaName, int acc_num, int area_num) {
		boolean flag = false;
		
		RestAreaDetailDAO radDAO = new RestAreaDetailDAO();
		
		try {
			flag = radDAO.insertFavorite(restareaName, acc_num, area_num);
		} catch (SQLException e) {
			e.printStackTrace();
		}// end try-catch
		
		return flag;
	}// addFavorite
	
	public boolean removeFavorite(int acc_num, int area_num) {
		boolean flag = false;
		
		RestAreaDetailDAO radDAO = new RestAreaDetailDAO();
		
		try {
			flag = radDAO.deleteFavorite(acc_num, area_num);
		} catch (SQLException e) {
			e.printStackTrace();
		}// end try-catch
		
		return flag;
	}// addFavorite
	
}// class