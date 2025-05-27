package GasStation;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DTO.PetrolDTO;

public class PetrolService {

	/**
	 * 모든 주유소 정보를 얻어오는 메소드
	 * @return
	 */
	public List<PetrolDTO> searchAllPetrol() {
		List<PetrolDTO> list = new ArrayList<PetrolDTO>();
		
		PetrolDAO pDAO = new PetrolDAO();
		
		try {
			list = pDAO.selectAllPetrol();
		} catch (SQLException e) {
			e.printStackTrace();
		}// end try-catch
		
		return list;
	}// searchAllPetrol
	
}// class
