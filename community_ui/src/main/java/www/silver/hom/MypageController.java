package www.silver.hom;

import java.io.File;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.expression.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.silver.service.IF_signUpService;
import www.silver.vo.MemberVO;

@Controller
public class MypageController {

	@Inject
	IF_signUpService memberservice;
	
	@RequestMapping(value = "/resetPassword", method = {RequestMethod.POST })
	public String passresetd( MemberVO membervo, @RequestParam("oldPassword") String oldPassword,@RequestParam("password") String userpassword,@RequestParam("userid") String userid,  RedirectAttributes rttr) throws Exception {  

		//System.out.println(membervo.getAddress()+"/"+membervo.getDetailAddress());	
		//System.out.println(membervo.getFullEmail());	
		//System.out.println(membervo.getFullPhoneNumber());	
		//System.out.println(membervo.getProfileImage());	
		membervo.setUserId(userid);
		membervo.setUserPassword(userpassword);
		
		if(userid == null || userid.trim().isEmpty()) {
			System.out.println("사용자 아이디가 비어있습니다");
			return "redirect:/passreset";
		}
		if (userpassword == null || userpassword.length() < 8) {
            rttr.addFlashAttribute("error", "비밀번호는 8자 이상이어야 합니다.");
            return "redirect:/passreset";
        }
		
		// 2. 기존 비밀번호 검증
        boolean isOldPasswordValid = memberservice.validateOldPassword(userid, oldPassword);
        if (!isOldPasswordValid) {
            //rttr.addFlashAttribute("error", "기존 비밀번호가 올바르지 않습니다.");
            System.out.println("기존비번이 올바르지 않습니다");
            return "redirect:/passreset";
        }
        
		memberservice.updateMemberPass(membervo);
		//memberservice.addUser(membervo);
		System.out.println("비밀번호 수정이 완료되었습니다");
		return "redirect:/";
	
	}
	
