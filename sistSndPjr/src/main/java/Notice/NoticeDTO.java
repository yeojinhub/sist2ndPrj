package Notice;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class NoticeDTO {
	private int not_num; //공지번호
	private String title; // 제목
	private String content; //내용
	private String name; //이름
	private Date input_date; //날짜
	private String status_type; //공지,미공지
	private int acc_num; //관리자번호
}

