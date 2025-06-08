package user.gasstation;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class PetrolDTO {

	private int area_num;
	private String name, tel, route, gasoline, diesel, lpg, elect, hydro;
	
}// class