package www.silver.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import www.silver.dao.IF_MemberDAO;
import www.silver.vo.MemberVO;

@Service  
public class MemberServiceImpl implements IF_memberService{
	@Inject
	private IF_MemberDAO memberdao;
	


	@Override
	public void addUser(MemberVO membervo) {
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



}
