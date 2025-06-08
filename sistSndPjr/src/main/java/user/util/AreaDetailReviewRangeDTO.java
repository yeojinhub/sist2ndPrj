package user.util;

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
public class AreaDetailReviewRangeDTO {

	private int currentPage = 1, startNum, endNum;
	private int startPage, endPage, id;
	
}// class