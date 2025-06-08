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
public class AreaDTO {
	
	private int area_num; /* 휴게소번호 */
	private String name; /* 휴게소이름 */
	private String addr; /* 휴게소주소 */
	private String tel; /* 휴게소전화전호 */
	private String route; /* 휴게소노선 */
	private String operation_time; /* 휴게소영업시간 */
	private String feed; /* 수유실 */
	private String sleep; /* 수면실 */
	private String shower; /* 샤워실 */
	private String laundry; /* 세탁실 */
	private String clinic; /* 병원 */
	private String pharmacy; /* 약국 */
	private String shelter; /* 쉼터 */
	private String salon; /* 이발소 */
	private String agricultural; /* 농산물판매장 */
	private String repair; /* 경정비소 */
	private String truck; /* 화물차라운지 */
	private String temp; /* 추가시설 */
	private String lat; /* 휴게소위도 */
	private String lng; /* 휴게소경도 */

} //class
