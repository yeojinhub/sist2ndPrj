package user.restarea.detail.food;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RestAreaDetailFoodService {

	public List<AreaDetailFoodDTO> searchAllFood(int area_num) {
		List<AreaDetailFoodDTO> list = new ArrayList<AreaDetailFoodDTO>();
		
		RestAreaDetailFoodDAO radfDAO = new RestAreaDetailFoodDAO();
		
		try {
			list = radfDAO.selectAllFood(area_num);
		} catch (SQLException e) {
			e.printStackTrace();
		}// end try-catch
		
		return list;
	}// searchAllFood
	
}// class
