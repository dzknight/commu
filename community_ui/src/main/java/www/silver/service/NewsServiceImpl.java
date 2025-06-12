package www.silver.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.net.HttpURLConnection;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import www.silver.dao.IF_newsDAO;
import www.silver.vo.NewsVO;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

/**
 * 뉴스 서비스 구현체
 * 자바 스프링과 JSP를 사용한 뉴스 서비스 개발의 핵심 비즈니스 로직 구현[2][3]
 * 스프링 배치를 사용한 데이터베이스 작업 자동화의 중심 역할[4]
 * 네이버 뉴스 API를 통한 데이터 검색과 텍스트 조작 기능 제공[2]
 */
@Service // 뉴스 서비스 구현 클래스
public class NewsServiceImpl implements IF_newsService {

    /**
     * 뉴스 DAO 주입
     * Java DAO 인터페이스를 활용하여 데이터베이스 작업 수행[1]
     * MyBatis를 통한 SQL 작업과 Spring 의존성 주입 사용[1]
     */
    @Inject
    private IF_newsDAO newsDAO;

    /**
     * 네이버 API clientId 설정 (XML에서 가져온 값)
     * Spring의 @Value 어노테이션을 통한 외부 설정 주입
     */
    @Value("#{naverApiConfig['naver.client.id']}")
    private String clientId;

    /**
     * 네이버 API clientSecret 설정
     * API 인증을 위한 보안 키 설정
     */
    @Value("#{naverApiConfig['naver.client.secret']}")
    private String clientSecret;

    /**
     * 빈 생성 후 초기화 시 호출되는 메서드
     * API 설정 값들의 정상 로딩 여부 확인용
     */
    @PostConstruct
    public void init() {
        System.out.println("Client ID: " + clientId);
        System.out.println("Client Secret: " + clientSecret);
        System.out.println("Client ID 길이: " + clientId.length());
        System.out.println("Client Secret 길이: " + clientSecret.length());
    }

    /**
     * 뉴스 키워드 검색하여 데이터를 DB에 저장하는 메서드
     * Spring Batch의 Reader, Processor, Writer 역할을 통합 수행
     * 스프링 배치 작업의 핵심 비즈니스 로직[4]
     */
    @Override
    public void fetchAndSaveNews() {
        System.out.println("fetchAndSaveNews() 호출됨!");

        // ===== Step Reader 역할 시작 =====
        // 데이터 소스(키워드 배열)를 읽어들이는 단계
        String[] keywords = {
                "클라우드 컴퓨팅", "인공지능", "빅엔진", "블록체인", "네트워크 보안", "해킹", "비트코인",
                "데이터베이스", "머신러닝", "파이썬", "자바스크립트", "메타버스", "챗GPT",
                "사물인터넷", "가상현실", "증강현실", "로봇공학"
        };
        // ===== Step Reader 역할 끝 =====

        for (String keyword : keywords) {
            // ===== Step Reader 역할 상세 =====
            // 외부 API에서 뉴스 데이터(JSON)를 읽어오는 단계
            String json = callNaverNewsApi(keyword);
            System.out.println("네이버 API 응답: " + json);
            // ===== Step Reader 역할 끝 =====

            // ===== Step Processor 역할 시작 =====
            // 읽어온 JSON 데이터를 가공/변환하여 NewsVO 객체로 처리하는 단계
            List<NewsVO> newsList = parseNewsJson(json, keyword);
            // ===== Step Processor 역할 끝 =====

            for (NewsVO news : newsList) {
                // ===== Step Processor 역할 상세 =====
                // 데이터 필터링: 2025년 뉴스만 처리하도록 필터링하는 단계
                if (news.getPubDate() != null && news.getPubDate().toString().startsWith("2025")) {
                    // ===== Step Processor 역할 끝 =====

                    // ===== Step Writer 역할 시작 =====
                    // 처리된 데이터를 최종 저장소(DB)에 저장하는 단계
                    newsDAO.insertNews(news);
                    // ===== Step Writer 역할 끝 =====
                }
            }
        }
    }

    /**
     * 2025년 IT 뉴스 목록을 페이징하여 가져오는 메서드
     * 자바 스프링 뉴스 서비스의 웹 페이지 표시용[2][3]
     */
    @Override
    public List<NewsVO> get2025ItNews(int page, int pageSize) {
        int start = (page - 1) * pageSize;
        return newsDAO.select2025ItNews(start, pageSize);
    }

    /**
     * 전체 뉴스 개수를 가져오는 메서드
     * JSP 페이지네이션 구현을 위한 총 개수 제공[2]
     */
    @Override
    public int getTotalNewsCount() {
        return newsDAO.selectTotalNewsCount();
    }

    /**
     * ===== Step Reader 역할 상세 메서드 =====
     * 외부 API에서 데이터를 읽어오는 실제 구현
     * 네이버 뉴스 API 호출 및 JSON 응답 수신
     */
    private String callNaverNewsApi(String keyword) {
        try {
            System.out.println("API 호출 시작 - 키워드: " + keyword);
            System.out.println("사용된 Client ID: " + clientId);

            // 키워드 인코딩
            String text = URLEncoder.encode(keyword, "UTF-8");
            // API 요청 URL 구성
            String apiURL = "https://openapi.naver.com/v1/search/news.json?query=" + text + "&display=100&sort=date";

            System.out.println("요청 URL: " + apiURL);

            // HTTP 연결 설정
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            // 네이버 클라이언트 정보 추가
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);

            // 응답 코드 확인
            int responseCode = con.getResponseCode();
            System.out.println("응답 코드: " + responseCode);

            // 응답 스트림 읽기
            InputStream is = (responseCode == 200) ? con.getInputStream() : con.getErrorStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
            StringBuilder sb = new StringBuilder();
            String line;
            // 응답 문자열로 변환
            while ((line = br.readLine()) != null) sb.append(line);
            br.close();
            return sb.toString();
        } catch (Exception e) {
            System.out.println("API 호출 중 오류 발생:");
            e.printStackTrace();
            return null;
        }
    }

    /**
     * ===== Step Processor 역할 상세 메서드 =====
     * 받은 JSON 데이터를 비즈니스 객체(NewsVO)로 변환/가공하는 실제 구현
     * 데이터 검색과 텍스트 조작 기능의 핵심 로직[2]
     */
    private List<NewsVO> parseNewsJson(String json, String keyword) {
        List<NewsVO> newsList = new ArrayList<>();
        try {
            // JSON 파싱을 위한 ObjectMapper
            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(json);
            // 'items' 배열 가져오기
            JsonNode items = root.path("items");
            // 날짜 형식 설정 (네이버 API 형식)
            SimpleDateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss Z", Locale.ENGLISH);

            // 각 뉴스 아이템을 NewsVO로 변환 (데이터 가공/변환 처리)
            for (JsonNode item : items) {
                NewsVO news = new NewsVO();
                // json 필드 문자열로 변환
                news.setTitle(item.path("title").asText());
                news.setOriginallink(item.path("originallink").asText());
                news.setLink(item.path("link").asText());
                news.setDescription(item.path("description").asText());
                // 날짜 파싱
                String pubDateStr = item.path("pubDate").asText();
                Date date = sdf.parse(pubDateStr);
                news.setPubDate(new Timestamp(date.getTime()));
                // 검색 키워드와 카테고리 설정
                news.setQuery(keyword);
                news.setCategory(keyword);
                newsList.add(news);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return newsList;
    }
}
