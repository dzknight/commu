<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<title>게시글 상세보기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
@charset "UTF-8";

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Noto Sans KR', Arial, sans-serif;
    background: #f7f8fa;
    color: #343a40;
    line-height: 1.6;
}

.container {
    max-width: 900px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}

/* 게시글 상세 페이지 스타일 */
.post-container {
    background: #fff;
    margin: 40px auto;
    padding: 30px 40px 40px 40px;
    border-radius: 18px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.04);
    max-width: 800px;
}
.post-title {
    font-size: 28px;
    font-weight: bold;
    color: #1565c0;
    margin-bottom: 10px;
}
.post-title span {
    color: #007bff;
    font-weight: bold;
}
.post-meta {
    font-size: 13px;
    color: #888;
    margin-bottom: 16px;
    display: flex;
    gap: 18px;
}
.post-content {
    font-size: 16px;
    margin-bottom: 18px;
    background: #fafbfc;
    border-radius: 8px;
    padding: 20px;
    color: #222;
    border-left: 4px solid #007bff;
    white-space: pre-wrap;
}
.post-content span {
    font-weight: bold;
    color: #007bff;
    display: block;
    margin-bottom: 5px;
}
.post-attach-content {
    margin-top: 20px;
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    justify-content: flex-start;
}
.post-attach-content img {
    max-width: 150px;
    max-height: 150px;
    border-radius: 6px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    object-fit: cover;
    cursor: pointer;
    transition: transform 0.2s;
}
.post-attach-content img:hover {
    transform: scale(1.05);
}
.actions {
    margin-top: 12px;
    display: flex;
    gap: 10px;
}
.actions .btn {
    font-size: 15px;
    padding: 7px 20px;
    border-radius: 6px;
}
.actions .btn-success {
    background: #1976d2;
    color: #fff;
    border: none;
}
.actions .btn-warning {
    background: #e53935;
    color: #fff;
    border: none;
}
.btn {
    padding: 8px 16px;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    text-decoration: none;
    color: #fff;
    display: inline-flex;
    align-items: center;
    gap: 6px;
    transition: background-color 0.2s;
}
.btn:hover {
    filter: brightness(90%);
}
.btn-postLike {
    background: #2196f3;
    color: #fff;
    border: none;
    border-radius: 5px;
    padding: 7px 18px;
    font-size: 15px;
    cursor: pointer;
}
.btn-postLike:hover {
    background: #1769aa;
}
.likebtn {
    margin-top: 30px;
    display: flex;
    gap: 15px;
    justify-content: flex-start;
}
#likeCount {
    margin-left: 10px;
    color: #1976d2;
    font-weight: bold;
}
.comment-write {
    margin: 30px 0 0 0;
}
#commentForm {
    display: flex;
    flex-direction: column;
    gap: 10px;
    max-width: 100%;
}
#commentForm textarea {
    width: 100%;
    min-height: 70px;
    resize: vertical;
    font-size: 1em;
    padding: 10px;
    box-sizing: border-box;
}
#commentForm .btn, #commentForm button[type="submit"] {
    align-self: flex-end;
    padding: 8px 18px;
    font-size: 1em;
    background-color: #1976d2;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}
#commentForm .btn:hover, #commentForm button[type="submit"]:hover {
    background-color: #1565c0;
}
.comment-section {
    margin-top: 24px;
}
.comment-section h3 {
    margin-bottom: 15px;
    font-size: 17px;
    color: #1976d2;
}
.comment {
    border-bottom: 1px solid #eee;
    padding: 10px 0 6px 0;
    background: #fafbfc;
    border-radius: 4px;
    margin-bottom: 8px;
}
.comment.reply {
    background: #f3f6fa;
    margin-left: 30px;
}
.reply-link {
    color: #1976d2;
    font-size: 0.95em;
    margin-left: 8px;
    cursor: pointer;
    text-decoration: underline;
}
.reply-link:hover {
    color: #0d47a1;
}

/* 푸터 스타일 */
.footer {
    background-color: #343a40;
    color: #fff;
    padding: 20px 0;
    text-align: center;
    margin-top: 40px;
    width: 100%;
}
.footer-links a {
    color: #adb5bd;
    margin: 0 12px;
    text-decoration: none;
    font-size: 14px;
}
.footer-links a:hover {
    color: #fff;
}
.footer p {
    font-size: 13px;
    margin-top: 8px;
    color: #adb5bd;
}

