package Inquiry;

import java.sql.SQLException;

public class AnswerService {

    private static AnswerService instance;
    private final AnswerDAO answerDAO;

    private AnswerService() {
        answerDAO = AnswerDAO.getInstance();
    }

    public static AnswerService getInstance() {
        if (instance == null) {
            instance = new AnswerService();
        }
        return instance;
    }

    // 답변 등록
    public AnswerDTO insertAnswer(int inqNum, String content, String writer) throws SQLException {
        return answerDAO.insertAnswer(inqNum, content, writer);
    }

    // 답변 조회
    public AnswerDTO getAnswerByInquiryNum(int inqNum) throws SQLException {
        return answerDAO.getAnswerByInquiryNum(inqNum);
    }
}//class