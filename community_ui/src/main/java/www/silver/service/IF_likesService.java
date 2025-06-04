package www.silver.service;

import www.silver.vo.LikeVO;

public interface IF_likesService {
    boolean toggleLike(LikeVO likevo);
    int getMyLikeCount(LikeVO likevo);
    int getTotalLikeCount(int postNum);
}