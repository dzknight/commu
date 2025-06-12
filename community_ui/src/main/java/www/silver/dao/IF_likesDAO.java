package www.silver.dao;

import www.silver.vo.LikeVO;

/**
 * 게시글 좋아요 기능 관련 데이터 액세스 인터페이스
 * 뉴스 서비스나 커뮤니티 플랫폼에서 사용자의 좋아요 기능을 처리하는 DAO
 */
public interface IF_likesDAO {

    /**
     * 게시글 좋아요 추가
     * 사용자가 특정 게시글에 좋아요를 누를 때 호출되는 메서드
     * @param likevo 좋아요 정보 객체 (사용자 ID, 게시글 번호 등 포함)
     */
    public void postLike(LikeVO likevo);

    /**
     * 게시글 좋아요 상태 확인 (사용자가 해당 게시글에 좋아요를 눌렀는지 확인)
     * 중복 좋아요 방지 및 좋아요 버튼 상태 표시를 위해 사용
     * @param likevo 확인할 좋아요 정보 (사용자 ID, 게시글 번호)
     * @return int 좋아요 개수 (0: 좋아요 안함, 1: 좋아요 함)
     */
    public int getMyLikeCount(LikeVO likevo);

    /**
     * 게시글 좋아요 삭제
     * 사용자가 이미 누른 좋아요를 취소할 때 호출되는 메서드
     * @param likeVo 삭제할 좋아요 정보 객체
     */
    public void deleteLike(LikeVO likeVo);

    /**
     * 게시글 좋아요 총 개수 조회
     * 특정 게시글에 달린 전체 좋아요 수를 가져오는 메서드
     * 게시글 목록이나 상세 페이지에서 좋아요 수 표시용
     * @param postNum 조회할 게시글 번호
     * @return int 해당 게시글의 총 좋아요 개수
     */
    public int getTotalLikeCount(int postNum);
}
