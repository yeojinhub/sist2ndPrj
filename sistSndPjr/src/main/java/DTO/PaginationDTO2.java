package DTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaginationDTO2 {
    private int page;        // 현재 페이지 번호
    private int pageSize;    // 한 페이지에 표시할 데이터 수
    private int totalCount;  // 전체 데이터 수

    private int totalPage;   // 총 페이지 수
    private int startRow;    // DB 조회 시작 row (Oracle 기준 1부터 시작)
    private int endRow;      // DB 조회 끝 row

    private int startPage;   // 페이징 버튼 시작 번호
    private int endPage;     // 페이징 버튼 끝 번호
    private int pageBlock;   // 한 번에 보여줄 페이지 버튼 개수 (예: 5 → 1 2 3 4 5)

    public PaginationDTO2(int page, int pageSize, int totalCount) {
        this.page = page;
        this.pageSize = pageSize;
        this.totalCount = totalCount;

        // 총 페이지 수
        this.totalPage = (int) Math.ceil((double) totalCount / pageSize);

        // 조회 범위 계산 (Oracle 기준)
        this.startRow = (page - 1) * pageSize + 1;
        this.endRow = page * pageSize;

        // 페이징 블럭 계산
        this.pageBlock = 5;
        this.startPage = ((page - 1) / pageBlock) * pageBlock + 1;
        this.endPage = startPage + pageBlock - 1;

        if (endPage > totalPage) {
            endPage = totalPage;
        }
    }
}



