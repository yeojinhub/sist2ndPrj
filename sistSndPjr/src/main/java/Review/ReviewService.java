package Review;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Pagination.PaginationDTO;
import Pagination.PaginationUtil;
import kr.co.sist.cipher.DataDecryption;

public class ReviewService {

    private ReviewDAO rDAO;

    public ReviewService() {
        rDAO = ReviewDAO.getInstance();
    }

	public ReviewDTO getReviewOne(int revNum) {
		ReviewDTO rDTO = rDAO.getReviewOne(revNum);
	    if (rDTO != null) {
	        try {
	            String myKey = "asdf1234asdf1234"; // 암호화 키
	            DataDecryption dd = new DataDecryption(myKey);
	            String decryptedName = dd.decrypt(rDTO.getName());
	            rDTO.setName(decryptedName); // 복호화된 이름으로 교체
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
		return rDTO;
	}//getNoticeOne
	
///////////////////////////////////////////////////////////////////////   
	// Hiddn_type 
	public boolean hideReview(int revNum) {
	    try {
	        System.out.println("숨김 처리할 리뷰번호: " + revNum);
	        int result = rDAO.updateHiddenType(revNum, "Y");
	        System.out.println("updateHiddenType 결과 행의 수: " + result);
	        return result > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}//hideReview
	
	// Hiddn_type -checkBox
	public boolean hideReviewsBatch(List<String> revNumStrings) {
	    try {
	        for(String revNumStr : revNumStrings) {
	            int revNum = Integer.parseInt(revNumStr);
	            int updated = rDAO.updateHiddenType(revNum, "Y");
	            if (updated == 0) {
	                return false;
	            }//if
	        }
	        return true;
	    } catch(Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}//hideReviewsBatch
///////////////////////////////////////////////////////	
	//페이지네이션 - 출력(전체)
	
    public PaginationResult getReviewListWithPagination(int currentPage) {
    	
        return getReviewListWithPagination(currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
    }

    public PaginationResult getReviewListWithPagination(int currentPage, int pageSize) {
        List<ReviewDTO> reviewList = new ArrayList<>();
        PaginationDTO pagination = null;

        try {
            int totalCount = rDAO.getTotalReviewCount();
            System.out.println("전체 리뷰수: " + totalCount);

            pagination = PaginationUtil.createPagination(currentPage, pageSize, totalCount);

            reviewList = rDAO.selectReviewsByPage(pagination);
            System.out.println("service - DAO에서 가져온 리뷰개수: " + reviewList.size());
            
            String myKey = "asdf1234asdf1234"; // 복호화 키
            DataDecryption dd = new DataDecryption(myKey);
            
            for (ReviewDTO r : reviewList) {
            	
                try {
                    String decryptedName = dd.decrypt(r.getName());
                    r.setName(decryptedName);
                    System.out.println("복호화된 이름: " + decryptedName);
                } catch (Exception e) {
                    e.printStackTrace();
                    r.setName("복호화 실패");
                }
            }//for
        } catch (SQLException e) {
            e.printStackTrace();
            if (pagination == null) {
                pagination = PaginationUtil.createPagination(1, pageSize, 0);
            }//if
        }
        return new PaginationResult(reviewList, pagination);
    }//getReviewListWithPagination

    public static class PaginationResult {
        private List<ReviewDTO> data;
        private PaginationDTO pagination;
        
        public PaginationResult(List<ReviewDTO> data, PaginationDTO pagination) {
            this.data = data;
            this.pagination = pagination;
        }

        public List<ReviewDTO> getData() {
            return data;
        }

        public PaginationDTO getPagination() {
            return pagination;
        }
    }//PaginationResult
    
    //검색
    public PaginationResult getFilteredReviewList(String hiddenType, int currentPage) throws SQLException {
        int totalCount = rDAO.getSearchReviewCount(hiddenType);
        PaginationDTO pagination = PaginationUtil.createPagination(currentPage, PaginationUtil.DEFAULT_PAGE_SIZE, totalCount);

        List<ReviewDTO> reviewList = rDAO.searchReviewByPage(hiddenType, pagination);

        String myKey = "asdf1234asdf1234"; // 복호화 키
        DataDecryption dd = new DataDecryption(myKey);
        
        for (ReviewDTO r : reviewList) {
        	
            try {
                String decryptedName = dd.decrypt(r.getName());
                r.setName(decryptedName);
                System.out.println("복호화된 이름: " + decryptedName);
            } catch (Exception e) {
                e.printStackTrace();
                r.setName("복호화 실패");
            }
        }//for
        
        return new PaginationResult(reviewList, pagination);
    }//getFilteredReviewList
    
}//class