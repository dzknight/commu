package www.silver.hom;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import www.silver.service.IF_searchService;
import www.silver.vo.BoardVO;
import www.silver.vo.PageVO;
import javax.inject.Inject;
import java.util.List;

@Controller
public class SearchController {
    @Inject
    IF_searchService searchService;

    @GetMapping("/searchContent")
    public String searchContent(
            @RequestParam("type") String type,
            @RequestParam("keyword") String keyword,
            @RequestParam(value = "page", defaultValue = "1") int page,
            Model model) {

        try {
            // 검색 결과 조회
            // type: 작성자 or 기술 스택
            List<BoardVO> searchResults = searchService.searchContent(keyword, type, page);
            // 페이징 조회
            PageVO pageVO = searchService.searchPagingParam(keyword, type, page);

            model.addAttribute("contentlist", searchResults);
            model.addAttribute("paging", pageVO);
            model.addAttribute("isSearchResult", true);
            model.addAttribute("searchType", type);
            model.addAttribute("searchKeyword", keyword);
            model.addAttribute("totalCount", searchService.getSearchTotalCount(keyword, type));
            return "getuseds/board";

        } catch (Exception e) {
            model.addAttribute("error", "검색 중 오류가 발생했습니다.");
            return "getuseds/board";
        }
    }



}
