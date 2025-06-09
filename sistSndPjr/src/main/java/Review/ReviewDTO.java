package Review;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class ReviewDTO {

	private int rev_num; //리뷰번호
	private String content; //내용
	private String name; // 작성자
	private Date input_date; //입력일
	private int report; // 신고
	private String hidden_type; //숨김표시
	private int area_num; //휴게소 번호
	private int acc_num; //게정번호
	private String area_name; //휴게소명
	
}