/* 반응형 디자인 */
@media (max-width: 900px) {
    .container {
        flex-direction: column;
    }
    .post-container {
        margin: 20px auto;
        padding: 20px;
    }
    .post-title {
        font-size: 24px;
    }
    .post-content {
        font-size: 14px;
    }
    .post-meta {
        font-size: 12px;
        gap: 10px;
    }
    .post-attach-content img {
        max-width: 120px;
        max-height: 120px;
    }
    .actions a, .btn-postLike {
        padding: 6px 12px;
        font-size: 12px;
    }
}
</style>
</head>
<body>
    <div class="container">
        <%@ include file="../common/top.jsp"%>
        <div class="post-container">
            <div class="post-title">
                제목 <c:out value="${post.title}" />
            </div>
            <div class="post-meta">
                <span>작성자 <c:out value="${post.writer}" /></span>
                <span>작성일시 <fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd" /></span>
                <span>조회수 <c:out value="${post.views}" /></span>
                <span id="likeCount">좋아요수 ${totalLikeCount}</span>
            </div>
            <div class="post-content">
                <span style="font-weight: bold; color: #1565c0;">내용</span><br>
                <c:out value="${post.content}" />
            </div>
            <div class="post-attach-content">
                <c:forEach var="item" items="${attachList}">
                    <img src="${pageContext.request.contextPath}/download?filename=${item}" alt="첨부 이미지">
                </c:forEach>
            </div>
            <div class="actions">
                <c:if test="${sessionScope.loginUser.userId eq post.writer}">
                    <a href="${pageContext.request.contextPath}/modify?postNum=${post.postNum}&writer=${post.writer}"
                        class="btn btn-success"><i class="fa-regular fa-pen-to-square"></i> 수정</a>
                    <a href="${pageContext.request.contextPath}/delete?postNum=${post.postNum}&writer=${post.writer}"
                        class="btn btn-warning"><i class="fa-solid fa-trash"></i> 삭제</a>
                </c:if>
            </div>
            <div class="likebtn">
                <c:if test="${!empty loginUser}">
                    <button type="button" class="btn btn-postLike" data-post-num="${post.postNum}">
                        <i class="fa-regular fa-thumbs-up" id="like"></i> 좋아요
                    </button>
                </c:if>
            </div>
            <!-- 댓글 작성 폼 -->
            <div class="comment-write">
                <c:if test="${!empty loginUser}">
                    <form id="commentForm" method="post"
                        action="${pageContext.request.contextPath}/commentWrite">
                        <input type="hidden" name="postNum" value="${post.postNum}" />
                        <input type="hidden" name="parentCommentId" value="" id="parentCommentId" />
                        <textarea name="content" id="commentContent" rows="3"
                            placeholder="댓글을 입력하세요" onfocus="this.placeholder=''"
                            onblur="this.placeholder='댓글을 입력하세요'"></textarea>
                        <button type="submit" class="btn btn-primary">댓글 등록</button>
                    </form>
                </c:if>
                <c:if test="${empty loginUser}">
                    <div class="alert alert-warning">댓글을 작성하려면 로그인하세요.</div>
                </c:if>
            </div>
            <div id="commentSection">
                <%@ include file="/WEB-INF/views/getuseds/commentSection.jsp" %>
            </div>
        </div>
    </div>
    <footer class="footer">
        <div class="footer-links">
            <a href="#">이용약관</a> | <a href="#">개인정보처리방침</a> | <a href="#">고객센터</a>
        </div>
        <p>© 2025 커뮤니티. All rights reserved.</p>
    </footer>
	<script>
	function loadComments() {
	        $.ajax({
	            type: "GET",
	            url: "${pageContext.request.contextPath}/commentSection",
	            data: { postNum: "${post.postNum}" },
	            success: function(html) {
	                $('#commentSection').html(html);
	            }
	        });
	    }
	 
	$(document).ready(function() {
        $('#commentForm').submit(function(e) {
            e.preventDefault();
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/commentWrite",
                data: $(this).serialize(),
                dataType: "json",
                success: function(response) {
                    if(response.success) {
                        $('#commentContent').val("");
                        $('#parentCommentId').val("");
                        loadComments();
                    } else {
                        alert(response.message || "댓글 등록 실패");
                    }
                },
                error: function() {
                    alert("댓글 등록 중 오류가 발생했습니다.");
                }
            });
        });
	    function loadLikeStatus(postNum) {
			$.ajax({
				url: '${pageContext.request.contextPath}/getMyLikeStatus',
				type: 'POST',
				data: { postNum: postNum },
				dataType: 'json',
				success: function(data) {
					if (data.result === 'success') {
						$('#like')
							.toggleClass('fa-regular', data.status !== 'like')
							.toggleClass('fa-solid', data.status === 'like');
					} else if (data.reason === 'loginRequired') {
						alert('해당 기능은 로그인이 필요합니다.');
					}
				},
				error: function(xhr, status, error) {
					console.error('좋아요 상태 조회 실패:', xhr.responseText);
				}
			});
			$.ajax({
				url: '${pageContext.request.contextPath}/getTotalLikeCount',
				type: 'POST',
				data: { postNum: postNum },
				dataType: 'json',
				success: function(data) {
					if (data.result === 'success') {
						$('#likeCount').text('좋아요수 ' + data.totalLikeCount);
					}
				},
				error: function(xhr, status, error) {
					console.error('총 좋아요 수 조회 실패:', xhr.responseText);
				}
			});
		}
		$('.btn-postLike').click(function() {
			let postNum = $(this).data('post-num');
			$.ajax({
				url: '${pageContext.request.contextPath}/postLike',
				type: 'POST',
				data: { postNum: postNum },
				dataType: 'json',
				success: function(data) {
					if (data.result === 'success') {
						$('#like')
							.toggleClass('fa-regular', data.status !== 'like')
							.toggleClass('fa-solid', data.status === 'like');
						$.ajax({
							url: '${pageContext.request.contextPath}/getTotalLikeCount',
							type: 'POST',
							data: { postNum: postNum },
							dataType: 'json',
							success: function(data) {
								if (data.result === 'success') {
									$('#likeCount').text('좋아요수 ' + data.totalLikeCount);
								}
							},
							error: function(xhr, status, error) {
								console.error('총 좋아요 수 조회 실패:', xhr.responseText);
							}
						});
					} else if (data.reason === 'loginRequired') {
						alert('로그인이 필요합니다.');
					} else {
						alert('좋아요 처리 중 오류가 발생했습니다.');
					}
				},
				error: function(xhr, status, error) {
					console.error('좋아요 처리 실패:', xhr.responseText);
				}
			});
		});
		let postNum = ${post.postNum};
		loadLikeStatus(postNum);
	});
	</script>
</body>
</html>