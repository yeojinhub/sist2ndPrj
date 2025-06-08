package user.util;

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
public class RangeDTO {

	private String route, keyword, elect, hydro,field;
	private String wash, repair, truck;
	private int currentPage = 1, startNum, endNum;
	private int startPage, endPage;
	
	private String[] fieldText = {"제목","내용"};
	
	public String getFieldName() {
		String fieldName = "title";
		if("1".equals(field)) {
			fieldName = "content";
		}
		
		return fieldName;
	}
	
}