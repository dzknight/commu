package www.silver.service;

import javax.mail.MessagingException;

import org.springframework.web.multipart.MultipartFile;

import www.silver.vo.MemberVO;

public interface IF_signUpService {
	public void insert(MemberVO membervo);

	public int duplicateId(String userId);

	public boolean isValidPassword(String password);
	
	// 기존 비밀번호 검증
	public boolean validateOldPassword(String userid, String oldPassword);
	
	public MemberVO loginUser(String userId, String userPassword); 
	
	public void updateMemberPass(MemberVO membervo);
	
	public MemberVO getMemberById(String userId) throws Exception;
	
	public int updateMember(MemberVO memberVO) throws Exception;
	
	public String uploadFile(MultipartFile file, String uploadPath) throws Exception;
	
	void deleteMember(String userid);
	
	public void sendEmailVerification(String fullEmail) throws MessagingException, Exception;
	 
	public void registerMember(MemberVO membervo, String certificationNumber) throws Exception;
	
}
