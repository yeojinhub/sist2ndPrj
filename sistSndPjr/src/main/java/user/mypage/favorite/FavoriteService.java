package user.mypage.favorite;

import java.sql.SQLException;
import java.util.List;

import user.util.PaginationDTO2;


public class FavoriteService {
	
	public List<FavoriteDTO> searchFavoriteWithPaging(String email, PaginationDTO2 paging) {
	    List<FavoriteDTO> list = null;
	    FavoriteDAO fDAO = new FavoriteDAO();
	    try {
	        list = fDAO.selectFavoriteWithPaging(email, paging.getStartRow(), paging.getEndRow());
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	public int getTotalCount(String email) {
	    int count = 0;
	    FavoriteDAO fDAO = new FavoriteDAO();
	    try {
	        count = fDAO.selectFavoriteCnt(email);
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return count;
	}

	
	public int removeFavorites(List<Integer> favNums) {
        int result = 0;
        FavoriteDAO fDAO = new FavoriteDAO();
        try {
            result = fDAO.deleteFavorite(favNums);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}