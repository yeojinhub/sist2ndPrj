package user.notice.faq;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FAQDTO {

	private int faq_num; //FAQ번호
	private int acc_num; //계정번호
	private String title; //제목
	private String content; //내용
	private String name; //작성자
	private Date input_date; //작성일
}
