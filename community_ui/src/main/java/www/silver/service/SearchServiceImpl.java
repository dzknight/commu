package www.silver.service;

import org.springframework.stereotype.Service;
import www.silver.dao.IF_searchDAO;
import www.silver.vo.BoardVO;
import www.silver.vo.PageVO;
import javax.inject.Inject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SearchServiceImpl implements IF_searchService {

    @Inject
    IF_searchDAO searchDAO;

    int pageLimit = 10; // 페이지당 보여줄 게시글 개수
    int blockLimit = 5; //아래에 보여줄 페이지 번호 개수

    @Override
    public List<BoardVO> searchContent(String keyword, String type, int page) {
        try {
            if (page < 1) {
                page = 1;
            }
            int pagingStart = (page - 1) * pageLimit;

            Map<String, Object> searchType = new HashMap<>();
            searchType.put("keyword", keyword);
            searchType.put("start", pagingStart);
            searchType.put("limit", pageLimit);

            switch (type) {
                case "writer":
                    return searchDAO.searchByWriter(searchType);
                case "programmingLanguage":
                    return searchDAO.searchByProgrammingLanguage(searchType);
                default:
                    return new ArrayList<>();
            }
        } catch (Exception e) {
            System.out.println("검색 중 오류 발생: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    // 검색된 게시글에 대한 페이징
    @Override
    public PageVO searchPagingParam(String keyword, String type, int page) {
        try {
            // 총 검색 결과 수 조회
            int searchCount = getSearchTotalCount(keyword, type);
            System.out.println("Total search count: " + searchCount);

            // 전체 페이지 수 계산
            int maxPage = (int) Math.ceil((double) searchCount / pageLimit);
            if (maxPage < 1) maxPage = 1;

            // 현재 페이지 범위 체크
            if (page < 1) page = 1;
            if (page > maxPage) page = maxPage;

            // 하단 페이지 번호 범위 계산 (WriteService와 동일한 로직)
            int startPage = ((page - 1) / blockLimit) * blockLimit + 1;
            int endPage = startPage + blockLimit - 1;
            if (endPage > maxPage) endPage = maxPage;

            PageVO pagevo = new PageVO();
            pagevo.setPage(page);
            pagevo.setMaxPage(maxPage);
            pagevo.setStartPage(startPage);
            pagevo.setEndPage(endPage);

            System.out.println("== 검색 페이징 정보 확인 ==");
            System.out.println("keyword = " + keyword + ", type = " + type);
            System.out.println("page = " + page);
            System.out.println("startPage = " + startPage);
            System.out.println("endPage = " + endPage);
            System.out.println("maxPage = " + maxPage);

            return pagevo;

        } catch (Exception e) {
            System.out.println("페이징 계산 중 오류 발생: " + e.getMessage());
            // 오류시 기본 페이징값 반환함
            PageVO defaultPagevo = new PageVO();
            defaultPagevo.setPage(1);
            defaultPagevo.setMaxPage(1);
            defaultPagevo.setStartPage(1);
            defaultPagevo.setEndPage(1);
            return defaultPagevo;
        }
    }

    // 작성자와 기술스택으로 검색을 했을 때 반환되는 게시글 수
    @Override
    public int getSearchTotalCount(String keyword, String type) {
        try {
            switch (type) {
                case "writer":
                    return searchDAO.countByWriter(keyword);
                case "programmingLanguage":
                    return searchDAO.countByProgrammingLanguage(keyword);
                default:
                    return 0;
            }
        } catch (Exception e) {
            System.out.println("총 개수 조회 중 오류 발생: " + e.getMessage());
            return 0;
        }
    }
}
