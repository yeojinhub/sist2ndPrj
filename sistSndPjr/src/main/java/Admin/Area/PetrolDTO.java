package Admin.Area;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class PetrolDTO {
	
	private int petNum; /* 주유소번호 */
	private String gasoline; /* 휘발유 */
	private String diesel; /* 경유 */
	private String lpg; /* lpg */
	private String elect; /* 전기 */
	private String hydro; /* 수소 */
	
	private String areaName; /* 휴게소이름 */
	private String areaRoute; /* 휴게소노선 */
	private String areaTel; /* 휴게소전화번호 */
	
} // class