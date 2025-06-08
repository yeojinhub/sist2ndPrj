package Admin.Area;

import java.sql.Blob;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class FoodDTO {
	private int foodNum; /* 음식번호 */
	private String foodName; /* 음식이름 */
	private Blob foodImage; /* 음식사진 */
	private String foodPrice; /* 음식가격 */
	
	private int totalFood; /* 음식개수 */
	
	private int areaNum; /* 휴게소번호 */
	private String areaName; /* 휴게소이름 */
	private String areaAddr; /* 휴게소주소 */
	private String areaTel; /* 휴게소전화전호 */
	private String areaRoute; /* 휴게소노선 */
	private String operationTime; /* 휴게소영업시간 */

} //class
