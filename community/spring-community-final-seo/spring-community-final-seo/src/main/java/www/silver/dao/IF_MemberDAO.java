package www.silver.dao;

import java.util.List;

import www.silver.vo.MemberVO;


public interface IF_MemberDAO {
	
	
	// 회원 정보를 데이터베이스에 저장하며, SqlSessionTemplate을 호출합니다.
	// 추가적인 예외 처리가 필요할 수 있습니다.
	public void insertMember(MemberVO mvo);
	
	public MemberVO selectOne(String id);


}
