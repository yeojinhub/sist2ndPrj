package user.util;

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
public class AreaDetailReviewPaginationDTO {

	private int pageNumber, currentPage, totalPage;
	
}// class
