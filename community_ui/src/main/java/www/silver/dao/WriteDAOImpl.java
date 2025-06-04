package www.silver.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import www.silver.vo.BoardVO;
import www.silver.vo.CommentVO;

@Repository // Spring에서 이 클래스를 데이터 접근 계층(DAO) 빈으로 등록
public class WriteDAOImpl implements IF_writeDAO {

	@Inject // Spring의 의존성 주입을 통해 SqlSession 객체를 자동으로 주입
	SqlSession sqlSession;

	@Override
	public void insertWrite(BoardVO boardvo) {
		// MyBatis의 insert 메서드를 호출하여 새로운 게시글을 데이터베이스에 삽입
		sqlSession.insert("www.silver.dao.IF_writeDAO.insertone", boardvo);
	}

	@Override
	public void attachFname(Map<String, Object> params) {
		// MyBatis의 insert 메서드를 호출하여 게시글에 첨부된 파일 정보를 데이터베이스에 저장
		sqlSession.insert("www.silver.dao.IF_writeDAO.board_attach", params);
	}

	@Override
	public List<BoardVO> selectall() {
		// MyBatis의 selectList 메서드를 호출하여 모든 게시글 목록을 조회
		List<BoardVO> clist = sqlSession.selectList("www.silver.dao.IF_writeDAO.selectall");
		return clist;
	}

	@Override
	public List<BoardVO> pagingList(Map<String, Integer> pagingParams) {
		// MyBatis의 selectList 메서드를 호출하여 페이징 처리된 게시글 목록을 조회
		return sqlSession.selectList("www.silver.dao.IF_writeDAO.pagingList", pagingParams);
	}

	@Override
	public int boardCount() {
		// MyBatis의 selectOne 메서드를 호출하여 전체 게시글 수를 반환 (페이징 계산용)
		int count = sqlSession.selectOne("www.silver.dao.IF_writeDAO.boardCount");
		System.out.println("DAO: 게시글 수 = " + count); // 게시글 수 로그 출력
		return count;
	}

	@Override
	public BoardVO selectOne(Long postNum) {
		// MyBatis의 selectOne 메서드를 호출하여 특정 게시글의 상세 정보를 조회
		BoardVO boardvo = sqlSession.selectOne("www.silver.dao.IF_writeDAO.selectOne", postNum);
		return boardvo;
	}

	@Override
	public List<String> getAttach(Long postNum) {
		// MyBatis의 selectList 메서드를 호출하여 특정 게시글에 첨부된 파일 목록을 조회
		return sqlSession.selectList("www.silver.dao.IF_writeDAO.getAttach", postNum);
	}

	@Override
	public void deleteWrite(Long postNum) {
		// MyBatis의 delete 메서드를 호출하여 특정 게시글을 데이터베이스에서 삭제
		sqlSession.delete("www.silver.dao.IF_writeDAO.deleteone", postNum);
	}

	@Override
	public void modifyWrite(BoardVO boardvo) {
		// MyBatis의 update 메서드를 호출하여 특정 게시글의 내용을 수정
		sqlSession.update("www.silver.dao.IF_writeDAO.modifyone", boardvo);
	}

	@Override
	public void deleteAttach(Long postNum) {
		// MyBatis의 delete 메서드를 호출하여 특정 게시글에 첨부된 파일을 삭제
		sqlSession.delete("www.silver.dao.IF_writeDAO.deleteAttach", postNum);
	}

	@Override
	public void viewCount(Long postNum) {
		// MyBatis의 update 메서드를 호출하여 특정 게시글의 조회수를 증가
		sqlSession.update("www.silver.dao.IF_writeDAO.viewCount", postNum);
	}

	@Override
	public void insertCommentWrite(CommentVO commentvo) {
		// MyBatis의 insert 메서드를 호출하여 새로운 댓글을 데이터베이스에 삽입
		sqlSession.insert("www.silver.dao.IF_writeDAO.insertComment", commentvo);
	}

	@Override
	public List<CommentVO> selectAllComment(Long postNum) {
		// MyBatis의 selectList 메서드를 호출하여 특정 게시글에 달린 모든 댓글 목록을 조회
		List<CommentVO> commentlist = sqlSession.selectList("www.silver.dao.IF_writeDAO.selectAllComment", postNum);
		return commentlist;
	}

	@Override
	public boolean deleteComment(int commentId, String userId) {
		// 댓글 ID와 사용자 ID를 HashMap에 저장하여 삭제 권한 확인 후 삭제 처리
		Map<String, Object> params = new HashMap<>();
		params.put("commentId", commentId);
		params.put("userId", userId);
		// MyBatis의 delete 메서드를 호출하여 댓글 삭제, 삭제된 행 수 반환
		int deletedRows = sqlSession.delete("www.silver.dao.IF_writeDAO.deleteComment", params);
		return deletedRows > 0; // 삭제된 행이 1개 이상이면 true 반환
	}

	@Override
	public boolean updateComment(int commentId, String content, Long postNum) {
		// 댓글 ID, 수정 내용, 게시글 번호를 HashMap에 저장하여 수정 처리
		Map<String, Object> params = new HashMap<>();
		params.put("commentId", commentId);
		params.put("content", content);
		params.put("postNum", postNum);
		// MyBatis의 update 메서드를 호출하여 댓글 내용 수정, 수정된 행 수 반환
		int updatedRows = sqlSession.update("www.silver.dao.IF_writeDAO.updateComment", params);
		return updatedRows > 0; // 수정된 행이 1개 이상이면 true 반환
	}

	@Override
	public CommentVO getCommentById(int parentCommentId) {
		// MyBatis의 selectOne 메서드를 호출하여 특정 댓글 ID에 해당하는 댓글 정보를 조회 (대댓글 작성 시 부모 댓글 확인용)
		return sqlSession.selectOne("www.silver.dao.IF_writeDAO.getCommentById", parentCommentId);
	}

	@Override
	public void addCommentReply(CommentVO commentvo) {
		// MyBatis의 insert 메서드를 호출하여 대댓글을 데이터베이스에 추가
		sqlSession.insert("www.silver.dao.IF_writeDAO.addCommentReply", commentvo);
	}


}
