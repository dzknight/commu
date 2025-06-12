package www.silver.service;
import www.silver.vo.NewsVO;
import java.util.List;


public interface IF_newsService {


     // 뉴스 데이터 수집 및 저장
     // 네이버 뉴스 API에서 최신 IT 뉴스를 가져와서 데이터베이스에 저장
    public void fetchAndSaveNews();


     // 2025년 IT 뉴스 목록 조회
    public List<NewsVO> get2025ItNews(int page, int pageSize);


     // 전체 뉴스 개수 조회
    public int getTotalNewsCount();
}
