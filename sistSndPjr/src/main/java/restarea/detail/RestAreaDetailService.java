package restarea.detail;

import java.sql.SQLException;

import DTO.AreaDetailDTO;

public class RestAreaDetailService {
	
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
			
		} catch (SQLException e) {
			e.printStackTrace();
		}// end try-catch
		
		return adDTO;
	}// searchRestAreaDetail
	
}// class
