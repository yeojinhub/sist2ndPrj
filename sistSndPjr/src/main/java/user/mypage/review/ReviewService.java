package user.mypage.review;

import java.sql.SQLException;
import java.util.List;

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
	
	public ReviewDTO searchReviewByNum(int revNum) {
		ReviewDTO rDTO = null;
		ReviewDAO rDAO = new ReviewDAO();
		try {
			rDTO = rDAO.selectReviewByNum(revNum);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rDTO;
	}
	
	public void removeReview(int revNum) {
		ReviewDAO rDAO = new ReviewDAO();
		
		try {
			rDAO.deleteReviewByNum(revNum);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void modifyReview(int revNum, String newContent) {
        ReviewDAO dao = new ReviewDAO();
        try {
            dao.updateReview(revNum, newContent);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
