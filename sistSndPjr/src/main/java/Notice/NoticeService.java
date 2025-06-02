package Notice;

import java.sql.PreparedStatement;
import Pagination.PaginationDTO;
import Pagination.PaginationUtil;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
public class NoticeService {
	private NoticeDAO nDAO;
	
	public NoticeService() {
		nDAO=new NoticeDAO();
	}
	
	//기존 목록 가져오기
	public List<NoticeDTO> getNoticeList() {
		return nDAO.getNoticeList();
	}// getNoticeList
	
	
	public NoticeDTO getNoticeOne(int notNum) {
		return nDAO.getNoticeOne(notNum);
	}//getNoticeOne
	
	
    // 공지사항 작성
	public boolean writeNotice(NoticeDTO ntDTO) {
	    try {
	        boolean result = nDAO.insertNotice(ntDTO);  // 반환값을 제대로 받기
	        System.out.println("writeNotice 결과: " + result);
	        return result;
	    } catch (SQLException e) {
	        System.out.println("writeNotice 오류: " + e.getMessage());
	        e.printStackTrace();
	        return false;
	    }
	}

    // adm_id로 ACC_NUM을 찾는 메서드
    public int getAccNumByAdmId(String admId) {
        try {
            return nDAO.getAccNumByAdmId(admId);
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;  
        }
    }
    
    //delete
    public boolean deleteNotice(int notNum) {
   
    		try {
				return nDAO.deletNotice(notNum);
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			}
    }
    
    //update
    public boolean updateNotice(NoticeDTO ntDTO) {
    	NoticeDAO nDAO=new NoticeDAO();
    	return nDAO.updateNotice(ntDTO);
    }
    

    

}
