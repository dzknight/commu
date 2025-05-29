package www.silver.service;

import java.util.List;

import www.silver.vo.FileAttachVO;

public interface FileService {
		void insertFile(FileAttachVO attachVO);
	    List<FileAttachVO> getFileList();
	    
	    void insertFileAttach(FileAttachVO fileAttachVO);
	    FileAttachVO getFileByMemberId(String memberId);
}
