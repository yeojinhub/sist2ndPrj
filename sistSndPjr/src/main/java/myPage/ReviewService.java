package myPage;

import java.sql.SQLException;
import java.util.List;

import DTO.ReviewDTO;

public class ReviewService {
	public List<ReviewDTO> searchReviewsByEmail(String email){
        List<ReviewDTO> list = null;
		ReviewDAO rdao = new ReviewDAO();
        try {
			list = rdao.selectReviewByEmail(email);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        return list;
    }
}
