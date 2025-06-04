package www.silver.dao;


import www.silver.vo.LikeVO;

public interface IF_likesDAO {
    // 게시글 좋아요 추가
    public void postLike(LikeVO likevo);
    
    // 게시글 좋아요 여부 확인 (사용자가 해당 게시글에 좋아요를 눌렀는지)
    public int getMyLikeCount(LikeVO likevo);
    
    // 게시글 좋아요 취소
    public void deleteLike(LikeVO likeVo);
    
    // 게시글 좋아요 총 개수 조회
    public int getTotalLikeCount(int postNum);
}
