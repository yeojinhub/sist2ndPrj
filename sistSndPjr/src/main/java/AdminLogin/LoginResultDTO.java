package AdminLogin;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 아이디, 이름, 탈퇴여부
 */
@Getter
@AllArgsConstructor
@Setter
@ToString
@NoArgsConstructor
public class LoginResultDTO {
	
	private String acc_num;
	private String name;
    private String adm_id;
    private String user_email;
    private String pass;
    private String tel;
    private Date input_date;
    private boolean withdraw;
    private int rollType;
    private String auth_code;
	
}