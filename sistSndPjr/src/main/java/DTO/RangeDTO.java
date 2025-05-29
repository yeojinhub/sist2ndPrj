package DTO;

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

	private String route, keyword, elect, hydro;
	private int currentPage = 1, startNum, endNum;
	private int startPage, endPage;
	
}
