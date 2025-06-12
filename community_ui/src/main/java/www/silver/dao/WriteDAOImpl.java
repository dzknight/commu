package www.silver.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import www.silver.vo.BoardVO;
import www.silver.vo.CommentVO;

@Repository
public class WriteDAOImpl implements IF_writeDAO {


	@Inject
	SqlSession sqlSession;


	// 게시글 등록
	@Override
	public void insertWrite(BoardVO boardvo) {
		sqlSession.insert("www.silver.dao.IF_writeDAO.insertone", boardvo);
	}


	 // 게시글 첨부 파일 정보 저장
	 // 이미지 파일 첨부 기능
	@Override
	public void attachFname(Map<String, Object> params) {
		sqlSession.insert("www.silver.dao.IF_writeDAO.board_attach", params);
	}


	 // 전체 게시글 목록 조회
	@Override
	public List<BoardVO> selectall() {
		List<BoardVO> clist = sqlSession.selectList("www.silver.dao.IF_writeDAO.selectall");
		return clist;
	}


	 // 페이징 처리된 게시글 목록 조회
	@Override
	public List<BoardVO> pagingList(Map<String, Integer> pagingParams) {
		// pagingParams에는 start(시작 인덱스)와 pageSize(페이지 크기) 포함
		return sqlSession.selectList("www.silver.dao.IF_writeDAO.pagingList", pagingParams);
	}


	 // 전체 게시글 개수 조회
	@Override
	public int boardCount() {

		int count = sqlSession.selectOne("www.silver.dao.IF_writeDAO.boardCount");
		System.out.println("DAO: 게시글 수 = " + count);
		return count;
	}


	 // 특정 게시글 상세 정보 조회
	@Override
	public BoardVO selectOne(Long postNum) {
		BoardVO boardvo = sqlSession.selectOne("www.silver.dao.IF_writeDAO.selectOne", postNum);
		return boardvo;
	}


	 // 특정 게시글의 첨부 파일 목록 조회
	@Override
	public List<String> getAttach(Long postNum) {
		return sqlSession.selectList("www.silver.dao.IF_writeDAO.getAttach", postNum);
	}


	 // 특정 게시글 삭제
	 // 작성자 본인만 삭제 가능하도록
	@Override
	public void deleteWrite(Long postNum) {
		sqlSession.delete("www.silver.dao.IF_writeDAO.deleteone", postNum);
	}


	 // 특정 게시글 내용 수정
	 // 제목, 내용, 카테고리 등 게시글 정보 수정
	@Override
	public void modifyWrite(BoardVO boardvo) {
		sqlSession.update("www.silver.dao.IF_writeDAO.modifyone", boardvo);
	}


	 // 특정 게시글의 첨부 파일 삭제
	@Override
	public void deleteAttach(Long postNum) {
		sqlSession.delete("www.silver.dao.IF_writeDAO.deleteAttach", postNum);
	}


	 // 특정 게시글의 조회수 증가
	 // 게시글 상세 페이지 접근 시 자동으로 조회수 카운트 증가
	@Override
	public void viewCount(Long postNum) {
		sqlSession.update("www.silver.dao.IF_writeDAO.viewCount", postNum);
	}


	 // 새로운 댓글 삽입
	@Override
	public void insertCommentWrite(CommentVO commentvo) {
		sqlSession.insert("www.silver.dao.IF_writeDAO.insertComment", commentvo);
	}


	 // 특정 게시글의 모든 댓글 목록 조회
	 // 계층형 댓글 구조 지원 (댓글과 대댓글 구분)
	@Override
	public List<CommentVO> selectAllComment(Long postNum) {
		List<CommentVO> commentlist = sqlSession.selectList("www.silver.dao.IF_writeDAO.selectAllComment", postNum);
		return commentlist;
	}


	 // 특정 댓글 삭제 (권한 확인 포함)
	 // 댓글 작성자 본인만 삭제 가능하도록
	@Override
	public boolean deleteComment(int commentId, String userId) {
		// 댓글 ID와 사용자 ID를 HashMap에 저장하여 삭제 권한 확인 후 삭제 처리
		Map<String, Object> params = new HashMap<>();
		params.put("commentId", commentId);
		params.put("userId", userId);
		// WHERE 절에서 commentId와 userId 모두 일치하는 경우만 삭제 처리
		int deletedRows = sqlSession.delete("www.silver.dao.IF_writeDAO.deleteComment", params);
		return deletedRows > 0; // 삭제된 행이 1개 이상이면 true 반환 (권한 확인 성공)
	}


	 // 특정 댓글 내용 수정 (권한 확인 포함)
	 // 댓글 작성자 본인만 수정 가능하도록
	@Override
	public boolean updateComment(int commentId, String content, Long postNum) {
		// 댓글 ID, 수정 내용, 게시글 번호를 HashMap에 저장하여 수정 처리
		Map<String, Object> params = new HashMap<>();
		params.put("commentId", commentId);
		params.put("content", content);
		params.put("postNum", postNum);
		int updatedRows = sqlSession.update("www.silver.dao.IF_writeDAO.updateComment", params);
		return updatedRows > 0;
	}


	 // 특정 댓글 정보 조회 (대댓글 작성용)
	 // 대댓글 작성 시 부모 댓글의 존재 여부 및 확인
	@Override
	public CommentVO getCommentById(int parentCommentId) {
		// 부모 댓글의 depth, postNum 등 정보를 가져와 대댓글의 depth 계산에 활용
		return sqlSession.selectOne("www.silver.dao.IF_writeDAO.getCommentById", parentCommentId);
	}


	 // 대댓글 추가
	 //기존 댓글에 대한 답글 형태로 계층형 댓글 구조
	@Override
	public void addCommentReply(CommentVO commentvo) {
		// 일반 댓글보다 depth가 1 증가한 값으로 계층 구조 표현
		sqlSession.insert("www.silver.dao.IF_writeDAO.addCommentReply", commentvo);
	}


	 // 대댓글 수정 (일반 댓글과 구분 처리)
	 // 일반 댓글과 대댓글을 구분하여 처리하는 메서드
	@Override
	public boolean updateReplyComment(int commentId, String content, Long postNum) {
		// 대댓글 수정을 위한 파라미터 설정
		Map<String, Object> params = new HashMap<>();
		params.put("commentId", commentId);
		params.put("content", content);
		params.put("postNum", postNum);
		int updatedReplyComment = sqlSession.update("www.silver.dao.IF_writeDAO.updateReplyComment", params);
		return updatedReplyComment > 0;
	}
}
