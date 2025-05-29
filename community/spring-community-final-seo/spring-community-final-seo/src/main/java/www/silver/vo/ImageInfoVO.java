package www.silver.vo;

import lombok.Data;

@Data
public class ImageInfoVO {
    private int id;
    private String s3Url; // S3에 저장된 이미지 URL
    private String originalFileName;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getS3Url() {
		return s3Url;
	}
	public void setS3Url(String s3Url) {
		this.s3Url = s3Url;
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
    
    
}
