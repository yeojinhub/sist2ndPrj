package user.util;

public class PaginationUtil {

	public static String pagination(PaginationDTO pDTO) {
		String divStart = "<div class=\"pagination\">";
		String divEnd = "</div>";
		
		StringBuilder queryString = new StringBuilder("");

		String field = pDTO.getField();
		String route = pDTO.getRoute();
		String elect = pDTO.getElect();
		String hydro = pDTO.getHydro();
		String keyword = pDTO.getKeyword();
		String wash = pDTO.getWash();
		String repair = pDTO.getRepair();
		String truck = pDTO.getTruck();
		String url = pDTO.getUrl();
		int currentPage = pDTO.getCurrentPage();
		int pageNumber = pDTO.getPageNumber();
		int totalPage = pDTO.getTotalPage();

		// 1. Route, Keyword, Elect, Hydro 값 있다면 쿼리스트링 만들기.
		if (route != null) {
			queryString.append("&route=").append(route);
		}// end if
		if (keyword != null) {
			queryString.append("&keyword=").append(keyword);
		}// end if
		if (elect != null) {
			queryString.append("&elect=on");
		}// end if
		if (hydro != null) {
			queryString.append("&hydro=on");
		}// end if
		if (wash != null) {
			queryString.append("&wash=O");
		}// end if
		if (repair != null) {
			queryString.append("&repair=O");
		}// end if
		if (truck != null) {
			queryString.append("&truck=O");
		}// end if

		// 2. 시작, 끝 페이지 구하기.
		int startPage = ((currentPage - 1) / pageNumber) * pageNumber + 1;
		int endPage = (((startPage - 1) + pageNumber) / pageNumber) * pageNumber;

		// 2-1. 끝 페이지가 전체 페이지보다 작다면 끝 페이지는 전체 페이지.
		endPage = totalPage <= endPage ? totalPage : endPage;

		// 3. 이전, 페이지들, 다음 구현하기.
		// 3-1. 이전(prevMark) 만들기.
		int movePage = 0;
		StringBuilder prevMark = new StringBuilder("<span class='prev'>◀</span>");

		if (currentPage > pageNumber) { // 시작페이지보다 1 적은 페이지로 이동
			prevMark.delete(0, prevMark.length());
			movePage = startPage - 1;
			prevMark.append("<a href='").append(url).append("?currentPage=").append(movePage)
					.append(queryString.toString()).append("' class='prev'>◀</a>");
		} // end if

		// 3-2. 페이지들(1, 2, 3...) 만들기
		movePage = startPage;
		StringBuilder pageLink = new StringBuilder();
		
		while (movePage <= endPage) {
			if (movePage == currentPage) { // 현재 페이지는 링크를 설정하지 않고 span태그로 색상을 조정한다.
				pageLink.append("<span style='text-decoration: underline;' class='number'>").append(currentPage).append("</span>");
			} else {
				pageLink.append("<a href='?currentPage=").append(movePage).append(queryString.toString())
						.append("' style='text-decoration: none; color: #333;' class='number'>").append(movePage).append("</a>");
			} // end if-else
			movePage++;
		} // end while

		// 3-3. 다음(next) 만들기.
		StringBuilder nextMark = new StringBuilder("<span class='next' style='margin-left: -10px;'>▶</span>");

		if (totalPage > endPage) {
			movePage = endPage + 1;
			nextMark.delete(0, nextMark.length());
			nextMark.append("<a href='").append(url).append("?currentPage=").append(movePage)
					.append(queryString.toString()).append("' class='next' style='margin-left: -10px;'>▶</a>");

		} // end if

		// 4. 최종 리턴
		return divStart+prevMark.toString() + pageLink.toString() + nextMark.toString()+divEnd;
	}// pagination

}// class