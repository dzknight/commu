package www.silver.service;
import java.util.List;

import www.silver.vo.MemberVO;

public interface IF_memberService {	
	
	public void addUser(MemberVO membervo);	
	public MemberVO viewUser(String id);
	public MemberVO viewDetail(String id);
}
