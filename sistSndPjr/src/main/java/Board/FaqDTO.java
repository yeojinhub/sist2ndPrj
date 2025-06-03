package Board;

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
public class FaqDTO {

	private int faq_num; /* faq번호 */
	private String title; /* faq제목 */
	private String content; /* faq내용 */
	private String name; /* faq작성자 */
	private Date input_date; /* faq작성일 */
	private int acc_num; /* 계정번호 */
	
} //class
