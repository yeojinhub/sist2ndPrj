package Notice;

import java.sql.PreparedStatement;
import Pagination.PaginationDTO;
import Pagination.PaginationUtil;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
public class NoticeService {
	private NoticeDAO nDAO;
	
	public NoticeService() {
		nDAO=NoticeDAO.getInstance();
	}
	
	/*
	 * //기존 목록 가져오기 public List<NoticeDTO> getNoticeList() { return
	 * nDAO.getNoticeList(); }// getNoticeList
	 */	
	
	public NoticeDTO getNoticeOne(int notNum) {
		return nDAO.getNoticeOne(notNum);
	}//getNoticeOne
	//전체리스트
	public List<NoticeDTO> getNoticeList() {
		try {
			PaginationDTO defaultPaginationDTO=PaginationUtil.createPagination(1, 10,nDAO.getTotalNoticeCount());
			return nDAO.selectNoticeByPage(defaultPaginationDTO);
		} catch (SQLException se) {
			se.printStackTrace();
			return new ArrayList<>();
		}
	}
	
    // 공지사항 작성
	public boolean writeNotice(NoticeDTO ntDTO) {
	    try {
	        boolean result = nDAO.insertNotice(ntDTO);  // 반환값을 제대로 받기
	        System.out.println("writeNotice 결과: " + result);
	        return result;
	    } catch (SQLException e) {
	        System.out.println("writeNotice 오류: " + e.getMessage());
	        e.printStackTrace();
	        return false;
	    }
	}

    // adm_id로 ACC_NUM을 찾는 메서드
    public int getAccNumByAdmId(String admId) {
        try {
            return nDAO.getAccNumByAdmId(admId);
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;  
        }
    }
    
    //delete
    public boolean deleteNotice(int notNum) {
   
    		try {
				return nDAO.deletNotice(notNum);
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			}
    }
    
    //update
    public boolean updateNotice(NoticeDTO ntDTO) {
    	return nDAO.updateNotice(ntDTO);
    }
    

    //pagination////////////////////////////////////////
    
    public PaginationResult getNoticeListWithPagination(String searchType, String seaarchKeyword, String statusType, int currentPage,int pageSize) {
        return getNoticeListWithPagination(currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
    }
    
    public PaginationResult getNoticeListWithPagination(int currentPage) {
    	
    	return getNoticeListWithPagination(currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
    }
    
    public PaginationResult getNoticeListWithPagination(int currentPage, int pageSize) {
        List<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();
       // NoticeDAO noticeDAO = NoticeDAO.getInstance();
        PaginationDTO pagination = null;
        
        try {
            // 전체 공지사항 수 조회
            int totalCount = nDAO.getTotalNoticeCount();
            System.out.println("총 공지사항 수 : "+totalCount);
            
            // PaginationUtil을 사용하여 페이지네이션 정보 생성
            pagination = PaginationUtil.createPagination(currentPage, pageSize, totalCount);
            System.out.println("Pagination info - currentPage: "+currentPage+" , pageSize : "+pageSize+ " , totalPages: "+pagination.getTotalPages());
            // 페이지에 해당하는 공지사항 목록 조회
            noticeList = nDAO.selectNoticeByPage(pagination);
            System.out.println("가져온 공지사항 개수 : "+noticeList.size());
        } catch (SQLException se) {
            se.printStackTrace();
            // 오류 발생 시 빈 페이지네이션 생성
            if (pagination == null) {
                pagination = PaginationUtil.createPagination(1, pageSize, 0);
            }
        }
        
        return new PaginationResult(noticeList, pagination);
    }
    

    public PaginationResult searchNoticeWithPagination(String searchType, String searchKeyword, String statusType, int currentPage) { 
    	System.out.println("searchNoticeWithPagination호출됨");
    	System.out.println("searchType" +searchType);
    	System.out.println("searchKeyword"+searchKeyword);
    	System.out.println("statusType"+statusType);
    	System.out.println("currentPage"+currentPage);
    	
    	
    	return searchNoticesWithPagination(searchType, searchKeyword, statusType, currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
  }


    public PaginationResult searchNoticesWithPagination(String searchType, String searchKeyword, String statusType, int currentPage,int pageSize) {
        List<NoticeDTO> noticeList = new ArrayList<>();
        //NoticeDAO noticeDAO = NoticeDAO.getInstance();
        PaginationDTO pagination = null;
        
        
        try {
        	// 검색어 정리
        	searchKeyword = PaginationUtil.sanitizeSearchKeyword(searchKeyword);
            // 검색 조건에 맞는 전체 공지사항 수 조회
            int totalCount = nDAO.getSearchNoticeCount(searchType, searchKeyword, statusType);
            
            // PaginationUtil을 사용하여 페이지네이션 정보 생성
            pagination = PaginationUtil.createPagination(currentPage, pageSize, totalCount);
            
            // 검색 조건과 페이지에 해당하는 공지사항 목록 조회
            noticeList = nDAO.searchNoticeByPage(searchType, searchKeyword, statusType, pagination);
            
        } catch (SQLException se) {
            se.printStackTrace();
            // 오류 발생 시 빈 페이지네이션 생성
            if (pagination == null) {
                pagination = PaginationUtil.createPagination(1, pageSize, 0);
            }
        }
        
        return new PaginationResult(noticeList, pagination);
    }
    
    
    public static class PaginationResult {
        private List<NoticeDTO> data;
        private PaginationDTO pagination;
        
        public PaginationResult(List<NoticeDTO> data, PaginationDTO pagination) {
            this.data = data;
            this.pagination = pagination;
        }
        
        public List<NoticeDTO> getData() { return data; }
        public PaginationDTO getPagination() { return pagination; }
    }
}
