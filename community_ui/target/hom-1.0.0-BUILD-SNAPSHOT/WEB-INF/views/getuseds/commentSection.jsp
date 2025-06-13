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

	<title>댓글 목록</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commentSection.css">
</head>
<body>
<div id="commentSection">
	<c:forEach var="comment" items="${commentList}">
		<c:if test="${comment.parentCommentId == null}">
			<!-- 부모 댓글 출력 -->
			<div class="comment" id="comment${comment.commentId}">
				<b>${fn:escapeXml(comment.userId)}</b> <span style="color: gray;">
						<fmt:formatDate value="${comment.createdAt}"
										pattern="yyyy-MM-dd HH:mm" timeZone="Asia/Seoul" />
					</span>
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
								onclick="submitUpdateForm(${comment.commentId}, ${comment.depth })">수정
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
				<!-- 대댓글 출력: 부모 댓글 아래 붙임 -->
				<c:forEach var="reply" items="${commentList}">
					<c:if test="${reply.parentCommentId == comment.commentId}">
						<div class="comment reply" style="margin-left: 50px;"
							 id="comment${reply.commentId}">
							<b>${fn:escapeXml(reply.userId)}</b> <span style="color: gray;">
									<fmt:formatDate value="${reply.createdAt}"
													pattern="yyyy-MM-dd HH:mm" timeZone="Asia/Seoul" />
								</span>
							<div style="display: none;">depth: ${reply.depth}</div>
							<div id="commentContent${reply.commentId}">
								<span class="reply-label">답글</span>
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
											onclick="submitUpdateForm(${reply.commentId}, ${reply.depth})">수정
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
