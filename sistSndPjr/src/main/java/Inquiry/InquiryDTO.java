package Inquiry;

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

public class InquiryDTO {
	private int inq_num; //질문번호
	private String title; // 제목
	private String content; //내용
	private String name; //이름
	private Date input_date; //날짜
	private String status_type; //대기, 답변완료
	private int acc_num; //관리자번호

}
