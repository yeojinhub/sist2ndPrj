package user.restarea.detail;

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
public class AreaDetailDTO {

	private int area_num; // AREA 테이블
	private String originalName ,name, direction, route, addr, tel, operation_time; // AREA 테이블
	private float lat, lng; // AREA 테이블
	private String feed, sleep, shower, laundry, clinic, pharmacy, shelter, salon, repair, wash, truck, temp; // FACILITY 테이블
	
}// class