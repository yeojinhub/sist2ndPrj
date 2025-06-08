package Pagination;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PaginationDTO {
    private int currentPage;      // 현재 페이지
    private int pageSize;         // 페이지당 항목 수
    private int totalCount;       // 전체 항목 수
    private int totalPages;       // 전체 페이지 수
    private int startPage;        // 페이지네이션 시작 페이지
    private int endPage;          // 페이지네이션 끝 페이지
    private boolean hasPrevious;  // 이전 페이지 존재 여부
    private boolean hasNext;      // 다음 페이지 존재 여부
    
    public PaginationDTO() {
    	this.pageSize = 10; // 기본값 10개
    	this.currentPage = 1; // 기본값 1페이지
    }
    
    public PaginationDTO(int currentPage, int pageSize, int totalCount) {
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        // calculatePagination() 메서드는 PaginationUtil로 이동했으므로 제거
    }
    
    // 오라클용 ROWNUM 계산 (하위 호환성을 위해 유지)
    public int getStartRowNum() {
        return (currentPage - 1) * pageSize + 1;
    }
    
    public int getEndRowNum() {
        return currentPage * pageSize;
    }
    
    // Oracle 12c 이상용 OFFSET 값 (하위 호환성을 위해 유지)
    public int getOffset() {
        return (currentPage - 1) * pageSize;
    }
} //class