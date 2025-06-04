package Board;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FaqService {
	
	/**
	 * 전체 faq 게시물 조회
	 * @return faqList 조회한 전체 faq 게시물 리스트
	 */
	public List<FaqDTO> searchAllFaq() {
		List<FaqDTO> faqList = new ArrayList<FaqDTO>();
		FaqDAO faqDAO = FaqDAO.getInstance();
		
		try {
			faqList = faqDAO.selectAllFaq();
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return faqList;
	} //searchAllFaq
	
	/**
	 * 단일 faq 게시물 조회
	 * @param num 조회할 faq 게시물 번호
	 * @return faqList 조회한 단일 faq 게시물 정보
	 */
	public FaqDTO searchOneFaq(int num) {
		System.out.println("service에서의 게시판 번호 : "+num);
		FaqDTO faqDTO = null;
		FaqDAO faqDAO = FaqDAO.getInstance();
		
		try {
			faqDTO = faqDAO.selectOneFaq(num);
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return faqDTO;
	} //searchOneFaq
	
	public boolean addFaq(FaqDTO faqDTO) {
		boolean flag = false;
		
		
		
		return flag;
	} //addFaq

} //class
