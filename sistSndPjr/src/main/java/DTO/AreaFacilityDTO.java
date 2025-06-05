package DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class AreaFacilityDTO {

	private int area_num;
	private String name,route,addr,tel,operation_time;
	private String feed,sleep,shower,laundry,clinic,pharmacy,shelter,salon,repair,truck,temp;
	private double lat,lng;	

	
}
