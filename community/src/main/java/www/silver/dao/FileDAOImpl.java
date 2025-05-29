package www.silver.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import www.silver.vo.FileAttachVO;

@Repository
public class FileDAOImpl implements FileDAO {
    
    @Autowired
    private SqlSession sqlSession;
    
    @Override
    public void insertFile(FileAttachVO attachVO) {
        sqlSession.insert("fileMapper.insertFile", attachVO);
    }
    
    @Override
    public List<FileAttachVO> selectFileList() {
        return sqlSession.selectList("fileMapper.selectFileList");
    }

	@Override
	public FileAttachVO selectFileByMemberId(String memberId) {
		return sqlSession.selectOne("fileMapper.selectFileByMemberId", memberId);
	}
}