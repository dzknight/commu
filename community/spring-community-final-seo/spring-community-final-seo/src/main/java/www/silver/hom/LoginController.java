package www.silver.hom;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.silver.vo.MemberVO;
import www.silver.service.IF_memberService;

@Controller
public class LoginController {
	
	@Inject
	IF_memberService memberservice;
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String logins(@RequestParam("id") String id, @RequestParam("password") String password, HttpServletRequest request,RedirectAttributes rttr, Model model) {
		MemberVO mvo=memberservice.viewDetail(id);// 아이디로 회원정보를 가져옴
		System.out.println("아이디: "+mvo.getUserid());
		System.out.println("비밀번호: "+mvo.getPassword());
		System.out.println("이름: "+mvo.getUsername());
		System.out.println("전화번호: "+mvo.getFullPhoneNumber());
		
		if(mvo!=null) {// 아이디가 존재하는 경우
			if(password.equals(mvo.getPassword())) {// 비밀번호가 일치하는 경우
				HttpSession session =request.getSession();// 세션 생성
				
					session.removeAttribute("id");// 세션에 id가 있으면 삭제
					//session.invalidate();// 세션 무효화
					session = request.getSession();// 새로운 세션 생성
					session.setAttribute("id", id);// 세션에 id 저장
					session.setMaxInactiveInterval(60*60);// 세션 유효시간 1시간
			
					System.out.println("로그인 성공: "+id);
				
			} else {
				System.out.println("비밀번호가 일치하지 않습니다");
			}
		}
		return "redirect:/";// 메인 페이지로 리다이렉트
	}
    // 로그아웃 처리
    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes rttr) {
        session.invalidate(); // 세션 무효화
        rttr.addFlashAttribute("msg", "로그아웃되었습니다.");// 아이디가 존재하지 않는 경우
        return "redirect:/"; // 메인 페이지로 리다이렉트

    }
}