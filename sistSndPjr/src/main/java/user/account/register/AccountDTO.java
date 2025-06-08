package user.account.register;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class AccountDTO {
	private int acc_num;/* 계정번호 */
	private String name; /* 계정이름 */
	private String adm_id; /* 관리자ID */
	private String email;
	private String domain;
	private String user_email; /* 사용자이메일 */
	private String pass; /* 계정비밀번호 */
	private String tel; /* 계정전화번호 */
	private Date input_date; /* 계정가입일 */
	private String withdraw; /* 계정탈퇴여부 */
	private int roletype; /* 계정타입 */
	private String auth_code; /* 인증번호 */
} //class