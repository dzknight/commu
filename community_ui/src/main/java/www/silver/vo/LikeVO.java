package www.silver.vo;

public class LikeVO {
	private int likeNum; // 좋아요 번호
	private String userId; // 좋아요를 누른 회원 정보
	private int postNum; // 좋아요가 눌린 게시글 번호
	
	public int getLikeNum() {
		return likeNum;
	}
	public void setLikeNum(int likeNum) {
		this.likeNum = likeNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getPostNum() {
		return postNum;
	}
	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}
	
	

}
