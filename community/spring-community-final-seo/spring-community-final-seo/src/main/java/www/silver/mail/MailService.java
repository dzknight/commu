package www.silver.mail;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import www.silver.vo.MailVO;


//메일 전송을 담당하는 서비스 클래스를 생성


@Service
public class MailService {
    private final JavaMailSender mailSender;
    
    @Autowired
    public MailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }
    
    // 1. 단순 텍스트 메일 발송
    public void mailSend(MailVO mailvo) {
        SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
        simpleMailMessage.setFrom(mailvo.getFromaddress());
        simpleMailMessage.setTo(mailvo.getAddress());
        simpleMailMessage.setSubject(mailvo.getTitle());
        simpleMailMessage.setText(mailvo.getMessage());
        mailSender.send(simpleMailMessage);
    }
    
    // 2. HTML 형식 메일 발송
    public void sendHtmlMail(MailVO mailvo) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
        
        helper.setTo(mailvo.getAddress());
        helper.setSubject(mailvo.getTitle());
        helper.setText(mailvo.getMessage(), true); // true: HTML 형식으로 전송
        
        mailSender.send(message);
    }

}