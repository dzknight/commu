package www.silver.mail;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import www.silver.util.RedisUtil;
import www.silver.vo.MailVO;

// 메일 전송을 담당하는 서비스 클래스를 생성
@Service
public class MailService {
    private final JavaMailSender mailSender;
    
    
    
    @Autowired
    private RedisUtil redisUtil;
    
    private static final String AUTH_CODE_PREFIX = "AuthCode:";
    private static final long AUTH_CODE_EXPIRE_TIME = 300; // 5분
    
    @Autowired
    public MailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }
    
    // 1. 단순 텍스트 메일 전송
    public void mailSend(MailVO mailvo) {
        SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
        simpleMailMessage.setFrom(mailvo.getFromaddress());
        simpleMailMessage.setTo(mailvo.getAddress());
        simpleMailMessage.setSubject(mailvo.getTitle());
        simpleMailMessage.setText(mailvo.getMessage());
        mailSender.send(simpleMailMessage);
    }
    
    // 인증번호 이메일 전송
    public void sendAuthEmail(String toEmail) throws Exception {
        // 인증번호 생성
        String authCode = redisUtil.createCertifyNum();
        System.out.println(authCode);
        // 이메일 내용 구성
        String subject = "회원가입 이메일 인증";
        String content = buildEmailContent(authCode);
        
        // 이메일 전송
        sendEmail(toEmail, subject, content);
        
        // Redis에 인증번호 저장 (5분 만료)
        String redisKey = AUTH_CODE_PREFIX + toEmail;
        System.out.println("key"+authCode);
        redisUtil.setDataExpire(redisKey, authCode, AUTH_CODE_EXPIRE_TIME);
    }
    
    // 실제 이메일 전송
    private void sendEmail(String toEmail, String subject, String content) throws Exception {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
        
        helper.setFrom("dzknight11@naver.com");
        helper.setTo(toEmail);
        helper.setSubject(subject);
        helper.setText(content, true);
        
        mailSender.send(message);
    }
    // 2. HTML 형식 메일 전송
    public void sendHtmlMail(MailVO mailvo) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
        
        helper.setTo(mailvo.getAddress());
        helper.setSubject(mailvo.getTitle());
        helper.setText(mailvo.getMessage(), true); // true: HTML 형식으로 전송
        
        mailSender.send(message);
    }
    
    // 이메일 내용 구성
    private String buildEmailContent(String authCode) {
        StringBuilder content = new StringBuilder();
        content.append("<html><body>");
        content.append("<h2>회원가입 이메일 인증</h2>");
        content.append("<p>안녕하세요. 회원가입을 위한 이메일 인증번호입니다.</p>");
        content.append("<div style='background-color: #f5f5f5; padding: 20px; margin: 20px 0;'>");
        content.append("<h3 style='color: #333;'>인증번호: <span style='color: #007bff;'>");
        content.append(authCode);
        content.append("</span></h3>");
        content.append("</div>");
        content.append("<p>인증번호는 5분간 유효합니다.</p>");
        content.append("</body></html>");
        
        return content.toString();
    }
}