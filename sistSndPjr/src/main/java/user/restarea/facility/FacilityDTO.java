package user.restarea.facility;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class FacilityDTO {
	
	private int area_num;
	private String feed,sleep,shower,laundry,clinic,pharmacy,shelter,salon,repair,wash,truck,temp;
}
