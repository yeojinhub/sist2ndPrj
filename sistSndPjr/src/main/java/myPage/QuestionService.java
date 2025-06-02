package myPage;

import java.sql.SQLException;
import java.util.List;

import DTO.QuestionDTO;

public class QuestionService {
	public List<QuestionDTO> searchQuestionByEmail(String email){
		List<QuestionDTO> list = null;
		QuestionDAO qDAO = new QuestionDAO();
		try {
			list = qDAO.selectQuestionByEmail(email);
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
	  
}
