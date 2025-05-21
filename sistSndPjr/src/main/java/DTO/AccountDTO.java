package DTO;

import java.sql.Date;

public class AccountDTO {
	private int acc_num;/* 계정번호 */
	private String acc_name; /* 계정이름 */
	private String adm_id; /* 관리자ID */
	private String user_email; /* 사용자이메일 */
	private String acc_pass; /* 계정비밀번호 */
	private String acc_tel; /* 계정전화번호 */
	private Date acc_date; /* 계정가입일 */
	private String acc_withdraw; /* 계정탈퇴여부 */
	private int acc_type; /* 계정타입 */
	private String add_certification; /* 인증번호 */
} //class
