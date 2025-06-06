package Account;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Pagination.PaginationDTO;
import Pagination.PaginationUtil;

public class AdminAccountService {
	
	/**
	 * 전체 사용자 계정 조회
	 * @return userList 조회한 전체 사용자 계정 리스트
	 */
	public List<AccountDTO> selectAllUser() {
		List<AccountDTO> userList = new ArrayList<AccountDTO>();
		AdminAccountDAO accountDAO = AdminAccountDAO.getInstance();
		
		try {
			userList = accountDAO.selectAllUser();
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return userList;
	} //selectAllUser
	
    /**
     * 페이지네이션을 적용한 사용자 목록을 조회합니다.
     * @param currentPage 현재 페이지
     * @return 페이지네이션 결과
     */
    public PaginationResult getUserListWithPagination(int currentPage) {
        return getUserListWithPagination(currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
    }
    
    /**
     * 페이지네이션을 적용한 사용자 목록을 조회합니다.
     * @param currentPage 현재 페이지
     * @param pageSize 페이지 크기
     * @return 페이지네이션 결과
     */
    public PaginationResult getUserListWithPagination(int currentPage, int pageSize) {
        List<AccountDTO> userList = new ArrayList<AccountDTO>();
        AdminAccountDAO accountDAO = AdminAccountDAO.getInstance();
        PaginationDTO pagination = null;
        
        try {
            // 전체 사용자 수 조회
            int totalCount = accountDAO.getTotalUserCount();
            
            // PaginationUtil을 사용하여 페이지네이션 정보 생성
            pagination = PaginationUtil.createPagination(currentPage, pageSize, totalCount);
            
            // 페이지에 해당하는 사용자 목록 조회
            userList = accountDAO.selectUsersByPage(pagination);
            
        } catch (SQLException se) {
            se.printStackTrace();
            // 오류 발생 시 빈 페이지네이션 생성
            if (pagination == null) {
                pagination = PaginationUtil.createPagination(1, pageSize, 0);
            }
        }
        
        return new PaginationResult(userList, pagination);
    }
    
    /**
     * 검색 조건을 적용한 페이지네이션 사용자 목록을 조회합니다.
     * @param searchType 검색 유형
     * @param searchKeyword 검색어
     * @param currentPage 현재 페이지
     * @return 페이지네이션 결과
     */
    public PaginationResult searchUsersWithPagination(String searchType, String searchKeyword, int currentPage) {
        return searchUsersWithPagination(searchType, searchKeyword, currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
    }
    
    /**
     * 검색 조건을 적용한 페이지네이션 사용자 목록을 조회합니다.
     * @param searchType 검색 유형
     * @param searchKeyword 검색어
     * @param currentPage 현재 페이지
     * @param pageSize 페이지 크기
     * @return 페이지네이션 결과
     */
    public PaginationResult searchUsersWithPagination(String searchType, String searchKeyword, int currentPage, int pageSize) {
        List<AccountDTO> userList = new ArrayList<AccountDTO>();
        AdminAccountDAO accountDAO = AdminAccountDAO.getInstance();
        PaginationDTO pagination = null;
        
        // 검색어 정리
        searchKeyword = PaginationUtil.sanitizeSearchKeyword(searchKeyword);
        
        try {
            // 검색 조건에 맞는 전체 사용자 수 조회
            int totalCount = accountDAO.getSearchUserCount(searchType, searchKeyword);
            
            // PaginationUtil을 사용하여 페이지네이션 정보 생성
            pagination = PaginationUtil.createPagination(currentPage, pageSize, totalCount);
            
            // 검색 조건과 페이지에 해당하는 사용자 목록 조회
            userList = accountDAO.searchUsersByPage(searchType, searchKeyword, pagination);
            
        } catch (SQLException se) {
            se.printStackTrace();
            // 오류 발생 시 빈 페이지네이션 생성
            if (pagination == null) {
                pagination = PaginationUtil.createPagination(1, pageSize, 0);
            }
        }
        
        return new PaginationResult(userList, pagination);
    }
    
    /**
     * 페이지네이션 결과를 담는 내부 클래스
     */
    public static class PaginationResult {
        private List<AccountDTO> data;
        private PaginationDTO pagination;
        
        public PaginationResult(List<AccountDTO> data, PaginationDTO pagination) {
            this.data = data;
            this.pagination = pagination;
        }
        
        public List<AccountDTO> getData() { return data; }
        public PaginationDTO getPagination() { return pagination; }
    }
	
	/**
	 * 단일 사용자 계정 조회
	 * @param accNum 조회할 사용자 계정 번호
	 * @return userDTO 조회한 사용자 계정 정보
	 */
	public AccountDTO searchOneUser(int accNum) {
		AccountDTO userDTO=null;
		
		AdminAccountDAO userDAO=AdminAccountDAO.getInstance();
		
		try {
			userDTO = userDAO.selectOneUser(accNum);
		} catch (SQLException e) {
			e.printStackTrace();
		}  //end try catch
		
		return userDTO;
		
	} //searchOneUser
	
	/**
	 * 사용자 계정 등록
	 * @param userDTO 등록할 사용자 계정 정보
	 * @return flag 성공시 true, 실패시 false 반환
	 */
	public boolean addUser(AccountDTO userDTO) {
		boolean flag = false;
		
		AdminAccountDAO userDAO = AdminAccountDAO.getInstance();
		
		try {
			userDAO.insertUser(userDTO);
			flag = true;
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return flag;
	} //addUser
	
	/**
	 * 사용자 계정 수정
	 * @param userDTO 수정할 사용자 계정 정보
	 * @return flag 성공시 true, 실패시 false 반환
	 */
	public boolean modifyUser(AccountDTO userDTO) {
		boolean flag = false;
		
		AdminAccountDAO userDAO = AdminAccountDAO.getInstance();
		
		try {
			userDAO.updateUser(userDTO);
			flag = true;
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return flag;
	} //modifyUser
	
	/**
	 * 사용자 계정 삭제
	 * @param accNum 삭제할 사용자 계정 번호
	 * @return flag 성공시 true, 실패시 false 반환
	 */
	public boolean removeUser(int accNum) {
		boolean flag = false;
		
		AdminAccountDAO userDAO = AdminAccountDAO.getInstance();
		
		try {
			userDAO.deleteUser(accNum);
			flag = true;
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return flag;
	} //removeUser
	
	/**
	 * 전체 관리자 계정 조회
	 * @return adminList 조회한 전체 관리자 계정 리스트
	 */
	public List<AccountDTO> selectAllAdmin() {
		List<AccountDTO> adminList = new ArrayList<AccountDTO>();
		AdminAccountDAO accountDAO = AdminAccountDAO.getInstance();
		
		try {
			adminList = accountDAO.selectAllAdmin();
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return adminList;
	} //selectAllAdmin
	
	/**
	 * 단일 관리자 계정 조회
	 * @param accNum 조회할 관리자 계정 번호
	 * @return adminDTO 조회한 관리자 계정 정보
	 */
	public AccountDTO searchOneAdmin(int accNum) {
		AccountDTO adminDTO = null;
		
		AdminAccountDAO adminDAO=AdminAccountDAO.getInstance();
		
		try {
			adminDTO = adminDAO.selectOneAdmin(accNum);
		} catch (SQLException e) {
			e.printStackTrace();
		}  //end try catch
		
		return adminDTO;
		
	} //searchOneAdmin
	
	/**
	 * 관리자 계정 수정
	 * @param adminDTO 수정할 관리자 계정 정보
	 * @return flag 성공시 true, 실패시 false 반환
	 */
	public boolean modifyAdmin(AccountDTO adminDTO) {
		boolean flag = false;
		
		AdminAccountDAO adminDAO = AdminAccountDAO.getInstance();
		
		try {
			adminDAO.updateAdmin(adminDTO);
			flag = true;
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return flag;
	} //modifyAdmin

} //class
