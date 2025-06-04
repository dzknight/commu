package www.silver.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import www.silver.dao.IF_likesDAO;
import www.silver.vo.LikeVO;

@Service
public class LikesServiceImpl implements IF_likesService {
    
    @Inject
    IF_likesDAO likesdao;

    @Override
    public boolean toggleLike(LikeVO likevo) {
        try {
            if (getMyLikeCount(likevo) < 1) {
                likesdao.postLike(likevo);
                System.out.println("좋아요 추가 - postNum: " + likevo.getPostNum() + ", userId: " + likevo.getUserId());
            } else {
                likesdao.deleteLike(likevo);
                System.out.println("좋아요 삭제 - postNum: " + likevo.getPostNum() + ", userId: " + likevo.getUserId());
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public int getMyLikeCount(LikeVO likevo) {
        return likesdao.getMyLikeCount(likevo);
    }

    @Override
    public int getTotalLikeCount(int postNum) {
        return likesdao.getTotalLikeCount(postNum);
    }
}