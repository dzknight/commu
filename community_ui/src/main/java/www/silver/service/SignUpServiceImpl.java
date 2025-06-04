package www.silver.service;

import java.io.File;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import www.silver.dao.IF_signUpDAO;
import www.silver.vo.MemberVO;

@Service
public class SignUpServiceImpl implements IF_signUpService {

    @Inject
    IF_signUpDAO signupdao;

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
	public boolean validateOldPassword(String userid, String oldPassword)  {
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
}
