package user.mypage.favorite;

import java.sql.SQLException;
import java.util.List;

public class FavoriteService {
	public List<FavoriteDTO> searchFavorite(String email){
		List<FavoriteDTO> list = null;
		FavoriteDAO fDAO = new FavoriteDAO();
		try {
			list = fDAO.selectFavorite(email);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
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
