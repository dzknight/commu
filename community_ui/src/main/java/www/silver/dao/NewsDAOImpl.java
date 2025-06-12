package www.silver.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import www.silver.vo.NewsVO;
import javax.inject.Inject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Repository
public class NewsDAOImpl implements IF_newsDAO{


    @Inject
    private SqlSession sqlSession;

    /**
     * 뉴스 정보를 데이터베이스에 저장
     * 스프링 배치 작업에서 네이버 뉴스 API로부터 수집한 뉴스 데이터를 저장할 때 사용[5]
     * INSERT IGNORE 구문을 통해 중복 데이터 삽입 방지
     */
    @Override
    public void insertNews(NewsVO news) {
        // MyBatis 매퍼의 insertNews SQL을 실행하여 뉴스 데이터 저장
        // 매퍼 XML에서 정의된 INSERT IGNORE 구문으로 중복 방지 처리
        sqlSession.insert("www.silver.dao.IF_newsDAO.insertNews", news);
    }

    /**
     * 2025년 IT 뉴스를 페이징 처리하여 조회
     * 자바 스프링과 JSP를 사용한 뉴스 서비스의 메인 페이지에서 사용[1][3]
     * 대용량 뉴스 데이터를 효율적으로 처리하기 위한 페이징 구현
     */
    @Override
    public List<NewsVO> select2025ItNews(int start, int pageSize) {
        // 페이징 파라미터를 Map으로 구성하여 MyBatis에 전달
        Map<String, Object> param = new HashMap<>();
        param.put("start", start);       // LIMIT 절의 OFFSET 값 (시작 위치)
        param.put("pageSize", pageSize); // LIMIT 절의 COUNT 값 (페이지당 조회할 뉴스 개수)

        // MyBatis selectList로 여러 개의 뉴스 레코드를 List 형태로 반환
        // 매퍼 XML에서 YEAR(pubDate) = 2025 조건과 ORDER BY pubDate DESC로 최신순 정렬
        return sqlSession.selectList("www.silver.dao.IF_newsDAO.select2025ItNews", param);
    }

    /**
     * 전체 뉴스 개수를 조회하는 메서드 (페이징 처리를 위한 총 개수 계산용)
     * JSP에서 페이지 네비게이션 생성 및 "총 N개의 뉴스" 표시에 사용[1]
     * 개발자 커뮤니티 플랫폼의 뉴스 집계 기능에서 통계 정보 제공[6]
     */
    @Override
    public int selectTotalNewsCount() {
        // MyBatis selectOne으로 단일 정수값(COUNT 결과) 반환
        // 2025년 뉴스만 카운트하여 페이징 계산에 필요한 전체 개수 제공
        return sqlSession.selectOne("www.silver.dao.IF_newsDAO.selectTotalNewsCount");
    }
}
