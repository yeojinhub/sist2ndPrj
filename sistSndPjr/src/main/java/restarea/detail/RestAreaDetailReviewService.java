package restarea.detail;

import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import DTO.AreaDetailReviewDTO;

public class RestAreaDetailReviewService {

	public List<AreaDetailReviewDTO> searchAllReview(int area_num) {
		List<AreaDetailReviewDTO> list = null;
		
		RestAreaDetailReviewDAO radrDAO = new RestAreaDetailReviewDAO();
		
		try {
			list = radrDAO.seleteAllReview(area_num);
		} catch (SQLException e) {
			e.printStackTrace();
		}// end try-catch
		
		return list;
	}// searchAllReview
	
}// class
