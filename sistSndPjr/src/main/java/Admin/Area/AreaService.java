package Admin.Area;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Pagination.PaginationDTO;
import Pagination.PaginationUtil;

public class AreaService {

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
		List<AreaDTO> areaList = new ArrayList<AreaDTO>();
		AreaDAO areaDAO = AreaDAO.getInstance();
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
		List<AreaDTO> areaList = new ArrayList<AreaDTO>();
		AreaDAO areaDAO = AreaDAO.getInstance();
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
		private List<AreaDTO> data;
		private PaginationDTO pagination;

		public PaginationResult(List<AreaDTO> data, PaginationDTO pagination) {
			this.data = data;
			this.pagination = pagination;
		} //PaginationResult

		public List<AreaDTO> getData() {
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
	public List<AreaDTO> searchAllArea() {
		List<AreaDTO> areaList = new ArrayList<AreaDTO>();
		
		AreaDAO areaDAO = AreaDAO.getInstance();
		
		try {
			areaList = areaDAO.selectAllArea();
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return areaList;
	} //searchAllArea
	
	/**
	 * 단일 휴게소 상세정보 조회
	 * @param num 조회할 휴게소 번호
	 * @return areaDTO 조회한 휴게소 상세정보
	 */
	public AreaDTO searchOneArea(int num) {
		AreaDTO areaDTO = new AreaDTO();
		
		AreaDAO areaDAO = AreaDAO.getInstance();
		
		try {
			areaDTO = areaDAO.selectOneArea(num);
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return areaDTO;
	} //searchOneArea
	
	/**
	 * 휴게소 상세정보 등록
	 * @param userDTO 등록할 사용자 계정 정보
	 * @return flag 성공시 true, 실패시 false 반환
	 */
	public boolean addArea(AreaDTO areaDTO) {
		boolean flag = false;
		
		AreaDAO areaDAO = AreaDAO.getInstance();
		
		try {
			areaDAO.insertArea(areaDTO);
			flag = true;
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return flag;
	} //addArea
	
	/**
	 * 휴게소 상세정보 수정
	 * @param areaDTO 수정할 휴게소 상세정보
	 * @return flag 성공시 true, 실패시 false 반환
	 */
	public boolean modifyArea(AreaDTO areaDTO) {
		boolean flag = false;
		
		AreaDAO areaDAO = AreaDAO.getInstance();
		
		try {
			areaDAO.updateArea(areaDTO);
			flag = true;
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return flag;
	} //modifyArea
	
	/**
	 * 휴게소 상세정보 삭제
	 * @param areaList 삭제할 휴게소 번호 리스트
	 * @return flag 성공시 true, 실패시 false 반환
	 */
	public boolean removeArea(List<Integer> areaList) {
		boolean flag = false;
		
		AreaDAO areaDAO = AreaDAO.getInstance();
		
		try {
			areaDAO.deleteArea(areaList);
			flag = true;
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return flag;
	} //removeArea
	
} //class