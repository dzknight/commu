package www.silver.vo;

import java.sql.Timestamp;

public class CommentVO {
    private int commentId; // 댓글/대댓글 고유 ID
    private Long postNum; // 소속 게시글 ID
    private String userId; // 작성자 ID
    private String content; // 댓글 내용
    private Integer parentCommentId; // 부모 댓글 ID (최상위 댓글일 경우 0 또는 -1)
    private Integer depth; // 계층 깊이 (0: 댓글, 1 이상: 대댓글)
    private int likes; // 좋아요 수
    private boolean isDeleted; // 삭제 여부
    private Timestamp createdAt; // 작성 시각
    private Timestamp updateAt; // 수정 시각

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public Long getPostNum() {
        return postNum;
    }

    public void setPostNum(Long postNum) {
        this.postNum = postNum;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    
    public Integer getParentCommentId() {
		return parentCommentId;
	}

	public void setParentCommentId(Integer parentCommentId) {
		this.parentCommentId = parentCommentId;
	}

	public void setDepth(Integer depth) {
		this.depth = depth;
	}

	
    public Integer getDepth() {
		return depth;
	}

	public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Timestamp updateAt) {
        this.updateAt = updateAt;
    }
}
