package www.silver.vo;
//첨부파일 업로드 vo
public class FileAttachVO {
    private int id;
    private String uuid;
    private String uploadPath;
    private String filename;
    private String filetype;
    private long fileSize;
    private String memberId;
    private String uploadDate;
    
    // getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getUuid() { return uuid; }
    public void setUuid(String uuid) { this.uuid = uuid; }
    
    public String getUploadPath() { return uploadPath; }
    public void setUploadPath(String uploadPath) { this.uploadPath = uploadPath; }
    
    public String getFilename() { return filename; }
    public void setFilename(String filename) { this.filename = filename; }
    
    public String getFiletype() { return filetype; }
    public void setFiletype(String filetype) { this.filetype = filetype; }
    
    public long getFileSize() { return fileSize; }
    public void setFileSize(long fileSize) { this.fileSize = fileSize; }
    
    public String getUploadDate() { return uploadDate; }
    public void setUploadDate(String uploadDate) { this.uploadDate = uploadDate; }
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
    
    
    
}