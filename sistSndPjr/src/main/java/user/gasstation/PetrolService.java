package user.gasstation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import user.DBConnection.DBConnection;
import user.util.RangeDTO;

public class PetrolService {

	public List<String> searchAllRoute(RangeDTO rDTO) {
		List<String> list = new ArrayList<String>();
		
		PetrolDAO pDAO = new PetrolDAO();
		
		try {
			list = pDAO.selectAllRoute(rDTO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	/**
	 * 모든 주유소 정보를 얻어오는 메소드
	 * @return
	 */
	public List<PetrolDTO> searchAllPetrol(RangeDTO rDTO) {
		List<PetrolDTO> list = new ArrayList<PetrolDTO>();
		
		PetrolDAO pDAO = new PetrolDAO();
		
		// #. 검색 기능
		// #-1. ELECT와 HYDRO의 값을 NULL이 아닌 ON일 경우에 DB에 값(O)와 일치시킨다.
		if (rDTO.getElect() != null) {
			rDTO.setElect("O");
		}// end if
		if (rDTO.getHydro() != null) {
			rDTO.setHydro("O");
		}// end if
		
		try {
			list = pDAO.selectAllPetrol(rDTO);
		} catch (SQLException e) {
			e.printStackTrace();
		}// end try-catch
		
		return list;
	}// searchAllPetrol
	
/****************** pagination ***********************/
	
	/**
	 * 1. 총 레코드(데이터)의 수를 구합니다.
	 * @return
	 */
	public int searchTotalCount(RangeDTO rDTO){
		int cnt = 0;
	
		PetrolDAO pDAO = new PetrolDAO();
		
		// #. 검색 기능
		// #-1. ELECT와 HYDRO의 값을 NULL이 아닌 ON일 경우에 DB에 값(O)와 일치시킨다.
		if (rDTO.getElect() != null) {
			rDTO.setElect("O");
		}// end if
		if (rDTO.getHydro() != null) {
			rDTO.setHydro("O");
		}// end if
		
		try {
			cnt = pDAO.selectTotalCount(rDTO);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return cnt;
	}// selectTotalCount
	
	
	/**
	 * 2. 한 페이지에 보여줄 게시물의 수를 정합니다.
	 * @return 보여줄 게시물의 수
	 */
	public int pageScale() {
		int pageScale = 10;

		return pageScale;
	}// pageScale
	
	
	/**
	 * 3. 총 페이지를 구합니다.
	 * @param totalCount 총 게시물(레코드)의 수
	 * @param pageScale  한 화면에 보여질 게시물의 수
	 * @return 총 페이지 수
	 */
	public int totalPage(int totalCount, int pageScale) {
		int totalPage = 0;

		totalPage = (int) Math.ceil((double) totalCount / pageScale);

		return totalPage;
	}// totalPage
	
	
	/**
	 * 4. 현재 페이지(currentPage)에서 게시물의 시작 번호를 구합니다.
	 * @param pageScale 보여질 페이지 수
	 * @param rDTO
	 * @return
	 */
	public int startNum(int pageScale, RangeDTO rDTO) {
		int startNum = 0;

		startNum = (rDTO.getCurrentPage() * pageScale) - pageScale + 1;
		rDTO.setStartNum(startNum);

		return startNum;
	}// startNum
	
	
	/**
	 * 5. 현재 페이지(currentPage)에서 게시물의 끝 번호를 구합니다.
	 * @param pageScale 보여질 페이지 수
	 * @param rDTO
	 * @return
	 */
	public int endNum(int pageScale, RangeDTO rDTO) {
		int endNum = 0;

		endNum = rDTO.getStartNum() + pageScale - 1;
		rDTO.setEndNum(endNum);

		return endNum;
	}// endNum
	
	
	/****************** pagination ***********************/
	
}// class
