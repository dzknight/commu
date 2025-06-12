<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <title>게시글 상세보기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/detailview.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
<div class="container">
    <%@ include file="../common/top.jsp"%>
    <div class="post-container">
        <!-- 기술스택 태그 -->
        <c:if test="${not empty post.programmingLanguage}">
            <div class="language-tag">
                <i class="fas fa-code"></i>
                <span><c:out value="${post.programmingLanguage}" /></span>
            </div>
        </c:if>

        <div class="post-title">
            <c:out value="${post.title}" />
        </div>

        <div class="post-meta">
            <span><i class="fas fa-user"></i> 작성자: <c:out value="${post.writer}" /></span>
            <span><i class="fas fa-calendar"></i> 작성일:
					<fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm" />
				</span>
            <span><i class="fas fa-eye"></i> 조회수: <c:out value="${post.views}" /></span>
            <span id="likeCount"><i class="fas fa-heart"></i> 좋아요: ${totalLikeCount}</span>
        </div>

        <div class="post-content">
            <span class="post-content-label"><i class="fas fa-align-left"></i> 질문 내용</span>
            <div style="white-space: pre-wrap;"><c:out value="${post.content}" /></div>
        </div>

        <c:if test="${not empty attachList}">
            <div class="post-attach-content">
                <c:forEach var="item" items="${attachList}">
                    <img src="${pageContext.request.contextPath}/download?filename=${item}" alt="첨부 이미지">
                </c:forEach>
            </div>
        </c:if>

        <div class="actions">
            <c:if test="${sessionScope.loginUser.userId eq post.writer}">
                <a href="${pageContext.request.contextPath}/modify?postNum=${post.postNum}&writer=${post.writer}"
                   class="btn btn-success">
                    <i class="fas fa-edit"></i> 수정
                </a>
                <a href="${pageContext.request.contextPath}/delete?postNum=${post.postNum}&writer=${post.writer}"
                   class="btn btn-warning" onclick="return confirm('정말 삭제하시겠습니까?')">
                    <i class="fas fa-trash"></i> 삭제
                </a>
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
                    <input type="hidden" name="parentCommentId" value="0" id="parentCommentId" />
                    <textarea name="content" id="commentContent" rows="3"
                              placeholder="댓글을 입력하세요" onfocus="this.placeholder=''"
                              onblur="this.placeholder='댓글을 입력하세요'"></textarea>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-paper-plane"></i> 댓글 등록
                    </button>
                </form>
            </c:if>
        </div>

        <div class="comment-section">
            <h3><i class="fas fa-comments"></i> 댓글</h3>
            <div id="commentSection">
                <%@ include file="/WEB-INF/views/getuseds/commentSection.jsp"%>
            </div>
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
    $('#commentForm').submit(function(e) {
        e.preventDefault();
        $.ajax({
            type : "POST",
            url : "${pageContext.request.contextPath}/commentWrite",
            data : $(this).serialize(),
            dataType : "json",
            success : function(response) {
                if (response.success) {
                    $('#commentContent').val("");
                    $('#parentCommentId').val(0);
                    loadComments();
                } else {
                    alert(response.message || "댓글 등록 실패");
                }
            },
            error : function() {
                alert("댓글 등록 중 오류가 발생했습니다.");
            }
        });
    });

    function loadLikeStatus(postNum) {
        $.ajax({
            url : '${pageContext.request.contextPath}/getMyLikeStatus',
            type : 'POST',
            data : { postNum : postNum },
            dataType : 'json',
            success : function(data) {
                if (data.result === 'success') {
                    $('#like').toggleClass('fa-regular', data.status !== 'like')
                        .toggleClass('fa-solid', data.status === 'like');
                } else if (data.reason === 'loginRequired') {
                    alert('해당 기능은 로그인이 필요합니다.');
                }
            },
            error : function(xhr, status, error) {
                console.error('좋아요 상태 조회 실패:', xhr.responseText);
            }
        });

        $.ajax({
            url : '${pageContext.request.contextPath}/getTotalLikeCount',
            type : 'POST',
            data : { postNum : postNum },
            dataType : 'json',
            success : function(data) {
                if (data.result === 'success') {
                    $('#likeCount').html('<i class="fas fa-heart"></i> 좋아요: ' + data.totalLikeCount);
                }
            },
            error : function(xhr, status, error) {
                console.error('총 좋아요 수 조회 실패:', xhr.responseText);
            }
        });
    }

    $('.btn-postLike').click(function() {
        let postNum = $(this).data('post-num');
        $.ajax({
            url : '${pageContext.request.contextPath}/postLike',
            type : 'POST',
            data : { postNum : postNum },
            dataType : 'json',
            success : function(data) {
                if (data.result === 'success') {
                    $('#like').toggleClass('fa-regular', data.status !== 'like')
                        .toggleClass('fa-solid', data.status === 'like');

                    $.ajax({
                        url : '${pageContext.request.contextPath}/getTotalLikeCount',
                        type : 'POST',
                        data : { postNum : postNum },
                        dataType : 'json',
                        success : function(data) {
                            if (data.result === 'success') {
                                $('#likeCount').html('<i class="fas fa-heart"></i> 좋아요: ' + data.totalLikeCount);
                            }
                        }
                    });
                } else if (data.reason === 'loginRequired') {
                    alert('로그인이 필요합니다.');
                } else {
                    alert('좋아요 처리 중 오류가 발생했습니다.');
                }
            },
            error : function(xhr, status, error) {
                console.error('좋아요 처리 실패:', xhr.responseText);
            }
        });
    });

    let postNum = ${post.postNum};
    loadLikeStatus(postNum);

    function loadComments() {
        $.ajax({
            type : "GET",
            url : "${pageContext.request.contextPath}/commentSection",
            data : { postNum : "${post.postNum}" },
            success : function(html) {
                $('#commentSection').html(html);
            },
            error : function(xhr, status, error) {
                console.error("댓글 로드 실패:", xhr.responseText || error);
                alert('댓글 로드 중 오류가 발생했습니다.');
            }
        });
    }

    $(document).on('click', '.deleteCommentBtn', function() {
        var commentId = $(this).data('comment-id');
        if (confirm('정말 삭제하시겠습니까?')) {
            $.ajax({
                type : "POST",
                url : "${pageContext.request.contextPath}/deleteComment",
                data : { commentId : commentId },
                success : function(response) {
                    if (response.success) {
                        loadComments();
                        alert('댓글이 삭제되었습니다.');
                    } else {
                        alert(response.message || "삭제 실패");
                    }
                },
                error : function(xhr, status, error) {
                    alert('댓글 삭제 중 오류가 발생했습니다.');
                }
            });
        }
    });

    function showUpdateForm(commentId) {
        $('#updateForm' + commentId).show();
        $('.update-form').not('#updateForm' + commentId).hide();
        $('.reply-form').hide();
    }

    function hideUpdateForm(commentId) {
        $('#updateForm' + commentId).hide();
    }

    $(document).on('click', '.replyCommentBtn', function() {
        var commentId = $(this).data('comment-id');
        showReplyCommentForm(commentId);
    });

    $(document).on('click', '.updateCommentBtn', function() {
        var commentId = $(this).data('comment-id');
        showUpdateForm(commentId);
    });

    function showReplyCommentForm(commentId) {
        console.log(commentId);
        $('#replyForm' + commentId).show();
        $('.reply-form').not('#replyForm' + commentId).hide();
        $('.update-form').hide();
        $('#replyContent' + commentId).focus();
    }

    function hideReplyCommentForm(commentId) {
        $('#replyForm' + commentId).hide();
    }

    function submitUpdateForm(commentId, depth) {
        var urlParams = new URLSearchParams(window.location.search);
        var postNum = urlParams.get('postNum');

        console.log('수정 요청 - commentId:', commentId, 'postNum:', postNum, 'depth:', depth);
        var updateContent = $('#updateContent' + commentId).val();
        if (!updateContent.trim()) {
            alert('수정할 댓글 내용을 입력해주세요.');
            $('#updateContent' + commentId).focus();
            return false;
        }

        $.ajax({
            type : 'POST',
            url : '${pageContext.request.contextPath}/updateComment',
            contentType : 'application/json; charset=utf-8',
            dataType : 'json',
            data : JSON.stringify({
                content : updateContent,
                commentId : commentId,
                postNum : postNum,
                depth: depth
            }),
            success : function(data) {
                if (data.success || data === 'UpdateSuccess') {
                    alert('댓글이 수정되었습니다!');
                    loadComments();
                    hideUpdateForm(commentId);
                } else {
                    alert('댓글 수정에 실패했습니다: ' + (data.message || ''));
                }
            },
            error : function(xhr, status, error) {
                console.error("수정 실패:", xhr.responseText || error);
                alert('통신 실패');
            }
        });

        return false;
    }

    function submitReplyComment(parentCommentId, postNum) {
        var replyContent = $('#replyContent' + parentCommentId).val();
        console.log("parentCommentId(JS):", parentCommentId);
        if (!replyContent.trim()) {
            alert('대댓글 내용을 입력해주세요.');
            $('#replyContent' + parentCommentId).focus();
            return false;
        }

        $.ajax({
            type : 'POST',
            url : '${pageContext.request.contextPath}/commentReply',
            contentType : 'application/json; charset=utf-8',
            dataType : 'json',
            data : JSON.stringify({
                content : replyContent,
                parentCommentId : parentCommentId,
                postNum : postNum
            }),
            success : function(data) {
                if (data.success) {
                    alert('대댓글이 등록되었습니다!');
                    $('#replyContent' + parentCommentId).val('');
                    loadComments();
                    hideReplyCommentForm(parentCommentId);
                } else {
                    alert('대댓글 등록에 실패했습니다: ' + (data.message || ''));
                }
            },
            error : function(xhr, status, error) {
                console.error("대댓글 등록 실패:", xhr.responseText || error);
                alert('통신 실패');
            }
        });

        return false;
    }
</script>
</body>
</html>
