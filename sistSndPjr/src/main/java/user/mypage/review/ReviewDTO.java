package user.mypage.review;

import java.sql.Date;

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
public class ReviewDTO {
	private int rev_num;
	private int area_num;
	private String area_name;
	private int acc_num;
	private String content;
	private Date input_date;
	private String user_name;
}
