package www.silver.hom;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.silver.service.IF_signUpService;
import www.silver.vo.MemberVO;

@Controller
public class signUpController {

    @Inject
    IF_signUpService signupservice;
    
    // 파일 업로드 경로 설정
    //private static final String UPLOAD_PATH = "C:/upload/profile/";
    private static final String UPLOAD_PATH = "D:/community0604/src/main/webapp/resources/uploads/";
    // 회원가입 폼 표시
    @GetMapping("/signup")
    public String signUpMember(@ModelAttribute MemberVO membervo) {
        System.out.println("회원가입 페이지 진입");
        return "join/signup"; // WEB-INF/views/join/signup.jsp
    }

    // 회원가입 처리
    @PostMapping("/join")
    public String join( MemberVO membervo,  @RequestParam("userPasswordConfirm") String userPasswordConfirm, @RequestParam("fullEmail") String fullemail,RedirectAttributes redirectAttributes,  Model model) {
        System.out.println("Received MemberVO: " + membervo);
        System.out.println("Received userPasswordConfirm: " + userPasswordConfirm); 
        System.out.println(membervo.getDetailAddress()); 
        System.out.println(membervo.getFullEmail()); 

        // 서버 측 비밀번호 유효성 검사
        String userPassword = membervo.getUserPassword();
        // matches 메서드는 정규표현식의 패턴과 일치하는지 검사할 때 사용
        if (!userPassword.matches("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$")) {
            model.addAttribute("error", "비밀번호는 영문자, 숫자, 특수문자를 포함하여 8자 이상이어야 합니다.");
            return "join/signup"; // 회원가입 폼으로 이동
        }

        // 서버 측 비밀번호 일치 검사
        if (!userPassword.equals(userPasswordConfirm)) {
            model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
            return "join/signup"; // 회원가입 폼으로 이동
        }
        try {
            MultipartFile file = membervo.getProfileImageFile();
            if (file != null && !file.isEmpty()) {
                String savedFileName = saveProfileImage(file);
                membervo.setProfileImagePath(savedFileName);
            }
        } catch(Exception  e){
        	  redirectAttributes.addFlashAttribute("error", "프로필 이미지 처리 중 오류가 발생했습니다: " + e.getMessage());
        	  return "join/signup"; // WEB-INF/views/join/signup.jsp
        }
        // 회원가입 로직 수행
        signupservice.insert(membervo);
        return "redirect:/signup"; // 성공 시 리다이렉트
    }

    // 아이디 중복 확인
    @PostMapping("/userIdCheck")
    @ResponseBody
    public Map<String, Object> userIdCheck(@RequestParam String userId) {
        System.out.println("아이디 중복 확인 컨트롤러 진입");
        int count = signupservice.duplicateId(userId);
        Map<String, Object> checkId = new HashMap<>();
        checkId.put("count", count);
        return checkId;
    }

    // 비밀번호 유효성 검사
    @PostMapping("/checkPassword")
    @ResponseBody
    public Map<String, Boolean> checkPassword(@RequestParam("password") String password) {
        System.out.println("비밀번호 검사 컨트롤러 진입");

        // 비밀번호 유효성: 8자 이상, 영문자, 숫자, 특수문자 포함
        boolean isValid = password.matches("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$");

        Map<String, Boolean> checkPassword = new HashMap<>();
        checkPassword.put("valid", isValid);

        return checkPassword;
    }

    // 로그인 처리
    @PostMapping("/loginAccount")
    @ResponseBody
    public Map<String, Object> loginAccount(@RequestParam String userId, @RequestParam String userPassword,
                                            HttpSession session1,HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        MemberVO membervo = signupservice.loginUser(userId, userPassword);
        HttpSession session =request.getSession();// 세션 생성
        if (membervo != null) {
            session.setAttribute("loginUser", membervo);
            result.put("success", true);
            result.put("userId", membervo.getUserId()); // userId 포함
            session.setMaxInactiveInterval(60*30);// 세션 유효시간 30분
            System.out.println("로그인 성공: "+membervo.getUserId());
        } else {
            result.put("success", false);
            result.put("message", "아이디 또는 비밀번호가 잘못되었습니다.");
        }

        return result;
    }

    // 로그아웃 처리
    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes rttr) {
        System.out.println("로그아웃 진입");
        //session.removeAttribute("loginUser");
        session.invalidate(); // 세션 무효화
        return "/index";
    }
    //mypagecontroller에 중복 매핑
    @RequestMapping("/mypage")
	public String mypage( MemberVO membervo, HttpSession session) {
    	
		return "/mypage";
	}
    
	 // 파일 저장 메서드
    private String saveProfileImage(MultipartFile file) throws Exception {
        //String uploadPath = servletContext.getRealPath("/resources/upload/profile/");
        //File uploadDir = new File(uploadPath);
    	
        // 업로드 디렉토리 생성
        File uploadDir = new File(UPLOAD_PATH);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // 원본 파일명과 확장자 추출
        String originalFilename = file.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        // 고유한 파일명 생성 (UUID 사용)
        String savedFilename = UUID.randomUUID().toString() + extension;
        // 파일 저장
        File dest = new File(UPLOAD_PATH + savedFilename);
        file.transferTo(dest);
        
        return savedFilename;
    }
}
