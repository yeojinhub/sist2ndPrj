package user.notice.faq;

import java.sql.SQLException;
import java.util.List;

public class FAQService {

public List<FAQDTO> searchAllFAQ(){
		
		List<FAQDTO> list = null;
		
		FAQDAO fDAO = new FAQDAO();
		
		
		try {
			list =  fDAO.selectAllFAQ();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return list;
	}
	
}