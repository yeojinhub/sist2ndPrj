package DTO;

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
public class QuestionDTO {
	private int inq_num;
	private String title;
	private int acc_num;
	private String content;
	private String status;
	private Date input_date;
	private String name;
	private String answer_content;
}
