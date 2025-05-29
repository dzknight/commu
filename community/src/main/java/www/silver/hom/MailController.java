package www.silver.hom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import www.silver.mail.MailService;
import www.silver.vo.MailVO;
//메일 전송을 트리거할 컨트롤러가 필요한 경우
@Controller
public class MailController {
    private final MailService mailService;
    
    @Autowired
    public MailController(MailService mailService) {
        this.mailService = mailService;
    }
    
    @GetMapping("/email")
    public String emailForm() {
    	return "/mail/form";
    }
    
    @PostMapping("/sendmail")
    @ResponseBody
    public String sendMail(@RequestParam(value="address" ) String address,@RequestParam(value="title") String title,@RequestParam(value="message") String message) {
        try {
           MailVO mailvo=new MailVO();
           mailvo.setFromaddress("dzknight11@naver.com" );
           mailvo.setAddress(address);
           mailvo.setTitle(title);
           mailvo.setMessage(message);
           mailService.mailSend(mailvo);
            return "메일 전송 성공";
        } catch (Exception e) {
            return "메일 전송 실패: " + e.getMessage();
        }
    }
}