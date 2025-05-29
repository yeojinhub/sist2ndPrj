package DTO;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeDTO {

	private int not_num; //공지사항번호
	private int acc_num; //계정번호
	private String title; //제목
	private String content; //내용
	private String name; //작성자
	private String status_type; //상태
	private Date input_date; //작성일
	
}
