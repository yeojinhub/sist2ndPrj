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
	
	/********************************* pagination ************************************/
	
	/**
	 * 총 게시물(데이터)의 카운트 구하기.
	 * @param id 휴게소넘버
	 * @return
	 */
	public int searchTotalCount(int id) {
		int cnt = 0;
		
		RestAreaDetailReviewDAO radrDAO = new RestAreaDetailReviewDAO();

		try {
			cnt = radrDAO.selectTotalCount(id);
		} catch (SQLException e) {
			e.printStackTrace();
		}// end try-catch
		
		return cnt;
	}// searchTotalCount
	
	/**
	 * 페이지에 보여질 게시물의 수
	 * @param scale
	 * @return
	 */
	public int pageScale(int scale) {
		int pageScale = 0;
		
		pageScale = scale;
		
		return pageScale;
	}// pageScale
	
	/********************************* pagination ************************************/
	
}// class
