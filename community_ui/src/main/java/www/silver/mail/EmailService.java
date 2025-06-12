package www.silver.mail;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import www.silver.util.RedisUtil;

@Service
public class EmailService {
    
    @Autowired
    private JavaMailSender mailSender;
    
    @Autowired
    private RedisUtil redisUtil;
    
    private static final String AUTH_CODE_PREFIX = "AuthCode:";
    private static final long AUTH_CODE_EXPIRE_TIME = 300; // 5분
    
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
        redisUtil.setDataExpire(redisKey, authCode, AUTH_CODE_EXPIRE_TIME);
    }
    
    // 인증번호 검증
    public boolean verifyAuthCode(String email, String inputCode) {
        String redisKey = AUTH_CODE_PREFIX + email;
        String storedCode = redisUtil.getData(redisKey);
        
        if (storedCode != null && storedCode.equals(inputCode)) {
            // 인증 성공 시 Redis에서 삭제
            redisUtil.deleteData(redisKey);
            
            // 인증 완료 표시 (10분간 유효)
            String verifiedKey = "Verified:" + email;
            redisUtil.setDataExpire(verifiedKey, "true", 600);
            
            return true;
        }
        
        return false;
    }
    
    // 이메일 인증 완료 여부 확인
    public boolean isEmailVerified(String email) {
        String verifiedKey = "Verified:" + email;
        return redisUtil.existData(verifiedKey);
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