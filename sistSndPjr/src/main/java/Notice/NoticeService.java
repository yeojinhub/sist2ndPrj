package Notice;

import java.sql.SQLException;
import java.util.List;

import DTO.NoticeDTO;

public class NoticeService {

	public List<NoticeDTO> searchAllNotice(){
		
		List<NoticeDTO> list = null;
		
		NoticeDAO nDAO = new NoticeDAO();
		
		
		try {
			list =  nDAO.selectAllNotice();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return list;
	}
	
	public NoticeDTO searchOneNotice(int num) {
		
		NoticeDTO nDTO = null;
		
		NoticeDAO nDAO = new NoticeDAO();
		
		try {
			nDTO = nDAO.selectOneNotice(num);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return nDTO;
	}
	
}