	@RequestMapping(value = "/memberdel", method = RequestMethod.GET)
	public String delmember(HttpSession session, Model model) {
		
		MemberVO loginUser=(MemberVO) session.getAttribute("loginUser");
		MemberVO latestMember;
		try {
			latestMember = memberservice.getMemberById(loginUser.getUserId());
			
			model.addAttribute("member", latestMember);
			System.out.println(latestMember.getUserId()+"를 삭제합니다");
			memberservice.deleteMember(latestMember.getUserId());
			
			session.invalidate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/passreset", method = RequestMethod.GET)
	public String passreset(HttpSession session, Model model) {
		//String loginUserId=(String) session.getAttribute("userId");
		//model.addAttribute("userid", loginUserId);
		return "/member/passresetF";
	}
	
	@RequestMapping(value = "/membermod", method = RequestMethod.GET)
	@GetMapping("/member/membermodF")
	public String membermod(HttpSession session, Model model) {
		MemberVO loginUser=(MemberVO) session.getAttribute("loginUser");
		if (loginUser == null) {
            return "redirect:/";
        }
		
        // DB에서 최신 정보 조회 (선택사항)
		try {
			MemberVO latestMember = memberservice.getMemberById(loginUser.getUserId());
			
			model.addAttribute("member", latestMember);
			//System.out.println(latestMember.getAddress()); 
		
			//System.out.println(latestMember.getUserPhoneNum()); 
			
			//System.out.println(loginUser.getUserId()); 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/member/membermodF";
	}
	
	@PostMapping("/member/membermodF")
	public String membermodProcess(
	        @RequestParam("userName") String userName,
	        @RequestParam("userEmail") String userEmail,
	        @RequestParam("userPhoneNum") String userPhoneNum,
	        @RequestParam(value = "birthdate", required = false) String birthdate,
	        @RequestParam(value = "zipCode", required = false) String zipCode,
	        @RequestParam(value = "address", required = false) String address,
	        @RequestParam(value = "detailAddress", required = false) String detailAddress,
	        @RequestParam(value = "profileImage", required = false) MultipartFile profileImage,
	        HttpSession session,
	        RedirectAttributes redirectAttributes) {
	    
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "redirect:/";
	    }
	    
	    try {
	        // 수정할 회원 정보 객체 생성
	        MemberVO updateMember = new MemberVO();
	        updateMember.setUserId(loginUser.getUserId());
	        updateMember.setUserName(userName);
	        updateMember.setUserEmail(userEmail);
	        updateMember.setUserPhoneNum(userPhoneNum);
	        updateMember.setZipCode(zipCode);
	        updateMember.setAddress(address);
	        updateMember.setDetailAddress(detailAddress);
	        
	        // 생년월일 처리
	        if (birthdate != null && !birthdate.isEmpty()) {
	            	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	           
	                java.util.Date birth = sdf.parse(birthdate);
	                java.sql.Date sqlBirth=new java.sql.Date(birth.getDate());
	                updateMember.setBirthdate(birth);// VO가 java.util.Date를 사용하는 경우
	                // 또는 java.sql.Date가 필요한 경우
	                // java.sql.Date sqlBirth = new java.sql.Date(birth.getTime());
	                // updateMember.setBirthdate(sqlBirth);
	               
	            
	        }
	        
	        // 프로필 이미지 처리
	        if (profileImage != null && !profileImage.isEmpty()) {
	            String uploadPath = session.getServletContext().getRealPath("/resources/uploads/");
	            File uploadDir = new File(uploadPath);
	            if (!uploadDir.exists()) {
	                uploadDir.mkdirs();
	            }
	            
	            // 파일명 생성 (중복 방지를 위해 시간 추가)
	            String originalFileName = profileImage.getOriginalFilename();
	            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
	            String savedFileName = loginUser.getUserId() + "_" + System.currentTimeMillis() + fileExtension;
	            
	            // 파일 저장
	            File saveFile = new File(uploadPath + savedFileName);
	            profileImage.transferTo(saveFile);
	            
	            // 기존 프로필 이미지 삭제 (기본 이미지가 아닌 경우)
//	            MemberVO currentMember = memberservice.getMemberById(loginUser.getUserId());
//	            if (currentMember.getProfile_img() != null && 
//	                !currentMember.getProfile_img().equals("default.jpg")) {
//	                File oldFile = new File(uploadPath + currentMember.getProfile_img());
//	                if (oldFile.exists()) {
//	                    oldFile.delete();
//	                }
//	            }
	            
	            updateMember.setProfile_img(savedFileName);
	        }
	        
	        // 회원 정보 업데이트
	        int result = memberservice.updateMember(updateMember);
	        
	        if (result > 0) {
	            // 세션의 로그인 정보도 업데이트
	            MemberVO updatedMember = memberservice.getMemberById(loginUser.getUserId());
	            session.setAttribute("loginUser", updatedMember);
	            
	            redirectAttributes.addFlashAttribute("successMessage", "회원 정보가 성공적으로 수정되었습니다.");
	            return "redirect:/";
	        } else {
	            redirectAttributes.addFlashAttribute("errorMessage", "회원 정보 수정에 실패했습니다.");
	            return "redirect:/membermod";
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        redirectAttributes.addFlashAttribute("errorMessage", "회원 정보 수정 중 오류가 발생했습니다.");
	        return "redirect:/membermod";
	    }
	}
	
	//특정 회원의 정보 조회
	@RequestMapping(value = "/memberview", method = RequestMethod.GET)
	public String memberview(HttpSession session, Model model) {

		MemberVO loginUser=(MemberVO) session.getAttribute("loginUser");
		if (loginUser == null) {
            return "redirect:/";
        }
		
        // DB에서 최신 정보 조회 (선택사항)
		try {
			MemberVO latestMember = memberservice.getMemberById(loginUser.getUserId());
			
			model.addAttribute("member", latestMember);
			//System.out.println(latestMember.getAddress()); 
		
			//System.out.println(latestMember.getUserPhoneNum()); 
			
			//System.out.println(loginUser.getUserId()); 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//model.addAttribute("member", loginUser);
		return "/member/memberviewF";
	}
	
}
