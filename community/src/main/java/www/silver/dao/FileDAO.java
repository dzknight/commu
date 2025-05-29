package www.silver.dao;

import java.util.List;


import www.silver.vo.FileAttachVO;

public interface FileDAO {
    void insertFile(FileAttachVO attachVO);
    List<FileAttachVO> selectFileList();
    FileAttachVO selectFileByMemberId(String memberId);
}