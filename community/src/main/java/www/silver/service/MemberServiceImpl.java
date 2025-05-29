package www.silver.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import www.silver.dao.IF_MemberDAO;
import www.silver.vo.MemberVO;

@Service  
public class MemberServiceImpl implements IF_memberService{
	@Inject
	private IF_MemberDAO memberdao;
	


	//insertmember
	@Override
	public void addUser(MemberVO membervo) {
		// TODO Auto-generated method stub
		memberdao.insertMember(membervo);
	}
	@Override
	public void insertMember(MemberVO membervo) {
		// TODO Auto-generated method stub
		memberdao.insertMember(membervo);
	}


	@Override
	@Transactional(readOnly = true)
	public MemberVO viewUser(String id) {
		// TODO Auto-generated method stub
		MemberVO m=memberdao.selectOne(id);
		return m;
	}

	@Override
	public MemberVO viewDetail(String id) {
		// TODO Auto-generated method stub
		MemberVO m = memberdao.selectOne(id);
		return m;
	}


	@Override
	public MemberVO getMemberById(String id) {
		// TODO Auto-generated method stub
		MemberVO m=memberdao.selectMemberById(id);
		return m;
	}
	@Override
	public MemberVO selectMemberById(String userid) {
		// TODO Auto-generated method stub
		MemberVO m=memberdao.selectMemberById(userid);
		return m;
	}


	@Override
	public List<MemberVO> getAllMembers() {
		// TODO Auto-generated method stub
		return memberdao.selectAllMembers();
	}

	@Override
	public List<MemberVO> selectAllMembers() {
		// TODO Auto-generated method stub
		return memberdao.selectAllMembers();
	}


	@Override
	public void updateMember(MemberVO memberVO) {
		// TODO Auto-generated method stub
		memberdao.updateMember(memberVO);
	}

	@Override
	public void deleteMember(String id) {
		// TODO Auto-generated method stub
		memberdao.deleteMember(id);
	}

	@Override
	public void updateMemberPass(MemberVO memberVO) {
		// TODO Auto-generated method stub
		memberdao.updateMemberPass(memberVO);
	}



}
