package www.silver.dao;

import www.silver.vo.BoardVO;

import java.util.List;
import java.util.Map;

public interface IF_searchDAO {

    /**
     * 작성자명으로 게시글 검색 (페이지네이션 적용)
     * 특정 작성자가 작성한 모든 게시글을 검색하는 기능
     * 개발자 커뮤니티에서 특정 개발자의 질문이나 답변을 찾을 때 사용
     * @param params 검색 파라미터 맵 (keyword: 작성자명, start: 시작 인덱스, pageSize: 페이지 크기)
     * @return List<BoardVO> 해당 작성자의 게시글 목록
     */
    List<BoardVO> searchByWriter(Map<String, Object> params);

    /**
     * 프로그래밍 언어별 게시글 검색 (페이지네이션 적용)
     * Java, Python, JavaScript 등 특정 프로그래밍 언어 관련 게시글을 검색
     * 개발자들이 특정 기술 스택 관련 질문이나 정보를 찾을 때 사용
     * 게시글 제목, 내용, 태그 등에서 프로그래밍 언어 키워드를 검색
     * @param params 검색 파라미터 맵 (keyword: 프로그래밍 언어명, start: 시작 인덱스, pageSize: 페이지 크기)
     * @return List<BoardVO> 해당 프로그래밍 언어 관련 게시글 목록
     */
    List<BoardVO> searchByProgrammingLanguage(Map<String, Object> params);

    /**
     * 작성자명 검색 결과 총 개수 조회
     * 페이지네이션 구현을 위한 전체 검색 결과 개수 확인
     * JSP에서 페이지 번호 계산 및 "총 N개의 게시글" 표시에 사용
     * @param keyword 검색할 작성자명
     * @return int 해당 작성자의 총 게시글 개수
     */
    int countByWriter(String keyword);

    /**
     * 프로그래밍 언어 검색 결과 총 개수 조회
     * 페이지네이션 구현을 위한 전체 검색 결과 개수 확인
     * 특정 기술 스택 관련 게시글이 얼마나 있는지 통계 정보 제공
     * @param keyword 검색할 프로그래밍 언어명
     * @return int 해당 프로그래밍 언어 관련 총 게시글 개수
     */
    int countByProgrammingLanguage(String keyword);
}
