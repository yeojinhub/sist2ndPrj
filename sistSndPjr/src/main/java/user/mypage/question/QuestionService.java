package user.mypage.question;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import user.util.PaginationDTO2;


public class QuestionService {
	
	public List<QuestionDTO> searchQuestionByEmailWithPaging(String email, String type, String keyword, PaginationDTO2 paging) {
	    List<QuestionDTO> list = null;
	    QuestionDAO qDAO = new QuestionDAO();
	    try {
	        list = qDAO.selectQuestionByEmailWithPaging(email, type, keyword, paging.getStartRow(), paging.getEndRow());
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	
	public QuestionDTO searchQuestionDetail(int inqNum) {
		QuestionDTO dto = null;
		try {
			QuestionDAO dao = new QuestionDAO();
	        dto = dao.selectQuestionDetail(inqNum);
	    } catch (SQLException e) {
	    	e.printStackTrace();
	    }
		return dto;
	}
	 
	public int getTotalCount(String email, String type, String keyword) {
		int cnt = 0;
		QuestionDAO qDAO = new QuestionDAO();
		try {
			cnt = qDAO.selectQuestionCnt(email, type, keyword);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cnt;
	}
	
	public boolean addQuestion(String email, String name,String title, String content){
	    QuestionDAO dao = new QuestionDAO();
	    try {
			dao.insertQuestion(email, name, title, content);
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}  
	}
	
	public void deleteQuestion(int inqNum) {
	    QuestionDAO dao = new QuestionDAO();
	    try {
	        dao.deleteQuestion(inqNum);
	    } catch (SQLException e) {
	        e.printStackTrace(); // 실패 시 로그만 출력
	    }
	}

	  
}
