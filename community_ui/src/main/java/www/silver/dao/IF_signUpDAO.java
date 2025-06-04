package www.silver.dao;

import www.silver.vo.MemberVO;

public interface IF_signUpDAO {
	public void insertAccount(MemberVO membervo);

	public int duplicateCheckId(String userId);

	public MemberVO loginUser(String userId, String userPassword);

	public void updateMemberPass(MemberVO membervo);

	public MemberVO getMemberById(String userid);

	public MemberVO selectByUserId(String userId) throws Exception;
	
    public int updateMember(MemberVO memberVO) throws Exception;
    public void deleteMember(String userid);
}
