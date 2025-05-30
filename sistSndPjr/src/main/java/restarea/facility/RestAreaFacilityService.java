package restarea.facility;

import java.sql.SQLException;
import java.util.List;

import DTO.AreaFacilityDTO;

public class RestAreaFacilityService {

	/**
	 * 1.총 레코드의 수
	 * @param rDTO
	 * @return 레코드의 수
	 */
	public int totalCount( DTO.RangeDTO rDTO ) {
		int cnt = 0;
		
		RestAreaFacilityDAO rafDAO = new RestAreaFacilityDAO();
		
		try {
			cnt = rafDAO.selectTotalCount(rDTO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return cnt;
	}
	
	/**
	 * 한 화면에 보여줄 게시물의 수
	 * @return 보여줄 게시물의 수
	 */
	public int pageScale() {
		int pageScale = 10;
		
		return pageScale;
	}
	
	/**
	 * 총 페이지 수
	 * @param totalCount 총 게시물의 수
	 * @param pageScale 한 화면에 보여줄 게시글의 수
	 * @return
	 */
	public int totalPage(int totalCount, int pageScale) {
		int totalPage = 0;
		
		totalPage = (int)Math.ceil((double)totalCount/pageScale);
		
		return totalPage;
	}
	
	/**
	 * pagination을 클릭했을 때의 번호를 사용하여 해당 페이지의 시작버튼을 구하기
	 * 예 1-1, 2-11, 3-21, 4-31, 5-41
	 * @param pageScale
	 * @param rDTO
	 * @return
	 */
	public int startNum(int pageScale, DTO.RangeDTO rDTO) {
		int startNum = 1;
		
		startNum = rDTO.getCurrentPage()*pageScale-pageScale+1;
		rDTO.setStartNum(startNum);
		
		return startNum;
	}
	
	/**
	 * pagination을 클릭했을 때의 번호를 사용하여 해당 페이지의 끝번호를 구하기
	 * @param pageScale
	 * @param rDTO
	 * @return
	 */
	public int endNum(int pageScale, DTO.RangeDTO rDTO ) {
		int endNum = 0;
		
		endNum = rDTO.getStartNum() + pageScale - 1 ;
		rDTO.setEndNum(endNum);
		
		return endNum;
	}
	

	public List<AreaFacilityDTO> searchAllAreaFacility(DTO.RangeDTO rDTO){
		
		List<AreaFacilityDTO> list = null;
		
		RestAreaFacilityDAO rafDAO = new RestAreaFacilityDAO();
		
		
		try {
			list =  rafDAO.selectFacility(rDTO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return list;
	}
	
}
