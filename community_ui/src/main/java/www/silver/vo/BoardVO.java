package www.silver.vo;

import java.util.List;

public class BoardVO {
	private Long postNum; // 글 번호
	private String writer; // 작성자
	private String title; // 글 제목
	private String content; // 글 내용
	private java.sql.Timestamp createdAt; // 글 작성일시
	private int price; // 가격
	private String saleStatus; // 판매 상태
	private Integer views; // 조회수
	private List<String> filename; // 첨부파일 이름
	
	
	
	public Integer getViews() {
		return views;
	}
	public void setViews(Integer views) {
		this.views = views;
	}
	public Long getPostNum() {
		return postNum;
	}
	public void setPostNum(Long postNum) {
		this.postNum = postNum;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public java.sql.Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(java.sql.Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getSaleStatus() {
		return saleStatus;
	}
	public void setSaleStatus(String saleStatus) {
		this.saleStatus = saleStatus;
	}
	public List<String> getFilename() {
		return filename;
	}
	public void setFilename(List<String> filename) {
		this.filename = filename;
	}
	
	

}
