package www.silver.dao;

import java.util.List;
import java.util.Map;
import www.silver.vo.BoardVO;
import www.silver.vo.CommentVO;

public interface IF_writeDAO {

    /**
     * 새로운 게시글을 데이터베이스에 저장
     * 개발자 커뮤니티에서 Q&A 질문 등록할 때 사용
     * @param boardvo 저장할 게시글 정보 객체 (제목, 내용, 작성자, 카테고리 등)
     */
    public void insertWrite(BoardVO boardvo);

    /**
     * 게시글에 첨부된 파일명을 데이터베이스에 저장
     * 코드 스니펫, 이미지, 문서 등 개발 관련 파일 첨부 기능 지원
     * @param params 파일 정보 맵 (게시글 번호, 파일명, 파일 경로 등)
     */
    public void attachFname(Map<String, Object> params);

    /**
     * 모든 게시글 목록을 조회
     * 관리자 페이지나 전체 게시글 통계 확인용으로 사용
     * 성능상 이유로 실제 서비스에서는 페이징 처리된 메서드 사용 권장
     * @return List<BoardVO> 전체 게시글 목록
     */
    public List<BoardVO> selectall();

    /**
     * 페이징 처리를 위한 특정 범위의 게시글 목록을 조회
     * 자바 스프링 뉴스 서비스와 커뮤니티 플랫폼의 메인 게시글 목록 표시용
     * @param pagingParams 페이징 파라미터 맵 (start: 시작 인덱스, pageSize: 페이지 크기)
     * @return List<BoardVO> 페이징 처리된 게시글 목록
     */
    public List<BoardVO> pagingList(Map<String, Integer> pagingParams);

    /**
     * 전체 게시글 개수 반환 (페이징 계산용)
     * JSP에서 페이지 네비게이션 생성 및 "총 N개의 게시글" 표시에 사용
     * @return int 전체 게시글 개수
     */
    public int boardCount();

    /**
     * 특정 게시글 번호에 해당하는 게시글 한 개 정보를 조회
     * 게시글 상세 페이지 표시 및 수정/삭제 권한 확인에 사용
     * @param postNum 조회할 게시글 번호
     * @return BoardVO 해당 게시글의 상세 정보
     */
    public BoardVO selectOne(Long postNum);

    /**
     * 특정 게시글에 첨부된 파일 목록을 조회
     * 게시글 상세 페이지에서 첨부 파일 다운로드 링크 표시용
     * @param postNum 조회할 게시글 번호
     * @return List<String> 첨부된 파일명 목록
     */
    public List<String> getAttach(Long postNum);

    /**
     * 특정 게시글을 삭제
     * 작성자 본인이나 관리자만 삭제 가능하도록 권한 체크 필요
     * @param postNum 삭제할 게시글 번호
     */
    public void deleteWrite(Long postNum);

    /**
     * 특정 게시글의 내용을 수정
     * 제목, 내용, 카테고리 등 게시글 정보 업데이트
     * @param boardVO 수정할 게시글 정보 객체
     */
    public void modifyWrite(BoardVO boardVO);

    /**
     * 특정 게시글에 첨부된 파일을 삭제
     * 게시글 수정 시 기존 첨부 파일 제거 또는 게시글 삭제 시 연관 파일 정리용
     * @param postNum 첨부 파일을 삭제할 게시글 번호
     */
    public void deleteAttach(Long postNum);

    /**
     * 특정 게시글의 조회수를 증가
     * 게시글 상세 페이지 접근 시 자동으로 조회수 카운트 증가
     * 인기 게시글 판단 및 통계 데이터 수집에 활용
     * @param postNum 조회수를 증가시킬 게시글 번호
     */
    public void viewCount(Long postNum);

    /**
     * 새로운 댓글을 데이터베이스에 저장
     * Q&A 게시판에서 질문에 대한 답변이나 추가 의견 등록
     * @param commentvo 저장할 댓글 정보 객체 (내용, 작성자, 게시글 번호 등)
     */
    public void insertCommentWrite(CommentVO commentvo);

    /**
     * 특정 게시글에 달린 모든 댓글 목록을 조회
     * 게시글 상세 페이지에서 댓글 목록 표시용
     * 계층형 댓글 구조 지원 (댓글과 대댓글 구분)
     * @param postNum 댓글을 조회할 게시글 번호
     * @return List<CommentVO> 해당 게시글의 모든 댓글 목록
     */
    public List<CommentVO> selectAllComment(Long postNum);

    /**
     * 특정 댓글을 삭제 (작성자 확인 후 삭제 성공 여부 반환)
     * 댓글 작성자 본인만 삭제 가능하도록 권한 체크 포함
     * @param commentId 삭제할 댓글 ID
     * @param userId 삭제를 요청한 사용자 ID
     * @return boolean 삭제 성공 여부 (true: 성공, false: 권한 없음 또는 실패)
     */
    public boolean deleteComment(int commentId, String userId);

    /**
     * 특정 댓글의 내용을 수정 (권한 확인 후 수정 성공 여부 반환)
     * 댓글 작성자 본인만 수정 가능하도록 권한 체크 포함
     * @param commentId 수정할 댓글 ID
     * @param content 수정할 댓글 내용
     * @param postNum 댓글이 속한 게시글 번호
     * @return boolean 수정 성공 여부 (true: 성공, false: 권한 없음 또는 실패)
     */
    public boolean updateComment(int commentId, String content, Long postNum);

    /**
     * 특정 댓글 ID에 해당하는 댓글 정보를 조회 (대댓글 작성 시 부모 댓글 정보 확인용)
     * 대댓글 작성 시 부모 댓글의 존재 여부 및 정보 확인
     * 계층형 댓글 구조에서 depth 계산 등에 활용
     * @param parentCommentId 조회할 부모 댓글 ID
     * @return CommentVO 해당 댓글의 정보
     */
    public CommentVO getCommentById(int parentCommentId);

    /**
     * 대댓글을 데이터베이스에 추가
     * 기존 댓글에 대한 답글 형태로 계층형 댓글 구조 지원
     * depth, parentId 등 대댓글 관련 정보 포함하여 저장
     * @param commentvo 저장할 대댓글 정보 객체
     */
    public void addCommentReply(CommentVO commentvo);

    /**
     * 특정 대댓글의 내용 수정 후 성공 여부를 반환
     * 일반 댓글과 대댓글을 구분하여 처리하는 별도 메서드
     * 대댓글 특성상 추가적인 검증 로직이 필요할 수 있음
     * @param commentId 수정할 대댓글 ID
     * @param content 수정할 내용
     * @param postNum 대댓글이 속한 게시글 번호
     * @return boolean 수정 성공 여부
     */
    public boolean updateReplyComment(int commentId, String content, Long postNum);
}
