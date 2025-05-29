package www.silver.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import www.silver.dao.FileDAO;
import www.silver.vo.FileAttachVO;

@Service
public class FileServiceImpl implements FileService {
    
    @Autowired
    private FileDAO fileDAO;
    
    @Override
    public void insertFile(FileAttachVO attachVO) {
        fileDAO.insertFile(attachVO);
    }
    
    @Override
    public List<FileAttachVO> getFileList() {
        return fileDAO.selectFileList();
    }

	@Override
	public void insertFileAttach(FileAttachVO fileAttachVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public FileAttachVO getFileByMemberId(String memberId) {
		// TODO Auto-generated method stub
		 return fileDAO.selectFileByMemberId(memberId);
	}
}