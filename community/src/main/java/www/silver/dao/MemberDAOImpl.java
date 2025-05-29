package www.silver.dao;



import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import www.silver.vo.MemberVO;


@Repository  
public class MemberDAOImpl implements IF_MemberDAO{
	@Inject
	private SqlSession sqlSession;
	@Override
	public void insertMember(MemberVO mvo) {
		// TODO Auto-generated method stub
		sqlSession.insert("www.silver.dao.IF_MemberDAO.insertOne", mvo);
	}
	@Override
	public MemberVO selectOne(String id) {
		// TODO Auto-generated method stub
		//25년 5월22일 마이바티스 3.5.7 라이브러리 버전 변경 과정에서 오류가 발생하여 (memberVO) 추가
		MemberVO m= sqlSession.selectOne("www.silver.dao.IF_MemberDAO.selectOne",id);
		//MemberVO m= sqlSession.selectOne("www.silver.dao.IF_MemberDAO.selectOne",id);
		return m;
	}
	@Override
	public MemberVO selectMemberById(String id) {
		// TODO Auto-generated method stub
		MemberVO m=sqlSession.selectOne("www.silver.dao.IF_MemberDAO.selectMemberById", id);
		return m;
	}
	@Override
	public List<MemberVO> selectAllMembers() {
		// TODO Auto-generated method stub
		List<MemberVO> memberList = sqlSession.selectList("www.silver.dao.IF_MemberDAO.selectAllMembers");
		return memberList;
	}
	@Override
	public void updateMember(MemberVO memberVO) {
		// TODO Auto-generated method stub
		sqlSession.update("www.silver.dao.IF_MemberDAO.updateMember", memberVO);
	}
	@Override
	public void deleteMember(String id) {
		// TODO Auto-generated method stub
		sqlSession.delete("www.silver.dao.IF_MemberDAO.deleteMember", id);
	}
	@Override
	public void updateMemberPass(MemberVO membervo) {
		// TODO Auto-generated method stub
		sqlSession.update("www.silver.dao.IF_MemberDAO.updateMemberPass", membervo);
	}




}
