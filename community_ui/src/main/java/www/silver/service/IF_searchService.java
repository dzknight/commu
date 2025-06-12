package www.silver.service;

import www.silver.vo.BoardVO;
import www.silver.vo.PageVO;

import java.util.List;

public interface IF_searchService {


     // 검색 결과 총 개수 조회
    public int getSearchTotalCount(String keyword, String type);


    PageVO searchPagingParam(String keyword, String writer, int page);


     // 검색 조건에 따른 게시글 목록 조회
     // 키워드, 검색 타입, 페이지 번호에 따라 해당하는 게시글 목록을 반환
    List<BoardVO> searchContent(String keyword, String type, int page);
}
