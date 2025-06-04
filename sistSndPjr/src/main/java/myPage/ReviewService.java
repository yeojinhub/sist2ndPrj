package myPage;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DTO.PaginationDTO2;
import DTO.ReviewDTO;

public class ReviewService {
	public List<ReviewDTO> searchReviewsByEmailWithPaging(String email, PaginationDTO2 paging) {
        List<ReviewDTO> list = null;
        ReviewDAO dao = new ReviewDAO();
        try {
            list = dao.selectReviewByEmailWithPaging(email, paging.getStartRow(), paging.getEndRow());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
	
	public int getTotalCnt(String email) {
		int cnt = 0;
		ReviewDAO rDAO = new ReviewDAO();
		try {
			cnt = rDAO.selectReviewCnt(email);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return cnt;
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
