package www.silver.dao;

import java.util.List;
import java.util.Map;
import www.silver.vo.BoardVO;
import www.silver.vo.CommentVO;

public interface IF_writeDAO {

    // 새로운 게시글을 데이터베이스에 삽입
    public void insertWrite(BoardVO boardvo);

    // 게시글에 첨부된 파일명을 데이터베이스에 저장
    public void attachFname(Map<String, Object> params);

    // 모든 게시글 목록을 조회
    public List<BoardVO> selectall();

    // 페이징 처리를 통해 특정 범위의 게시글 목록을 조회
    public List<BoardVO> pagingList(Map<String, Integer> pagingParams);

    // 전체 게시글 수를 반환 (페이징 계산용)
    public int boardCount();

    // 특정 게시글 번호에 해당하는 게시글 상세 정보를 조회
    public BoardVO selectOne(Long postNum);

    // 특정 게시글에 첨부된 파일 목록을 조회
    public List<String> getAttach(Long postNum);

    // 특정 게시글을 삭제
    public void deleteWrite(Long postNum);

    // 특정 게시글의 내용을 수정
    public void modifyWrite(BoardVO boardVO);

    // 특정 게시글에 첨부된 파일을 삭제
    public void deleteAttach(Long postNum);
    
    // 특정 게시글의 조회수를 증가
    public void viewCount(Long postNum);

    // 새로운 댓글을 데이터베이스에 삽입
    public void insertCommentWrite(CommentVO commentvo);

    // 특정 게시글에 달린 모든 댓글 목록을 조회
    public List<CommentVO> selectAllComment(Long postNum);

    // 특정 댓글을 삭제 (작성자 확인 후 삭제 여부 반환)
    public boolean deleteComment(int commentId, String userId);

    // 특정 댓글의 내용을 수정 (수정 성공 여부 반환)
    public boolean updateComment(int commentId, String content, Long postNum);

    // 특정 댓글 ID에 해당하는 댓글 정보를 조회 (대댓글 작성 시 부모 댓글 정보 확인용)
    public CommentVO getCommentById(int parentCommentId);

    // 대댓글을 데이터베이스에 추가
    public void addCommentReply(CommentVO commentvo);

	
}
