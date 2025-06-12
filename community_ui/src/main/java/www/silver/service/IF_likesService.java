package www.silver.service;

import www.silver.vo.LikeVO;


public interface IF_likesService {


     // 좋아요 토글 기능 (좋아요/좋아요 취소)
    boolean toggleLike(LikeVO likevo);


     // 특정 사용자의 특정 게시글에 대한 좋아요 상태 확인
    int getMyLikeCount(LikeVO likevo);


     // 특정 게시글의 총 좋아요 개수 조회
    int getTotalLikeCount(int postNum);
}
