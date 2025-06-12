package www.silver.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import www.silver.util.PhoneFormat;

public class MemberVO {
	private String userId;
	private String userPassword; 
	private String oldPassword; 
	private String userName;
	private String zipCode;
	private String address; 
	private String detailAddress; 
	private String userEmail;
	private String fullEmail;
	@PhoneFormat
	private String userPhoneNum;
	private String profile_img;
	private String profileImage;
	private String profileImagePath; // 저장된 파일 경로 또는 Base64 문자열
    private MultipartFile profileImageFile; // 업로드용 임시 필드
    private Date regDate;//가입일
    
    private boolean emailVerified;
    
    
    public boolean isEmailVerified() {
		return emailVerified;
	}
	public void setEmailVerified(boolean emailVerified) {
		this.emailVerified = emailVerified;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date birthdate;//생일
    
    private String kakaoId;
    
    private String loginType;
    
    private boolean isKakaoRegistered;
    // 기본 생성자
    public MemberVO() {}
    // 카카오 임시 회원 생성자
    public MemberVO(String kakaoId, String userName, String userEmail) {
        this.kakaoId = kakaoId;
        this.userName = userName;
        this.userEmail = userEmail;
        this.loginType = "KAKAO";
        this.isKakaoRegistered = false;
        this.profile_img = "default.jpg";
    }
    
	public String getKakaoId() {
		return kakaoId;
	}
	public void setKakaoId(String kakaoId) {
		this.kakaoId = kakaoId;
	}
	public String getLoginType() {
		return loginType;
	}
	public void setLoginType(String loginType) {
		this.loginType = loginType;
	}
	public boolean isKakaoRegistered() {
		return isKakaoRegistered;
	}
	public void setKakaoRegistered(boolean isKakaoRegistered) {
		this.isKakaoRegistered = isKakaoRegistered;
	}
	public String getOldPassword() {
		return oldPassword;
	}
	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}
	public String getFullEmail() {
		return fullEmail;
	}
	public void setFullEmail(String fullEmail) {
		this.fullEmail = fullEmail;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
    
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	public String getProfileImage() {
		return profileImage;
	}
	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}
	public String getProfileImagePath() {
		return profileImagePath;
	}
	public void setProfileImagePath(String profileImagePath) {
		this.profileImagePath = profileImagePath;
	}
	public MultipartFile getProfileImageFile() {
		return profileImageFile;
	}
	public void setProfileImageFile(MultipartFile profileImageFile) {
		this.profileImageFile = profileImageFile;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPhoneNum() {
		return userPhoneNum;
	}
	public void setUserPhoneNum(String userPhoneNum) {
		this.userPhoneNum = userPhoneNum;
	}
	public Date getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}
	
	
	
	
	
}
