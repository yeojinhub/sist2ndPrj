package Faq;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Pagination.PaginationDTO;
import Pagination.PaginationUtil;

public class FaqService {
	private FaqDAO fDAO;
	
	public FaqService() {
		fDAO=FaqDAO.getInstance();
	}
	
	/*
	 * //기존 목록 가져오기 public List<NoticeDTO> getNoticeList() { return
	 * nDAO.getNoticeList(); }// getNoticeList
	 */	
	
	public FaqDTO getNoticeOne(int faqNum) {
		return fDAO.getFaqOne(faqNum);
	}//getNoticeOne
	//전체리스트
	public List<FaqDTO> getFaqList() {
		try {
			PaginationDTO defaultPaginationDTO=PaginationUtil.createPagination(1, 10,fDAO.getTotalFaqCount());
			return fDAO.selectFaqByPage(defaultPaginationDTO);
		} catch (SQLException se) {
			se.printStackTrace();
			return new ArrayList<>();
		}
	}
	
    // 공지사항 작성
	public boolean writeFaq(FaqDTO fDTO) {
	    try {
	        boolean result = fDAO.insertFaq(fDTO);  // 반환값을 제대로 받기
	        System.out.println("writeFaq 결과: " + result);
	        return result;
	    } catch (SQLException e) {
	        System.out.println("writeFaq 오류: " + e.getMessage());
	        e.printStackTrace();
	        return false;
	    }
	}

    // adm_id로 ACC_NUM을 찾는 메서드
    public int getAccNumByAdmId(String admId) {
        try {
            return fDAO.getAccNumByAdmId(admId);
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;  
        }
    }//
    
    
    //delete
    public boolean deleteNotice(int faqNum) {
   
    		try {
    			return fDAO.deleteFaq(faqNum);
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			}
    }
    
    //update
    public boolean updateNotice(FaqDTO fDTO) {
    	return fDAO.updateFaq(fDTO);
    }
    

    //pagination////////////////////////////////////////
    
    public PaginationResult getFaqListWithPagination(String searchType, String seaarchKeyword, String statusType, int currentPage,int pageSize) {
        return getFaqListWithPagination(currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
    }
    
    public PaginationResult getFaqListWithPagination(int currentPage) {
    	
    	return getFaqListWithPagination(currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
    }
    
    public PaginationResult getFaqListWithPagination(int currentPage, int pageSize) {
        List<FaqDTO> faqList = new ArrayList<FaqDTO>();
       // NoticeDAO noticeDAO = NoticeDAO.getInstance();
        PaginationDTO pagination = null;
        
        try {
            // 전체 공지사항 수 조회
            int totalCount = fDAO.getTotalFaqCount();
            System.out.println("총 공지사항 수 : "+totalCount);
            
            // PaginationUtil을 사용하여 페이지네이션 정보 생성
            pagination = PaginationUtil.createPagination(currentPage, pageSize, totalCount);
            System.out.println("Pagination info - currentPage: "+currentPage+" , pageSize : "+pageSize+ " , totalPages: "+pagination.getTotalPages());
            // 페이지에 해당하는 공지사항 목록 조회
            faqList = fDAO.selectFaqByPage(pagination);
            System.out.println("가져온 공지사항 개수 : "+faqList.size());
        } catch (SQLException se) {
            se.printStackTrace();
            // 오류 발생 시 빈 페이지네이션 생성
            if (pagination == null) {
                pagination = PaginationUtil.createPagination(1, pageSize, 0);
            }
        }
        
        return new PaginationResult(faqList, pagination);
    }
    

    public PaginationResult searchFaqWithPagination(String searchType, String searchKeyword, String statusType, int currentPage) { 
    	System.out.println("searchFaqWithPagination호출됨");
    	System.out.println("searchType" +searchType);
    	System.out.println("searchKeyword"+searchKeyword);
    	System.out.println("statusType"+statusType);
    	System.out.println("currentPage"+currentPage);
    	
    	
    	return searchFaqWithPagination(searchType, searchKeyword, statusType, currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
  }
    
    public PaginationResult searchFaqWithPagination(String searchType, String searchKeyword, int currentPage) {
        return searchFaqWithPagination(searchType, searchKeyword, null, currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
    }
    
    public PaginationResult searchFaqWithPagination(String searchType, String searchKeyword, int currentPage, int pageSize) {
        return searchFaqWithPagination(searchType, searchKeyword, null, currentPage, pageSize);
    }


    public PaginationResult searchFaqWithPagination(String searchType, String searchKeyword, String statusType, int currentPage,int pageSize) {
        List<FaqDTO> faqList = new ArrayList<>();
        //NoticeDAO noticeDAO = NoticeDAO.getInstance();
        PaginationDTO pagination = null;
        
        
        try {
        	// 검색어 정리
        	searchKeyword = PaginationUtil.sanitizeSearchKeyword(searchKeyword);
            // 검색 조건에 맞는 전체 공지사항 수 조회
            int totalCount = fDAO.getSearchFaqCount(searchType, searchKeyword);
            
            // PaginationUtil을 사용하여 페이지네이션 정보 생성
            pagination = PaginationUtil.createPagination(currentPage, pageSize, totalCount);
            
            // 검색 조건과 페이지에 해당하는 공지사항 목록 조회
            faqList = fDAO.searchNoticeByPage(searchType, searchKeyword, pagination);
            
        } catch (SQLException se) {
            se.printStackTrace();
            // 오류 발생 시 빈 페이지네이션 생성
            if (pagination == null) {
                pagination = PaginationUtil.createPagination(1, pageSize, 0);
            }
        }
        
        return new PaginationResult(faqList, pagination);
    }
    
    
    public static class PaginationResult {
        private List<FaqDTO> data;
        private PaginationDTO pagination;
        
        public PaginationResult(List<FaqDTO> data, PaginationDTO pagination) {
            this.data = data;
            this.pagination = pagination;
        }
        
        public List<FaqDTO> getData() { return data; }
        public PaginationDTO getPagination() { return pagination; }
    }
}