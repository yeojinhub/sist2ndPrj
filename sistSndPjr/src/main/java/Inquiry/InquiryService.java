package Inquiry;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBConnection.DBConnection;
import Pagination.PaginationDTO;
import Pagination.PaginationUtil;
import kr.co.sist.cipher.DataDecryption;

public class InquiryService {

	private InquiryDAO iDAO;
	
	public InquiryService() {
		iDAO=InquiryDAO.getInstance();
	}
	
	
    // Base64 유효성 검사
    private boolean isValidBase64(String input) {
        if (input == null || input.length() % 4 != 0) return false;
        return input.matches("^[A-Za-z0-9+/]+={0,2}$?");
    }
	
	//detail넘어갈떄
    public InquiryDTO getInquiryOne(int inqNum) {
        InquiryDTO dto = iDAO.getInquiryOne(inqNum);
        if (dto != null) {
            try {
                String myKey = "asdf1234asdf1234"; // 암호화 키
                DataDecryption dd = new DataDecryption(myKey);
                String encryptedName = dto.getName();
                // 이름이 Base64 형식이면 복호화 시도
                if (isValidBase64(encryptedName)) {
                    String decryptedName = dd.decrypt(encryptedName);
                    dto.setName(decryptedName);
                } else {
                    System.out.println("Base64 형식 아님: " + encryptedName);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return dto;
    }//getInquiryOne
	
	//전체리스트
	public List<InquiryDTO> getInquiryList() {
		try {
			PaginationDTO defaultPaginationDTO=PaginationUtil.createPagination(1, 10,iDAO.getTotalInquiryCount());
			
			List<InquiryDTO> list = iDAO.selectInquiryByPage(defaultPaginationDTO);
					
			return list;
		} catch (SQLException se) {
			//se.printStackTrace();
			return new ArrayList<>();
		}
	}//getInquiryList
	
    // 문의 작성
	public boolean writeInquiry(InquiryDTO iDTO) {
	    try {
	        boolean result = iDAO.insertInquiry(iDTO);
	        System.out.println("writeInquiry 결과: " + result);
	        return result;
	    } catch (SQLException e) {
	        System.out.println("writeInquiry 오류: " + e.getMessage());
	       // e.printStackTrace();
	        return false;
	    }
	}

    // adm_id로 ACC_NUM을 찾는 메서드
    public int getAccNumByAdmId(String admId) {
        try {
            return iDAO.getAccNumByAdmId(admId);
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;  
        }
    }
    
    //delete - 문의 + 답변//////////////////////////////////////
    public boolean deleteInquiryAndAnswer(int inqNum) {
        Connection conn = null;
        PreparedStatement deleteAnswerStmt = null;
        PreparedStatement deleteInquiryStmt = null;

        try {
            conn = DBConnection.getInstance().getDbCon();
            conn.setAutoCommit(false); 

            // 1.답변 먼저 삭제
            StringBuilder deleteAnswer=new StringBuilder();
            deleteAnswer
            .append("	DELETE FROM answer	")
            .append("	WHERE inq_num = ?	")
            ;
            
            deleteAnswerStmt = conn.prepareStatement(deleteAnswer.toString());
            deleteAnswerStmt.setInt(1, inqNum);
            deleteAnswerStmt.executeUpdate();

            // 2. 문의 삭제
            StringBuilder deleteInquiry=new StringBuilder();
            deleteInquiry
            .append("	DELETE FROM inquiry	")
            .append("	WHERE inq_num = ?	")
            ;
            
            deleteInquiryStmt = conn.prepareStatement(deleteInquiry.toString());
            deleteInquiryStmt.setInt(1, inqNum);
            int result = deleteInquiryStmt.executeUpdate();

            conn.commit();
            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ignored) {}
            return false;
        } finally {
            try {
                if (deleteAnswerStmt != null) deleteAnswerStmt.close();
                if (deleteInquiryStmt != null) deleteInquiryStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ignored) {}
        }
    }

    
    //update
    public boolean updateInquiry(InquiryDTO iDTO) {
    	return iDAO.updateInquiry(iDTO);
    }
    

    //pagination////////////////////////////////////////
    
    public PaginationResult getInquiryListWithPagination(String searchType, String searchKeyword, String statusType, int currentPage,int pageSize) {
    	return getInquiryListWithPagination(currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
    }
    
    public PaginationResult getInquiryListWithPagination(int currentPage) {
    	
    	return getInquiryListWithPagination(currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
    }
    
    public PaginationResult getInquiryListWithPagination(int currentPage, int pageSize) {
        List<InquiryDTO> inquiryList = new ArrayList<InquiryDTO>();
        PaginationDTO pagination = null;
        
        try {
            // 전체 공지사항 수 조회
            int totalCount = iDAO.getTotalInquiryCount();
            System.out.println("총 공지사항 수 : "+totalCount);
            
            // PaginationUtil을 사용하여 페이지네이션 정보 생성
            pagination = PaginationUtil.createPagination(currentPage, pageSize, totalCount);
            System.out.println("Pagination info - currentPage: "+currentPage+" , pageSize : "+pageSize+ " , totalPages: "+pagination.getTotalPages());
            // 페이지에 해당하는 공지사항 목록 조회
            inquiryList = iDAO.selectInquiryByPage(pagination);
         
            String myKey = "asdf1234asdf1234";
			DataDecryption dd = new DataDecryption(myKey);
					
			for (InquiryDTO item : inquiryList) {
				try {
					String name=item.getName();
                    if (isValidBase64(name)) {
                        String decryptedName = dd.decrypt(name);
                        item.setName(decryptedName);
                        System.out.println("복호화된 이름 : " + decryptedName);
                    } else {
                        System.out.println("Base64 형식 아님: " + name);
                    }
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
            
            System.out.println("가져온 문의사항 개수 : "+inquiryList.size());
        } catch (SQLException se) {
            se.printStackTrace();
            // 오류 발생 시 빈 페이지네이션 생성
            if (pagination == null) {
                pagination = PaginationUtil.createPagination(1, pageSize, 0);
            }
        }
        
        return new PaginationResult(inquiryList, pagination);
    }
    

    public PaginationResult searchInquiryListWithPagination(String searchType, String searchKeyword, String statusType, int currentPage) { 
    	System.out.println("searchInquiryWithPagination호출됨");
    	System.out.println("searchType" +searchType);
    	System.out.println("searchKeyword"+searchKeyword);
    	System.out.println("statusType"+statusType);
    	System.out.println("currentPage"+currentPage);
    	
    	
    	return searchInquiryWithPagination(searchType, searchKeyword, statusType, currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
  }


    public PaginationResult searchInquiryWithPagination(String searchType, String searchKeyword, String statusType, int currentPage,int pageSize) {
        List<InquiryDTO> inquiryList = new ArrayList<>();
        PaginationDTO pagination = null;
        
        try {
        	// 검색어 정리
        	searchKeyword = PaginationUtil.sanitizeSearchKeyword(searchKeyword);
            // 검색 조건에 맞는 전체 공지사항 수 조회
            int totalCount = iDAO.getSearchInquiryCount(searchType, searchKeyword, statusType);
            
            // PaginationUtil을 사용하여 페이지네이션 정보 생성
            pagination = PaginationUtil.createPagination(currentPage, pageSize, totalCount);
            
            // 검색 조건과 페이지에 해당하는 공지사항 목록 조회
            inquiryList = iDAO.searchInquiryByPage(searchType, searchKeyword, statusType, pagination);
            
            String myKey = "asdf1234asdf1234";
			DataDecryption dd = new DataDecryption(myKey);
					
            for (InquiryDTO item : inquiryList) {
                try {
                    String name = item.getName();
                    if (isValidBase64(name)) {
                        String decryptedName = dd.decrypt(name);
                        item.setName(decryptedName);
                        System.out.println("복호화된 이름 : " + decryptedName);
                    } else {
                        System.out.println("Base64 형식 아님: " + name);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            
        } catch (SQLException se) {
            se.printStackTrace();
            // 오류 발생 시 빈 페이지네이션 생성
            if (pagination == null) {
                pagination = PaginationUtil.createPagination(1, pageSize, 0);
            }
        }
        
        return new PaginationResult(inquiryList, pagination);
    }
    
    
    public static class PaginationResult {
        private List<InquiryDTO> data;
        private PaginationDTO pagination;
        
        public PaginationResult(List<InquiryDTO> data, PaginationDTO pagination) {
            this.data = data;
            this.pagination = pagination;
        }
        
        public List<InquiryDTO> getData() { return data; }
        public PaginationDTO getPagination() { return pagination; }
    }
	
}
