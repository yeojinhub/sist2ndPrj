package Pagination;

/**
 * 페이지네이션 관련 유틸리티 클래스
 * 페이지네이션 계산 및 URL 생성 등의 공통 기능을 제공합니다.
 */
public class PaginationUtil {
    
    // 기본 페이지 크기
    public static final int DEFAULT_PAGE_SIZE = 10;
    // 페이지 그룹 크기 (한 번에 보여줄 페이지 번호 개수)
    public static final int DEFAULT_PAGE_GROUP_SIZE = 5;
    
    /**
     * 페이지네이션 정보를 생성합니다.
     * @param currentPage 현재 페이지
     * @param totalCount 전체 항목 수
     * @return PaginationDTO 객체
     */
    public static PaginationDTO createPagination(int currentPage, int totalCount) {
        return createPagination(currentPage, DEFAULT_PAGE_SIZE, totalCount);
    }
    
    /**
     * 페이지네이션 정보를 생성합니다.
     * @param currentPage 현재 페이지
     * @param pageSize 페이지당 항목 수
     * @param totalCount 전체 항목 수
     * @return PaginationDTO 객체
     */
    public static PaginationDTO createPagination(int currentPage, int pageSize, int totalCount) {
        return createPagination(currentPage, pageSize, totalCount, DEFAULT_PAGE_GROUP_SIZE);
    }
    
    /**
     * 페이지네이션 정보를 생성합니다.
     * @param currentPage 현재 페이지
     * @param pageSize 페이지당 항목 수
     * @param totalCount 전체 항목 수
     * @param pageGroupSize 페이지 그룹 크기
     * @return PaginationDTO 객체
     */
    public static PaginationDTO createPagination(int currentPage, int pageSize, int totalCount, int pageGroupSize) {
        PaginationDTO pagination = new PaginationDTO();
        
        // 기본값 설정
        pagination.setCurrentPage(Math.max(1, currentPage));
        pagination.setPageSize(Math.max(1, pageSize));
        pagination.setTotalCount(Math.max(0, totalCount));
        
        // 전체 페이지 수 계산
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        pagination.setTotalPages(totalPages);
        
        // 현재 페이지가 범위를 벗어나지 않도록 조정
        if (pagination.getCurrentPage() > totalPages && totalPages > 0) {
            pagination.setCurrentPage(totalPages);
        }
        
        // 페이지네이션 범위 계산
        calculatePageRange(pagination, pageGroupSize);
        
        // 이전/다음 페이지 존재 여부
        pagination.setHasPrevious(pagination.getCurrentPage() > 1);
        pagination.setHasNext(pagination.getCurrentPage() < totalPages);
        
        return pagination;
    }
    
    /**
     * 페이지 범위를 계산합니다.
     * @param pagination 페이지네이션 객체
     * @param pageGroupSize 페이지 그룹 크기
     */
    private static void calculatePageRange(PaginationDTO pagination, int pageGroupSize) {
        int currentPage = pagination.getCurrentPage();
        int totalPages = pagination.getTotalPages();
        
        int pageGroup = (int) Math.ceil((double) currentPage / pageGroupSize);
        int startPage = (pageGroup - 1) * pageGroupSize + 1;
        int endPage = Math.min(startPage + pageGroupSize - 1, totalPages);
        
        pagination.setStartPage(startPage);
        pagination.setEndPage(endPage);
    }
    
    /**
     * 현재 페이지의 시작 번호를 계산합니다. (화면 표시용)
     * @param pagination 페이지네이션 객체
     * @return 시작 번호
     */
    public static int getDisplayStartNumber(PaginationDTO pagination) {
        return pagination.getTotalCount() - (pagination.getCurrentPage() - 1) * pagination.getPageSize();
    }
    
    /**
     * 현재 페이지의 항목 번호를 계산합니다. (화면 표시용)
     * @param pagination 페이지네이션 객체
     * @param index 현재 항목의 인덱스 (0부터 시작)
     * @return 화면에 표시할 번호
     */
    public static int getDisplayNumber(PaginationDTO pagination, int index) {
        return getDisplayStartNumber(pagination) - index;
    }
    
    /**
     * 페이지 정보 텍스트를 생성합니다.
     * @param pagination 페이지네이션 객체
     * @return 페이지 정보 텍스트 (예: "총 100개 중 1-10개 표시 (1/10 페이지)")
     */
    public static String getPageInfoText(PaginationDTO pagination) {
        int startItem = (pagination.getCurrentPage() - 1) * pagination.getPageSize() + 1;
        int endItem = Math.min(pagination.getCurrentPage() * pagination.getPageSize(), pagination.getTotalCount());
        
        return String.format("총 %d개 중 %d-%d개 표시 (%d/%d 페이지)", 
                pagination.getTotalCount(), 
                startItem, 
                endItem, 
                pagination.getCurrentPage(), 
                pagination.getTotalPages());
    }
    
    /**
     * 페이지 파라미터를 안전하게 파싱합니다.
     * @param pageParam 페이지 파라미터 문자열
     * @param defaultPage 기본 페이지 (보통 1)
     * @return 파싱된 페이지 번호
     */
    public static int parsePageParameter(String pageParam, int defaultPage) {
        if (pageParam == null || pageParam.trim().isEmpty()) {
            return defaultPage;
        }
        
        try {
            int page = Integer.parseInt(pageParam.trim());
            return Math.max(1, page); // 최소 1페이지
        } catch (NumberFormatException e) {
            return defaultPage;
        }
    }
    
    /**
     * 검색어를 안전하게 처리합니다.
     * @param searchKeyword 검색어
     * @return 처리된 검색어 (null이거나 빈 문자열이면 null 반환)
     */
    public static String sanitizeSearchKeyword(String searchKeyword) {
        if (searchKeyword == null || searchKeyword.trim().isEmpty()) {
            return null;
        }
        return searchKeyword.trim();
    }
}