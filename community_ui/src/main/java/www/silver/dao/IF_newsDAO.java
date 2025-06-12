package www.silver.dao;
import www.silver.vo.NewsVO;
import java.util.List;

public interface IF_newsDAO {
    /**
     * 뉴스 데이터 삽입
     * 네이버 뉴스 API에서 수집한 뉴스 정보를 데이터베이스에 저장
     * Spring Batch 작업에서 자동으로 수집된 뉴스 데이터를 저장할 때 사용
     * @param news 저장할 뉴스 정보 객체 (제목, 링크, 설명, 발행일 등 포함)
     */
    public void insertNews(NewsVO news);

    /**
     * 2025년 IT 뉴스 목록 조회 (페이지네이션 적용)
     * 뉴스 서비스 웹페이지에서 사용자에게 보여줄 뉴스 목록을 가져오는 메서드
     * 페이지네이션을 통해 성능 최적화 및 사용자 경험 향상
     * @param start 조회 시작 인덱스 (LIMIT 절의 OFFSET 값)
     * @param pageSize 한 페이지에 표시할 뉴스 개수 (LIMIT 절의 COUNT 값)
     * @return List<NewsVO> 조회된 뉴스 목록 (발행일 내림차순 정렬)
     */
    public List<NewsVO> select2025ItNews(int start, int pageSize);

    /**
     * 2025년 전체 뉴스 개수 조회
     * 페이지네이션 구현을 위한 전체 데이터 개수 확인
     * JSP에서 페이지 번호 계산 및 페이지 네비게이션 생성에 사용
     * @return int 2025년에 수집된 전체 뉴스 개수
     */
    public int selectTotalNewsCount();
}
