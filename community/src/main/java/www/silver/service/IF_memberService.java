package www.silver.service;
import java.util.List;

import www.silver.vo.MemberVO;

public interface IF_memberService {	
	
	void insertMember(MemberVO membervo);
	public void addUser(MemberVO membervo);	
	public MemberVO viewUser(String id);
	public MemberVO viewDetail(String id);
	public List<MemberVO> getAllMembers();
	List<MemberVO> selectAllMembers();
    MemberVO selectMemberById(String userId);
    MemberVO getMemberById(String Id);
    void deleteMember(String id);
    void updateMember(MemberVO membervo);

	void updateMemberPass(MemberVO membervo);

}
