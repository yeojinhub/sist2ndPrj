package user.util;

public class ReviewPaginationUtil {

	public static String pagination(AreaDetailReviewPaginationDTO adrpDTO) {
		StringBuilder queryString = new StringBuilder("");

		int currentPage = adrpDTO.getCurrentPage();
		int pageNumber = adrpDTO.getPageNumber();
		int totalPage = adrpDTO.getTotalPage();

		// 2. 시작, 끝 페이지 구하기.
		int startPage = ((currentPage - 1) / pageNumber) * pageNumber + 1;
		int endPage = (((startPage - 1) + pageNumber) / pageNumber) * pageNumber;

		// 2-1. 끝 페이지가 전체 페이지보다 작다면 끝 페이지는 전체 페이지.
		endPage = totalPage <= endPage ? totalPage : endPage;

		// 3. 이전, 페이지들, 다음 구현하기.
		// 3-1. 이전(prevMark) 만들기.
		int movePage = 0;
		StringBuilder prevMark = new StringBuilder("<p class='prev'>◀</p>");

		if (currentPage > pageNumber) { // 시작페이지보다 1 적은 페이지로 이동
			prevMark.delete(0, prevMark.length());
			movePage = startPage - 1;
			prevMark.append("<p class='prev'>◀</p>");
		} // end if

		// 3-2. 페이지들(1, 2, 3...) 만들기
		movePage = startPage;
		StringBuilder pageLink = new StringBuilder();

		while (movePage <= endPage) {
			if (movePage == currentPage) { // 현재 페이지는 링크를 설정하지 않고 span태그로 색상을 조정한다.
				pageLink.append("<span style='text-decoration: underline;' class='number'>").append(currentPage).append("</span>");
			} else {
				pageLink.append("<span style='text-decoration: none; cursor: pointer; color: #333;' class='number'>").append(movePage).append("</span>");
			} // end if-else
			movePage++;
		} // end while

		// 3-3. 다음(next) 만들기.
		StringBuilder nextMark = new StringBuilder("<p class='next' style='margin-left: -10px;'>▶</p>");

		if (totalPage > endPage) {
			movePage = endPage + 1;
			nextMark.delete(0, nextMark.length());
			nextMark.append("<p class='next' style='margin-left: -10px;'>▶</p>");

		} // end if

		// 4. 최종 리턴
		return prevMark.toString() + pageLink.toString() + nextMark.toString();
	}// pagination

}// class