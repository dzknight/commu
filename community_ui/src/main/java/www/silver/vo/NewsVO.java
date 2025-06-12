package www.silver.vo;

import java.sql.Timestamp;

public class NewsVO {
	private Long newsId; // 뉴스 번호
	private String title; // 뉴스 기사 제목
	private String originallink; // 뉴스 기사의 원래 출처
	private String link;   // 네이버에서 제공하는 뉴스 url
	private String description; // 뉴스 기사 본문
	private Timestamp pubDate; // 뉴스 기사가 게시된 날짜 및 시간
	private String query; // 뉴스 데이터 가져올 때 사용된 검색 키워드
	private String category; // 뉴스 기사의 카테고리

	public Long getNewsId() {
		return newsId;
	}
	public void setNewsId(Long newsId) {
		this.newsId = newsId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getOriginallink() {
		return originallink;
	}
	public void setOriginallink(String originallink) {
		this.originallink = originallink;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Timestamp getPubDate() {
		return pubDate;
	}
	public void setPubDate(Timestamp pubDate) {
		this.pubDate = pubDate;
	}
	public String getQuery() {
		return query;
	}
	public void setQuery(String query) {
		this.query = query;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
}
