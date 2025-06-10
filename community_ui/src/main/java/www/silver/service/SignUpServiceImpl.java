package www.silver.service;

import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.FileImageOutputStream;
import javax.inject.Inject;
import javax.mail.MessagingException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import www.silver.dao.IF_signUpDAO;
import www.silver.mail.EmailService;
import www.silver.vo.MemberVO;

@Service
public class SignUpServiceImpl implements IF_signUpService {

	@Inject
	IF_signUpDAO signupdao;

	private EmailService emailservice;
	@Override
	@Transactional
	public void insert(MemberVO membervo) {
		signupdao.insertAccount(membervo);
	}

	@Override
	public int duplicateId(String userId) {
		return signupdao.duplicateCheckId(userId);
	}

	@Override
	public boolean isValidPassword(String password) {
		// 비밀번호 유효성: 8자 이상, 영문자, 숫자, 특수문자 포함
		return password.matches("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$");
	}

	@Override
	public MemberVO loginUser(String userId, String userPassword) {
		return signupdao.loginUser(userId, userPassword);
	}

	@Override
	public void updateMemberPass(MemberVO membervo) {
		// TODO Auto-generated method stub
		signupdao.updateMemberPass(membervo);
	}

	// 기존 비밀번호 검증
	@Override
	public boolean validateOldPassword(String userid, String oldPassword) {
		// TODO Auto-generated method stub
		// DB에서 사용자 정보 조회
		MemberVO member = signupdao.getMemberById(userid);
		if (member == null) {
			return false;
		}

		return oldPassword.equals(member.getUserPassword());
	}

	@Override
	public MemberVO getMemberById(String userId) throws Exception {
		// TODO Auto-generated method stub
		return signupdao.selectByUserId(userId);
	}

	@Override
	public int updateMember(MemberVO memberVO) throws Exception {
		return signupdao.updateMember(memberVO);

	}

	@Override
	public String uploadFile(MultipartFile file, String uploadPath) throws Exception {
		// 서버 측 추가 검증
		
		
		String originalName = file.getOriginalFilename();
		String extension = originalName.substring(originalName.lastIndexOf("."));
		String savedName = UUID.randomUUID().toString() + extension;

		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}

		File savedFile = new File(uploadPath, savedName);
		file.transferTo(savedFile);
		
		return savedName;
	}

	@Override
	public void deleteMember(String userid) {
		// TODO Auto-generated method stub
		signupdao.deleteMember(userid);
	}

	@Override
	public void sendEmailVerification(String fullEmail) throws Exception {
		// TODO Auto-generated method stub
		  // 이메일 중복 체크
       // if (signupdao.checkEmailDuplicate(fullEmail) > 0) {
       //     throw new RuntimeException("이미 가입된 이메일입니다.");
       // }
        //인증번호 이메일 전송 리턴 없음
        emailservice.sendAuthEmail(fullEmail);
	}

	//인증번호 검증
	public boolean verifyEmailCode(String email,String code) throws Exception{
		return emailservice.verifyAuthCode(email, code);
	}
	
	@Override
	public void registerMember(MemberVO membervo, String certificationNumber) throws Exception {
		// TODO Auto-generated method stub
		// 이메일 인증 여부 확인
        if (!emailservice.isEmailVerified(membervo.getUserEmail())) {
            throw new Exception("이메일 인증이 완료되지 않았습니다.");
        }
        
        // 최종 이메일 중복 확인
        if (signupdao.checkEmailDuplicate(membervo.getUserEmail()) > 0) {
            throw new Exception("이미 사용 중인 이메일입니다.");
        }
		signupdao.insertAccount(membervo);
	}

	  


}
