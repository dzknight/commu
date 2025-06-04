<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
.reply-link, .edit-link, .delete-link, .updateCommentBtn,
	.deleteCommentBtn, .like-btn, .dislike-btn, .replyCommentBtn {
	color: #fff !important;
	text-decoration: none !important;
	border: none;
	cursor: pointer;
	font-size: 14px;
	padding: 5px 10px;
	margin: 0 5px;
	border-radius: 4px;
	transition: all 0.3s ease;
}

.reply-link:visited, .edit-link:visited, .delete-link:visited,
	.updateCommentBtn:visited, .deleteCommentBtn:visited, .like-btn:visited,
	.dislike-btn:visited, .replyCommentBtn:visited {
	color: #fff !important;
}

.reply-link:hover, .edit-link:hover, .delete-link:hover,
	.updateCommentBtn:hover, .deleteCommentBtn:hover, .replyCommentBtn:hover
	{
	transform: translateY(-1px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	text-decoration: none;
}

.like-btn:hover {
	background-color: #218838;
	transform: translateY(-1px);
	box-shadow: 0 2px 5px rgba(40, 167, 69, 0.3);
}

.dislike-btn:hover {
	background-color: #c82333;
	transform: translateY(-1px);
	box-shadow: 0 2px 5px rgba(220, 53, 69, 0.3);
}

.replyCommentBtn {
	background-color: #6c757d;
}

.updateCommentBtn {
	background-color: #ffc107;
}

.deleteCommentBtn {
	background-color: #dc3545;
}

.like-btn {
	background-color: #28a745;
}

.dislike-btn {
	background-color: #dc3545;
}

.update-form, .reply-form {
	margin-top: 10px;
	display: none;
}

.update-form textarea, .reply-form textarea {
	width: 100%;
	max-width: 500px;
	height: 100px;
	border: 1px solid #ccc;
	border-radius: 4px;
	padding: 5px;
	margin-bottom: 5px;
}

.update-form textarea:focus, .reply-form textarea:focus {
	outline: none;
	border-color: #666;
}

.update-form button, .reply-form button {
	margin-right: 5px;
}

.comment {
	background: #f8fbff;
	padding: 10px 15px;
	margin-bottom: 12px;
	border-radius: 6px;
	transition: background 0.2s;
}

.comment.reply {
	margin-left: 40px;
	background: #f1f3f5;
	border-left: 4px solid #6c757d;
	padding-left: 15px;
	border-radius: 6px;
	position: relative;
}

.reply-label {
	color: #6c757d;
	font-weight: bold;
	margin-right: 5px;
}

.reply-action-btn {
	background-color: #6c757d;
	color: #fff;
	border: none;
	border-radius: 4px;
	padding: 5px 12px;
	margin-right: 5px;
	cursor: pointer;
	transition: background 0.2s, box-shadow 0.2s;
	font-size: 14px;
}

.reply-action-btn:hover {
	background-color: #495057;
	box-shadow: 0 2px 5px rgba(108, 117, 125, 0.2);
}

.update-action-btn {
	background-color: #ffc107;
	color: #212529;
	border: none;
	border-radius: 4px;
	padding: 5px 12px;
	margin-right: 5px;
	cursor: pointer;
	transition: background 0.2s, box-shadow 0.2s;
	font-size: 14px;
}

.update-action-btn:hover {
	background-color: #e0a800;
	box-shadow: 0 2px 5px rgba(255, 193, 7, 0.2);
}
</style>
<title>댓글 목록</title>
</head>
<body>
	<h3>댓글</h3>
	<div id="commentSection">
		<c:forEach var="comment" items="${commentList}">
			<c:if test="${comment.parentCommentId == null}">
				<!-- 부모 댓글 출력 -->
				<div class="comment" id="comment${comment.commentId}">
					<b>${fn:escapeXml(comment.userId)}</b> <span style="color: gray;">
						<fmt:formatDate value="${comment.createdAt}"
							pattern="yyyy-MM-dd HH:mm" timeZone="Asia/Seoul" />
					</span>
					<div>depth: ${comment.depth}</div>
					<div id="commentContent${comment.commentId}">
						${fn:escapeXml(comment.content)}</div>
					<c:if test="${!comment.deleted}">
						<c:if test="${!empty sessionScope.loginUser}">
							<button type="button" class="replyCommentBtn"
								data-comment-id="${comment.commentId}">답글</button>
						</c:if>
						<c:if test="${sessionScope.loginUser.userId eq comment.userId}">
							<button type="button" class="updateCommentBtn"
								data-comment-id="${comment.commentId}">수정</button>
							<button type="button" class="deleteCommentBtn"
								data-comment-id="${comment.commentId}">삭제</button>
						</c:if>
					</c:if>
					<!-- 댓글 수정 폼 -->
					<c:if
						test="${sessionScope.loginUser.userId eq comment.userId && !comment.deleted}">
						<div class="update-form" id="updateForm${comment.commentId}"
							style="display: none;">
							<textarea id="updateContent${comment.commentId}">${fn:escapeXml(comment.content)}</textarea>
							<button type="button" class="submit-update update-action-btn"
								onclick="submitUpdateForm(${comment.commentId}, '${not empty post ? post.postNum : ''}')">수정
								완료</button>
							<button type="button" class="cancel-update update-action-btn"
								onclick="hideUpdateForm(${comment.commentId})">취소</button>
						</div>
					</c:if>
					<!-- 대댓글 작성 폼 -->
					<c:if test="${!empty sessionScope.loginUser}">
						<div class="reply-form" id="replyForm${comment.commentId}"
							style="display: none;">
							<textarea id="replyContent${comment.commentId}"
								placeholder="대댓글을 입력하세요."></textarea>
							<button type="button" class="submit-reply reply-action-btn"
								onclick="submitReplyComment(${comment.commentId}, '${not empty post ? post.postNum : ''}')">답글
								등록</button>
							<button type="button" class="cancel-reply reply-action-btn"
								onclick="hideReplyCommentForm(${comment.commentId})">취소</button>
						</div>
					</c:if>
					<!-- 대댓글(답글) 출력: 부모 댓글 아래에만 붙임 -->
					<c:forEach var="reply" items="${commentList}">
						<c:if test="${reply.parentCommentId == comment.commentId}">
							<div class="comment reply" style="margin-left: 40px;"
								id="comment${reply.commentId}">
								<b>${fn:escapeXml(reply.userId)}</b> <span style="color: gray;">
									<fmt:formatDate value="${reply.createdAt}"
										pattern="yyyy-MM-dd HH:mm" timeZone="Asia/Seoul" />
								</span>
								<div>depth: ${reply.depth}</div>
								<div id="commentContent${reply.commentId}">
									<span style="color: #6c757d;">[답글] </span>
									${fn:escapeXml(reply.content)}
								</div>
								<c:if test="${!reply.deleted}">
									<c:if test="${sessionScope.loginUser.userId eq reply.userId}">
										<button type="button" class="updateCommentBtn"
											data-comment-id="${reply.commentId}">수정</button>
										<button type="button" class="deleteCommentBtn"
											data-comment-id="${reply.commentId}">삭제</button>
									</c:if>
								</c:if>
								<!-- 대댓글 수정 폼 -->
								<c:if
									test="${sessionScope.loginUser.userId eq reply.userId && !reply.deleted}">
									<div class="update-form" id="updateForm${reply.commentId}"
										style="display: none;">
										<textarea id="updateContent${reply.commentId}">${fn:escapeXml(reply.content)}</textarea>
										<button type="button" class="submit-update update-action-btn"
											onclick="submitUpdateForm(${reply.commentId}, '${not empty post ? post.postNum : ''}')">수정
											완료</button>
										<button type="button" class="cancel-update update-action-btn"
											onclick="hideUpdateForm(${reply.commentId})">취소</button>
									</div>
								</c:if>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</c:if>
		</c:forEach>
	</div>
</body>
</html>
