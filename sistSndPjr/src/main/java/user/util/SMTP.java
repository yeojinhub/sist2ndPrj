package user.util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

import kr.co.sist.cipher.DataEncryption;

public class SMTP {
	
	private static SMTP instance;
	
	private SMTP() {
	}
	
	public static SMTP getInstance() {
		if (instance == null) {
			instance = new SMTP();
		}// end if
		return instance;
	}// getInstance

	public boolean sendChangePassMail(String email, String sessionId, String domain) {
		boolean flag = false;
		
		String host = "smtp.gmail.com"; // 사용할 SMTP 서버 주소 (구글, 네이버, 카페24 등)
		String user = "modushim@gmail.com"; // 보내는 메일 계정
		String password = "snwb wupv fsfa auiz"; // 계정 비번(앱 비밀번호 등)

		String to = email; // 받는 사람

		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", "587"); // 또는 465(SSL), 25(일반)
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");

		Session session = Session.getInstance(props, new Authenticator() {
		    protected PasswordAuthentication getPasswordAuthentication() {
		        return new PasswordAuthentication(user, password);
		    }
		});

		try {
		    Message message = new MimeMessage(session);
		    message.setFrom(new InternetAddress(user));
		    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
		    message.setSubject("모두쉼 - 비밀번호 재설정"); // 메일 제목
		    
		    // QueryString에 이메일과 세션ID를 넣기 전에 이메일 암호화
		    String myKey = "asdf1234asdf1234";
		    DataEncryption de = new DataEncryption(myKey);
		    String emailForLink = "";
			try {
				emailForLink = de.encrypt("test@test.kr");
			} catch (Exception e) {
				e.printStackTrace();
			}// end try-catch
		    
		    String changePassLink = "http://"+domain+"/sistSndPjr/user/login/forgotUserChangePasswordPage.jsp?e="+emailForLink+"&si="+sessionId;
		    String logoImgLink = "https://drive.google.com/u/0/drive-viewer/AKGpiha_XiIO3STkNDjcgU0T7JAX_AGFXRgKzWhNA0-sx_YKXFzPswNTsGdzwcOXnp3QmlbTEiq6lVTicaJlWnynOxQ7aQhX_r9X8nY=s2560";
		    StringBuilder htmlBuilder = new StringBuilder();

		    htmlBuilder.append("<div style='font-family: Arial, sans-serif; max-width: 500px; margin: 0 auto; border:1px solid #ececec; padding:30px;'>")
		              .append("<h2 style='color:#4a90e2;'>비밀번호 재설정</h2>")
		              .append("<p>안녕하세요, <strong>[모두쉼]</strong> 고객센터입니다.</p>")
		              .append("<p>비밀번호 재설정 요청으로 이메일이 전송되었습니다.<br>")
		              .append("아래 버튼을 클릭해서 비밀번호를 재설정해 주세요.</p>")
		              .append("<a href='").append(changePassLink).append("' ")
		              .append("style='display:inline-block; padding:12px 24px; background:#4a90e2; color:#fff; border-radius:5px; text-decoration:none; font-weight:bold;'>")
		              .append("비밀번호 재설정하기</a>")
		              .append("<p style='margin-top:20px; color:#888; font-size:12px;'>이 메일을 요청하지 않았다면 무시하셔도 됩니다.</p>")
		              .append("<div id='logo' style='margin-top: 50px;'><img src='"+logoImgLink +"'/></div>")
		              .append("</div>");
		    
		    message.setContent(htmlBuilder.toString(), "text/html; charset=UTF-8");

		    Transport.send(message);
		    flag = true;
		} catch (MessagingException e) {
		    System.out.println("메일 전송 실패: " + e.getMessage());
		}// end try-catch
		
		return flag;
	}// sendEmail
	
}// class
