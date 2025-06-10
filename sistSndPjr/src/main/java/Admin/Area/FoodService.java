package Admin.Area;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Pagination.PaginationDTO;
import Pagination.PaginationUtil;

public class FoodService {
	
	/**
	 * 페이지네이션을 적용한 휴게소 목록을 조회합니다.
	 * @param currentPage 현재 페이지
	 * @return 페이지네이션 결과
	 */
	public PaginationResult getAreaListWithPagination(int currentPage) {
		return getAreaListWithPagination(currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
	} //getAreaListWithPagination

	/**
	 * 페이지네이션을 적용한 휴게소 목록을 조회합니다.
	 * @param currentPage 현재 페이지
	 * @param pageSize    페이지 크기
	 * @return 페이지네이션 결과
	 */
	public PaginationResult getAreaListWithPagination(int currentPage, int pageSize) {
		List<FoodDTO> areaList = new ArrayList<FoodDTO>();
		FoodDAO areaDAO = FoodDAO.getInstance();
		PaginationDTO pagination = null;

		try {
			// 전체 휴게소 수 조회
			int totalCount = areaDAO.getTotalAreaCount();

			// PaginationUtil을 사용하여 페이지네이션 정보 생성
			pagination = PaginationUtil.createPagination(currentPage, pageSize, totalCount);

			// 페이지에 해당하는 휴게소 목록 조회
			areaList = areaDAO.selectAreasByPage(pagination);

		} catch (SQLException se) {
			se.printStackTrace();
			// 오류 발생 시 빈 페이지네이션 생성
			if (pagination == null) {
				pagination = PaginationUtil.createPagination(1, pageSize, 0);
			} //end if
		} //end try catch

		return new PaginationResult(areaList, pagination);
	} //getAreaListWithPagination

	/**
	 * 검색 조건을 적용한 페이지네이션 휴게소 목록을 조회합니다.
	 * @param searchType    검색 유형
	 * @param searchKeyword 검색어
	 * @param currentPage   현재 페이지
	 * @return 페이지네이션 결과
	 */
	public PaginationResult searchAreasWithPagination(String searchType, String searchKeyword, int currentPage) {
		return searchAreasWithPagination(searchType, searchKeyword, currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
	} //searchAreasWithPagination

	/**
	 * 검색 조건을 적용한 페이지네이션 휴게소 목록을 조회합니다.
	 * @param searchType    검색 유형
	 * @param searchKeyword 검색어
	 * @param currentPage   현재 페이지
	 * @param pageSize      페이지 크기
	 * @return 페이지네이션 결과
	 */
	public PaginationResult searchAreasWithPagination(String searchType, String searchKeyword, int currentPage,
			int pageSize) {
		List<FoodDTO> areaList = new ArrayList<FoodDTO>();
		FoodDAO areaDAO = FoodDAO.getInstance();
		PaginationDTO pagination = null;

		// 검색어 정리
		searchKeyword = PaginationUtil.sanitizeSearchKeyword(searchKeyword);

		try {
			// 검색 조건에 맞는 전체 휴게소 수 조회
			int totalCount = areaDAO.getSearchAreaCount(searchType, searchKeyword);

			// PaginationUtil을 사용하여 페이지네이션 정보 생성
			pagination = PaginationUtil.createPagination(currentPage, pageSize, totalCount);

			// 검색 조건과 페이지에 해당하는 휴게소 목록 조회
			areaList = areaDAO.searchAreasByPage(searchType, searchKeyword, pagination);

		} catch (SQLException se) {
			se.printStackTrace();
			// 오류 발생 시 빈 페이지네이션 생성
			if (pagination == null) {
				pagination = PaginationUtil.createPagination(1, pageSize, 0);
			} //end if
		} //end try catch

		return new PaginationResult(areaList, pagination);
	} //searchAreasWithPagination

	/**
	 * 페이지네이션 결과를 담는 내부 클래스
	 */
	public static class PaginationResult {
		
		private List<FoodDTO> data;
		private PaginationDTO pagination;

		public PaginationResult(List<FoodDTO> data, PaginationDTO pagination) {
			this.data = data;
			this.pagination = pagination;
		} //PaginationResult

		public List<FoodDTO> getData() {
			return data;
		} //getData

		public PaginationDTO getPagination() {
			return pagination;
		} //getPagination
		
	} //PaginationResult
	
	/**
	 * 전체 휴게소 상세정보 조회
	 * @return areaList 조회한 전체 휴게소 상세정보 리스트
	 */
	public List<FoodDTO> searchAllArea() {
		List<FoodDTO> areaList = new ArrayList<FoodDTO>();
		
		FoodDAO aDAO = FoodDAO.getInstance();
		
		try {
			areaList = aDAO.selectAllArea();
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return areaList;
	} //searchAllArea
	
	/**
	 * 단일 휴게소 상세정보 조회
	 * @param num 조회할 휴게소 번호
	 * @return fDTO 단일 휴게소 정보
	 */
	public FoodDTO searchOneArea(int num) {
		FoodDTO fDTO = null;
		
		FoodDAO fDAO = FoodDAO.getInstance();
		
		try {
			fDTO = fDAO.selectOneArea(num);
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return fDTO;
	} // searchOneArea
	
	/**
	 * 전체 먹거리 조회
	 * @param num 조회할 휴게소 번호
	 * @return foodList 조회한 전체 먹거리 리스트
	 */
	public List<FoodDTO> searchAllFood(int num) {
		List<FoodDTO> foodList = new ArrayList<FoodDTO>();
		
		FoodDAO fDAO = FoodDAO.getInstance();
		
		try {
			foodList = fDAO.selectAllFood(num);
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return foodList;
	} //searchAllFood
	
	/**
	 * 단일 먹거리 조회
	 * @param num 조회할 음식번호
	 * @return fDTO 단일 먹거리 정보
	 */
	public FoodDTO searchOneFood(int num) {
		FoodDTO fDTO = null;
		
		FoodDAO fDAO = FoodDAO.getInstance();
		
		try {
			fDTO = fDAO.selectOneFood(num);
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return fDTO;
	} // searchOneFood
	
	/**
	 * 음식 추가
	 * @param fDTO 사용자로부터 입력받은 등록할 음식 정보
	 * @return flag 성공시 true, 실패시 false 반환
	 */
	public boolean addFood(FoodDTO fDTO) {
		boolean flag = false;
		
		FoodDAO fDAO = FoodDAO.getInstance();
		
		try {
			fDAO.insertFood(fDTO);
			flag = true;
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return flag;
	} //addFood
	
	/**
	 * 음식 수정
	 * @param fDTO 사용자로부터 입력받은 수정할 음식 정보
	 * @return flag 성공시 true, 실패시 false 반환
	 */
	public boolean modifyFood(FoodDTO fDTO) {
		boolean flag = false;
		
		FoodDAO fDAO = FoodDAO.getInstance();
		
		try {
			fDAO.updateFood(fDTO);
			flag = true;
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		System.out.println("Service에서의 음식 DTO 값 : "+fDTO);
		
		return flag;
	} //modifyFood
	
	/**
	 * 음식 상세정보 삭제
	 * @param foodNumList 삭제할 음식 번호 리스트
	 * @return flag 성공시 true, 실패시 false 반환
	 */
	public boolean removeFood(List<Integer> foodNumList) {
		boolean flag = false;
		
		FoodDAO fDAO = FoodDAO.getInstance();
		
		try {
			fDAO.deleteFood(foodNumList);
			flag = true;
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return flag;
	} //removeFood
	
} //class