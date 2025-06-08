package Admin.Area;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Pagination.PaginationDTO;
import Pagination.PaginationUtil;

public class PetrolService {

	/**
	 * 페이지네이션을 적용한 주유소 목록을 조회합니다.
	 * @param currentPage 현재 페이지
	 * @return 페이지네이션 결과
	 */
	public PaginationResult getPetrolListWithPagination(int currentPage) {
		return getPetrolListWithPagination(currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
	} //getPetrolListWithPagination

	/**
	 * 페이지네이션을 적용한 주유소 목록을 조회합니다.
	 * @param currentPage 현재 페이지
	 * @param pageSize    페이지 크기
	 * @return 페이지네이션 결과
	 */
	public PaginationResult getPetrolListWithPagination(int currentPage, int pageSize) {
		List<PetrolDTO> petList = new ArrayList<PetrolDTO>();
		PetrolDAO petDAO = PetrolDAO.getInstance();
		PaginationDTO pagination = null;

		try {
			// 전체 주유소 수 조회
			int totalCount = petDAO.getTotalPetrolCount();

			// PaginationUtil을 사용하여 페이지네이션 정보 생성
			pagination = PaginationUtil.createPagination(currentPage, pageSize, totalCount);

			// 페이지에 해당하는 주유소 목록 조회
			petList = petDAO.selectPetrolsByPage(pagination);

		} catch (SQLException se) {
			se.printStackTrace();
			// 오류 발생 시 빈 페이지네이션 생성
			if (pagination == null) {
				pagination = PaginationUtil.createPagination(1, pageSize, 0);
			} //end if
		} //end try catch

		return new PaginationResult(petList, pagination);
	} //getPetrolListWithPagination

	/**
	 * 검색 조건을 적용한 페이지네이션 주유소 목록을 조회합니다.
	 * @param searchType    검색 유형
	 * @param searchKeyword 검색어
	 * @param currentPage   현재 페이지
	 * @return 페이지네이션 결과
	 */
	public PaginationResult searchPetrolsWithPagination(String searchType, String searchKeyword, int currentPage) {
		return searchPetrolsWithPagination(searchType, searchKeyword, currentPage, PaginationUtil.DEFAULT_PAGE_SIZE);
	} //searchPetrolsWithPagination

	/**
	 * 검색 조건을 적용한 페이지네이션 주유소 목록을 조회합니다.
	 * @param searchType    검색 유형
	 * @param searchKeyword 검색어
	 * @param currentPage   현재 페이지
	 * @param pageSize      페이지 크기
	 * @return 페이지네이션 결과
	 */
	public PaginationResult searchPetrolsWithPagination(String searchType, String searchKeyword, int currentPage,
			int pageSize) {
		List<PetrolDTO> petList = new ArrayList<PetrolDTO>();
		PetrolDAO petDAO = PetrolDAO.getInstance();
		PaginationDTO pagination = null;

		// 검색어 정리
		searchKeyword = PaginationUtil.sanitizeSearchKeyword(searchKeyword);

		try {
			// 검색 조건에 맞는 전체 주유소 수 조회
			int totalCount = petDAO.getSearchPetrolCount(searchType, searchKeyword);

			// PaginationUtil을 사용하여 페이지네이션 정보 생성
			pagination = PaginationUtil.createPagination(currentPage, pageSize, totalCount);

			// 검색 조건과 페이지에 해당하는 주유소 목록 조회
			petList = petDAO.searchPetrolsByPage(searchType, searchKeyword, pagination);

		} catch (SQLException se) {
			se.printStackTrace();
			// 오류 발생 시 빈 페이지네이션 생성
			if (pagination == null) {
				pagination = PaginationUtil.createPagination(1, pageSize, 0);
			} //end if
		} //end try catch

		return new PaginationResult(petList, pagination);
	} //searchAreasWithPagination

	/**
	 * 페이지네이션 결과를 담는 내부 클래스
	 */
	public static class PaginationResult {
		private List<PetrolDTO> data;
		private PaginationDTO pagination;

		public PaginationResult(List<PetrolDTO> data, PaginationDTO pagination) {
			this.data = data;
			this.pagination = pagination;
		} //PaginationResult

		public List<PetrolDTO> getData() {
			return data;
		} //getData

		public PaginationDTO getPagination() {
			return pagination;
		} //getPagination
	} //PaginationResult
	
	/**
	 * 전체 주유소 조회
	 * @return petList 전체 주유소 리스트
	 */
	public List<PetrolDTO> searchAllPetrol() {
		List<PetrolDTO> petList = new ArrayList<PetrolDTO>();
		
		PetrolDAO petDAO = PetrolDAO.getInstance();
		
		try {
			petList = petDAO.selectAllPetrol();
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return petList;
	} //searchAllPetrol
	
	public PetrolDTO searchOnePetrol(int num) {
		System.out.println("Service num : "+num);
		
		PetrolDTO petDTO = null;
		
		PetrolDAO petDAO = PetrolDAO.getInstance();
		
		try {
			petDTO = petDAO.selectOnePetrol(num);
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		System.out.println("Service dto : "+petDTO);
		
		return petDTO;
	} //searchOnePetrol
	
	/**
	 * 주유소 등록
	 * @param petDTO 등록할 주유소 정보
	 * @return flag 성공시 true, 실패시 false 반환
	 */
	public boolean addPetrol(PetrolDTO petDTO) {
		boolean flag = false;
		
		PetrolDAO petDAO = PetrolDAO.getInstance();
		
		try {
			petDAO.insertPetrol(petDTO);
			flag = true;
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return flag;
	} //addPetrol
	
	/**
	 * 주유소 수정
	 * @param petDTO 수정할 주유소 정보
	 * @return flag 성공시 true, 실패시 false 반환
	 */
	public boolean modifyPetrol(PetrolDTO petDTO) {
		boolean flag = false;
		
		PetrolDAO petDAO = PetrolDAO.getInstance();
		
		try {
			petDAO.updatePetrol(petDTO);
			flag = true;
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return flag;
	} //modifyPetrol
	
	/**
	 * 주유소 삭제
	 * @param petNumList 삭제할 주유소 번호 리스트
	 * @return flag 성공시 true, 실패시 false 반환
	 */
	public boolean removePetrol(List<Integer> petNumList) {
		boolean flag = false;
		
		PetrolDAO petDAO = PetrolDAO.getInstance();
		
		try {
			petDAO.deletePetrol(petNumList);
			flag = true;
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return flag;
	} //removePetrol
	
	
} //class
