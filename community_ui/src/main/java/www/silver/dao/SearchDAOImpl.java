package www.silver.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import www.silver.vo.BoardVO;
import javax.inject.Inject;
import java.util.List;
import java.util.Map;


@Repository
public class SearchDAOImpl implements IF_searchDAO {

    @Inject
    SqlSession sqlSession;

    /**
     * 검색 타입이 작성자일 때 게시글 목록 조회
     * 개발자 커뮤니티에서 특정 개발자의 질문이나 답변을 찾을 때 사용[1]
     * 페이징 처리를 통해 대용량 검색 결과를 효율적으로 처리
     */
    @Override
    public List<BoardVO> searchByWriter(Map<String, Object> params) {
        // MyBatis selectList로 작성자명 기준 검색 결과를 List 형태로 반환
        // params에는 keyword(작성자명), start(시작 인덱스), pageSize(페이지 크기) 포함
        // 매퍼 XML에서 LIKE 검색이나 정확 일치 검색으로 구현
        return sqlSession.selectList("www.silver.dao.IF_searchDAO.searchByWriter", params);
    }

    /**
     * 검색 타입이 기술스택일 때 게시글 목록 조회
     * Java, Python, JavaScript 등 특정 프로그래밍 언어 관련 게시글 검색[1]
     * 개발자들이 특정 기술 스택 관련 질문이나 정보를 찾을 때 활용
     */
    @Override
    public List<BoardVO> searchByProgrammingLanguage(Map<String, Object> params) {
        // MyBatis selectList로 프로그래밍 언어 기준 검색 결과를 List 형태로 반환
        // 게시글 제목, 내용, 태그 등에서 프로그래밍 언어 키워드를 검색
        // 대소문자 구분 없는 검색이나 부분 일치 검색으로 구현 가능
        return sqlSession.selectList("www.silver.dao.IF_searchDAO.searchByProgrammingLanguage", params);
    }

    /**
     * 작성자를 기준으로 검색했을 때 검색되는 게시글 수를 반환
     * 페이징 처리를 위한 전체 검색 결과 개수 계산[1]
     * JSP에서 "총 N개의 게시글 검색됨" 표시 및 페이지 네비게이션 생성에 사용
     */
    @Override
    public int countByWriter(String keyword) {
        // MyBatis selectOne으로 작성자명 기준 검색 결과의 총 개수 반환
        // COUNT(*) 쿼리를 사용하여 성능 최적화된 개수 조회
        return sqlSession.selectOne("www.silver.dao.IF_searchDAO.countByWriter", keyword);
    }

    /**
     * 기술 스택을 기준으로 검색했을 때 검색되는 게시글 수를 반환
     * 특정 기술 스택의 인기도나 관련 게시글 통계 정보 제공[1]
     * 개발자 커뮤니티 플랫폼의 기술 트렌드 분석에도 활용 가능
     */
    @Override
    public int countByProgrammingLanguage(String keyword) {
        // MyBatis selectOne으로 프로그래밍 언어 기준 검색 결과의 총 개수 반환
        // 해당 기술 스택 관련 게시글이 얼마나 활발한지 통계 데이터로 활용
        return sqlSession.selectOne("www.silver.dao.IF_searchDAO.countByProgrammingLanguage", keyword);
    }
}
