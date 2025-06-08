package user.restarea.detail.review;

import java.sql.Date;

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
public class AreaDetailReviewDTO {

	private int rev_num, report, area_num, acc_num;
	private String content, name;
	private Date input_date;
	
}// class