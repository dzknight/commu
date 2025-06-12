package www.silver.hom;

import org.springframework.web.bind.annotation.RequestParam;
import www.silver.service.IF_newsService;
import www.silver.vo.NewsVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import www.silver.vo.PageVO;

import javax.inject.Inject;
import java.util.List;

@Controller
public class NewsController {

    @Inject
    private IF_newsService newsService;

    @GetMapping("/itNews")
    public String showItNews(Model model,
                             // page 파라미터를 받아옴, 없으면 기본값 1
                             @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
        System.out.println("=== IT뉴스 컨트롤러 진입 ===");
        int pageSize = 10; // 한 페이지에 보여줄 뉴스 개수
        int totalCount = newsService.getTotalNewsCount(); // 전체 뉴스 개수 조회
        System.out.println("전체 뉴스 개수: " + totalCount);
        
        // 데이터가 없으면 자동으로 수집
        if (totalCount == 0) {
            newsService.fetchAndSaveNews();
            totalCount = newsService.getTotalNewsCount(); // 수집 후 다시 조회
        }
        
        int maxPage = (int) Math.ceil((double) totalCount / pageSize); // 전체 페이지 수 계산
        int startPage = ((page - 1) / 10) * 10 + 1; // 페이지 네비게이션의 시작 페이지 (1~10, 11~20 등)
        int endPage = Math.min(startPage + 9, maxPage); // 페이지 네비게이션의 끝 페이지

        // 페이지 정보를 담을 PageVO 객체 생성 및 값 설정
        PageVO pagevo = new PageVO();
        pagevo.setPage(page);
        pagevo.setMaxPage(maxPage);
        pagevo.setStartPage(startPage);
        pagevo.setEndPage(endPage);

        // 해당 페이지의 뉴스 목록 조회
        List<NewsVO> newsList = newsService.get2025ItNews(page, pageSize);
        // 모델에 뉴스 목록과 페이지 정보 추가
        model.addAttribute("newsList", newsList);
        model.addAttribute("paging", pagevo);
        return "getuseds/itNews";
    }
}
