package www.silver.vo;



 public class MailVO {
	private String fromaddress="dzknight15@gmail.com"; // 수신자 이메일 주소
    private String address; // 수신자 이메일 주소
    private String title;   // 메일 제목
    private String message; // 메일 내용
    
	public String getFromaddress() {
		return fromaddress;
	}
	public void setFromaddress(String fromaddress) {
		this.fromaddress = fromaddress;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
    
    
}
