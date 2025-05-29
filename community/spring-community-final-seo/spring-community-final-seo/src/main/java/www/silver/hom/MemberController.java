package www.silver.hom;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import www.silver.service.IF_memberService;
import www.silver.util.FileDataUtil;
import www.silver.vo.MemberVO;

@Controller
public class MemberController {
	@Inject
	IF_memberService memberservice;
	
	@Inject
	FileDataUtil filedatautil;
	 
	@RequestMapping(value = "/memberjoind", method = RequestMethod.POST)
	public String memberjoind(@ModelAttribute MemberVO membervo,MultipartFile[] file) throws IOException {  
		System.out.println(membervo.getUserid()+"/"+membervo.getUsername());	
		System.out.println(membervo.getAddress()+"/"+membervo.getDetailAddress());	
		System.out.println(membervo.getFullEmail());	
		System.out.println(membervo.getFullPhoneNumber());	
		//String [] filename=filedatautil.fileUpload(file);
		//System.out.println(filename[0]);
//		for(int i=0;i<file.length;i++) {
//			System.out.println(file[i].getOriginalFilename());
//			System.out.println(file[i].getSize());
//			System.out.println(file[i].getContentType());
//		}
	
		//membervo.setFilename(filename);
		memberservice.addUser(membervo);
		return "/member/memberjoinF";
		//return "redirect:/memberjoin";
	}
	
	@RequestMapping(value = "/memberjoin", method = RequestMethod.GET)
	public String memberjoin() {
		
		return "/member/memberjoinF";
	}	
	@RequestMapping(value = "/membermod", method = RequestMethod.GET)
	public String membermod() {
		
		return "/member/membermodF";
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
		System.out.println(id+"ddd");
		MemberVO m=memberservice.viewUser(id);
		String rev_id=null;
		if(m==null) {
			rev_id=id;
		} else {
			rev_id="";
		}
		return rev_id;
	}

}
