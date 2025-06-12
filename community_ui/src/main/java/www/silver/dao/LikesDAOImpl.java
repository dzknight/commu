package www.silver.dao;

import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import www.silver.vo.LikeVO;

@Repository
public class LikesDAOImpl implements IF_likesDAO {


    @Inject
    private SqlSession sqlSession;

    /**
     * 게시글 좋아요 추가
     * 사용자가 특정 게시글에 좋아요를 누를 때 호출
     * 중복 좋아요 방지는 서비스 계층에서 처리하거나 DB 제약조건으로 처리
     */
    @Override
    public void postLike(LikeVO likevo) {
        // MyBatis의 insert 메서드를 호출하여 데이터베이스에 좋아요 정보를 저장
        // 매퍼 네임스페이스와 SQL ID를 통해 해당 SQL 문 실행
        sqlSession.insert("www.silver.dao.IF_likesDAO.postLike", likevo);
    }

    /**
     * 게시글 좋아요 상태 확인 (사용자가 해당 게시글에 좋아요를 눌렀는지 확인)
     * 프론트엔드에서 좋아요 버튼 상태(활성/비활성) 결정에 사용
     * 중복 좋아요 방지 로직의 핵심 메서드
     */
    @Override
    public int getMyLikeCount(LikeVO likevo) {
        // MyBatis의 selectOne 메서드를 호출하여 특정 사용자의 좋아요 상태를 카운트로 반환
        // 반환값: 0(좋아요 안함) 또는 1(좋아요 함)
        return sqlSession.selectOne("www.silver.dao.IF_likesDAO.getMyLikeCount", likevo);
    }

    /**
     * 게시글 좋아요 삭제
     * 사용자가 이미 누른 좋아요를 취소할 때 호출
     * 토글 방식의 좋아요 기능 구현에 필수적
     */
    @Override
    public void deleteLike(LikeVO likevo) {
        // MyBatis의 delete 메서드를 호출하여 데이터베이스에서 좋아요 정보를 삭제
        // 사용자 ID와 게시글 번호를 조건으로 해당 좋아요 레코드 제거
        sqlSession.delete("www.silver.dao.IF_likesDAO.deleteLike", likevo);
    }

    /**
     * 게시글 좋아요 총 개수 조회
     * 게시글 목록이나 상세 페이지에서 총 좋아요 수 표시용
     * 인기 게시글 판단 기준이나 통계 데이터로 활용
     */
    @Override
    public int getTotalLikeCount(int postNum) {
        // MyBatis의 selectOne 메서드를 호출하여 특정 게시글의 총 좋아요 개수 반환
        // 해당 게시글에 달린 모든 좋아요의 합계를 계산
        return sqlSession.selectOne("www.silver.dao.IF_likesDAO.getTotalLikeCount", postNum);
    }
}
