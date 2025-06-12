package www.silver.service;

import java.util.List;

import www.silver.vo.BoardVO;
import www.silver.vo.CommentVO;
import www.silver.vo.PageVO;

public interface IF_writeService {

	public void addWrite(BoardVO boardvo);

	public List<BoardVO> boardAllView();

	public List<BoardVO> pagingList(int page);

	public PageVO pagingParam(int page);

	public BoardVO textview(Long postNum);
	
	public List<String> getAttach(Long postNum);

	public void deleteWrite(Long postNum);

	public void modifyWrite(BoardVO boardvo);
	
	public void viewCount(Long postNum);

	public void addCommentWrite(CommentVO commentvo);

	public List<CommentVO> getComments(Long postNum);

	public boolean deleteComment(int commentId, String userId);

	public boolean updateComment(int commentId, String content, Long postNum);

	public void addCommentReply(CommentVO commentVO);

	public boolean updateReply(int commentId, String content, Long postNum);

	

	

	
	
	


	

}
 