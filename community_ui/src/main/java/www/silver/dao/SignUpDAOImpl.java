package www.silver.dao;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import www.silver.vo.MemberVO;

@Repository
public class SignUpDAOImpl implements IF_signUpDAO {

    @Inject
    private SqlSession sqlSession;

    @Override
    public void insertAccount(MemberVO membervo) {
        System.out.println("회원가입 DAO insertAccount 메서드 진입");
        sqlSession.insert("www.silver.dao.IF_signUpDAO.insertone", membervo);
    }

    @Override
    public int duplicateCheckId(String userId) {
        System.out.println("아이디 중복체크 DAO duplicateCheckId 메서드 진입");
        return sqlSession.selectOne("www.silver.dao.IF_signUpDAO.duplicateCheckId", userId);
    }

    @Override
    public MemberVO loginUser(String userId, String userPassword) {
    	System.out.println("로그인 DAO 메서드 진입");
        Map<String, String> userInfo = new HashMap<>();
        userInfo.put("userId", userId);
        userInfo.put("userPassword", userPassword);
        return sqlSession.selectOne("www.silver.dao.IF_signUpDAO.userLogin", userInfo);
    }

	@Override
	public void updateMemberPass(MemberVO membervo) {
		// TODO Auto-generated method stub
		System.out.println("비밀번호 재설정 DAO 메서드 진입");
		sqlSession.update("www.silver.dao.IF_signUpDAO.updateMemberPass", membervo);
	}

	@Override
	public MemberVO getMemberById(String userid) {
		// TODO Auto-generated method stub
		System.out.println("개별유저조회 DAO 메서드 진입");
		  return sqlSession.selectOne("www.silver.dao.IF_signUpDAO.getMemberById", userid);
	}

	@Override
	public MemberVO selectByUserId(String userId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("www.silver.dao.IF_signUpDAO.selectByUserId", userId);
	}

	@Override
	public int updateMember(MemberVO memberVO) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("www.silver.dao.IF_signUpDAO.updateMember", memberVO);
	}

	@Override
	public void deleteMember(String userid) {
		// TODO Auto-generated method stub
		sqlSession.delete("www.silver.dao.IF_signUpDAO.deleteMember", userid);
	}
}
