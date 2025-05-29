package www.silver.hom;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.TypeMismatchException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.silver.service.IF_memberService;
import www.silver.util.FileDataUtil;
import www.silver.util.PassportPhotoValidator;
import www.silver.vo.MemberVO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;




@Controller
public class MemberController {
   // private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);
//	@ControllerAdvice
//	public class GlobalExceptionHandler {
//	    
//	    @ExceptionHandler(BindException.class)
//	    public String handleBindException(BindException e, RedirectAttributes rttr) {
//	        log.error("Binding error: ", e);
//	        rttr.addFlashAttribute("error", "입력 데이터에 오류가 있습니다. 다시 확인해주세요.");
//	        return "/member/memberjoinF";
//	    }
//	    
//	    @ExceptionHandler(TypeMismatchException.class)
//	    public String handleTypeMismatchException(TypeMismatchException e, RedirectAttributes rttr) {
//	        log.error("Type mismatch error: ", e);
//	        rttr.addFlashAttribute("error", "파일 업로드 형식이 올바르지 않습니다.");
//	        return "/member/memberjoinF";
//	    }
//	}
	
	
	@Inject
	IF_memberService memberservice;
	
	
    // 파일 업로드 경로 설정
    private static final String UPLOAD_PATH = "C:/upload/profile/";
    
	@Autowired
    private PassportPhotoValidator photoValidator;
	
	@Autowired
    private ServletContext servletContext;
	
	@Inject
	FileDataUtil filedatautil;
	
    @RequestMapping(value = "/validatePhoto", method = RequestMethod.POST)
    public String validatePhotoPage(@RequestParam("photo") MultipartFile photo, Model model) {
        try {
            PassportPhotoValidator.ValidationResult validation = photoValidator.validatePassportPhoto(photo);
           
            model.addAttribute("validation", validation);
            model.addAttribute("fileName", photo.getOriginalFilename());
            model.addAttribute("fileSize", photo.getSize());
            
            return "/common/validatePhoto"; // validatePhoto.jsp 반환
            
        } catch (Exception e) {
            model.addAttribute("error", "파일 검증 중 오류가 발생했습니다.");
            return "/common/validatePhoto";
        }
    }
    
	@RequestMapping(value = "/memberjoind", method = RequestMethod.POST)
	public String memberjoind( MemberVO membervo, RedirectAttributes rttr) throws Exception {  
		System.out.println(membervo.getUserid()+"/"+membervo.getUsername());	
		System.out.println(membervo.getAddress()+"/"+membervo.getDetailAddress());	
		System.out.println(membervo.getFullEmail());	
		System.out.println(membervo.getFullPhoneNumber());	
		System.out.println(membervo.getProfileImage());	
		//String [] filename=filedatautil.fileUpload(file);
		//System.out.println(filename[0]);
//		for(int i=0;i<file.length;i++) {
//			System.out.println(file[i].getOriginalFilename());
//			System.out.println(file[i].getSize());
//			System.out.println(file[i].getContentType());
//		}
    
//            // 프로필 사진이 업로드된 경우
//            if (!profileImage.isEmpty()) {
//                // 여권 규격 검증
//                PassportPhotoValidator.ValidationResult validation = 
//                photoValidator.validatePassportPhoto(profileImage);
//                
//                if (!validation.isValid()) {
//                    rttr.addFlashAttribute("error", validation.getMessage());
//                    return "redirect:/member/join";
//                }
//                
//                // 경고 메시지가 있는 경우
//                if (validation.getWarning() != null) {
//                    rttr.addFlashAttribute("warning", validation.getWarning());
//                }
//                
//                // 파일 저장
//                String savedFileName = saveProfileImage(profileImage);
//                System.out.println(savedFileName);
//                membervo.setProfileImage(savedFileName);
//            } else {
//            	membervo.setProfileImage("default_profile.jpg");
//            }
           try {
        	// 프로필 이미지 처리
               MultipartFile file = membervo.getProfileImageFile();
               if (file != null && !file.isEmpty()) {
                   String savedFileName = saveProfileImage(file);
                   membervo.setProfileImagePath(savedFileName);
               }
           } catch(Exception  e){
        	   
           }
           
  

		memberservice.addUser(membervo);
		rttr.addFlashAttribute("message", "회원가입이 완료되었습니다.");
		return "redirect:/memberjoin";
		//return "redirect:/memberjoin";
	}
	
	@RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
	public String passresetd( MemberVO membervo,@RequestParam("password") String password, RedirectAttributes rttr) throws Exception {  
		System.out.println(membervo.getUserid());	
		System.out.println(membervo.getPassword());	
//		System.out.println(membervo.getAddress()+"/"+membervo.getDetailAddress());	
//		System.out.println(membervo.getFullEmail());	
//		System.out.println(membervo.getFullPhoneNumber());	
//		System.out.println(membervo.getProfileImage());	
		

		memberservice.updateMemberPass(membervo);
		//memberservice.addUser(membervo);
		System.out.println("비밀번호 수정이 완료되었습니다");
		return "redirect:/memberjoin";
	
	}
	
	@RequestMapping(value = "/memberjoin", method = RequestMethod.GET)
	public String memberjoin() {
		
		return "/member/memberjoinF";
	}
	
	@RequestMapping(value = "/passreset", method = RequestMethod.GET)
	public String passreset(HttpSession session, Model model) {
		String loginUserId=(String) session.getAttribute("id");
		model.addAttribute("userid", loginUserId);
		return "/member/passresetF";
	}
	
	@RequestMapping(value = "/membermod", method = RequestMethod.GET)
	public String membermod() {
		
		return "/member/membermodF";
	}
	
//    @RequestMapping(value = "/detail/{memberId}", method = RequestMethod.GET)
//    public String memberDetail(@PathVariable String memberId, Model model) {
//        MemberVO member = memberservice.getMemberById(memberId);
//        model.addAttribute("member", member);
//        return "member/memberdetailf";
//    }
    
 // 회원 목록 조회
    @GetMapping("/list")
    public String memberList(Model model) {
        List<MemberVO> memberList = memberservice.getAllMembers();
        model.addAttribute("memberList", memberList);
        return "member/memberList";
    }
    
    // 회원 상세정보 조회
    @GetMapping("/detail/{userid}")
    public String memberDetail(@PathVariable String userid, Model model) {
        System.out.println("요청된 memberId: " + userid);
        MemberVO member = memberservice.getMemberById(userid);
        System.out.println("조회된 member: " + member);
        if (member == null) {
            return "redirect:/member/list";
        }
        model.addAttribute("member", member);
        return "member/memberDetail";
    }
    

	
//	@GetMapping("/allMember")
//	public String allMember(Model model) {
//		List<MemberVO> mList = memberservice.allMember();
//		System.out.println(mList.size()+"명 가져옴");
//		model.addAttribute("memberList", mList);
//		return "member/list";
//	}
//	@GetMapping("/view")
//	public String view(@RequestParam("id") String id, Model model) {
//		MemberVO mvo = memberservice.viewDetail(id);
//		model.addAttribute("memberOne", mvo);
//		List<String> attachList=memberservice.getAttach(id);
//		
//		return "member/viewMember";
//	}
	
	@RequestMapping(value = "/duplexid", method = RequestMethod.GET)
	@ResponseBody
	public String duplexid(@RequestParam("id") String id) { 
		//System.out.println(id+"ddd");
		MemberVO m=memberservice.viewUser(id);
		String rev_id=null;
		if(m==null) {
			rev_id=id;
		} else {
			rev_id="";
		}
		return rev_id;
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

