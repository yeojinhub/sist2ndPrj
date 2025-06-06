package AdminLogin;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

public class LoginService {

    public boolean loginProcess(LoginDTO lDTO, HttpSession session) {
        boolean flag = false;

        LoginDAO lDAO = LoginDAO.getInstance();
        try {
            LoginResultDTO lrDTO = lDAO.selectLogin(lDTO);

            if (lrDTO != null && !lrDTO.isWithdraw() &&  lrDTO.getRollType() == 0) {
                flag = true;
                session.setAttribute("adm_id", lrDTO.getAdm_id());
                session.setAttribute("name", lrDTO.getName());
                session.setAttribute("userData", lrDTO);
               //System.out.println("LoginService");//이거 안나옴 ->나옴 하...나와리어라
               //System.out.println("LoginService - name: " + lrDTO.getName());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return flag;
    }
}