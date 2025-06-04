<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" defer></script>
</head>
<body>
<div class="container">
    <%@ include file="../common/top.jsp"%>
    <div class="content-wrapper">
        <table id="boardTable">
            <tr>
                <th>글 번호</th>
                <th>작성자</th>
                <th>제목</th>
                <th>작성일시</th>
          
            </tr>
            <tbody>
                <c:if test="${empty contentlist}">
                    <tr>
                        <td colspan="7" class="empty-message">게시글이 없습니다. 
                         
                        </td>
                    </tr>
                </c:if>
                <c:forEach var="item" items="${contentlist}" varStatus="status">
                    <tr>
                        <td>
                            <a href="${pageContext.request.contextPath}/textview?postNum=${item.postNum}">
                                <c:out value="${fn:length(contentlist) - status.index}" />
                            </a>
                        </td>
                        <td><c:out value="${item.writer}" /></td>
                        <td><c:out value="${item.title}" /></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.createdAt}">
                                    <fmt:formatDate value="${item.createdAt}" pattern="yyyy-MM-dd" />
                                </c:when>
                                <c:otherwise>날짜 없음</c:otherwise>
                            </c:choose>
                        </td>
                  
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="pagination">
            <c:if test="${paging.page > 1}">
                <a href="${pageContext.request.contextPath}/paging?page=${paging.page - 1}">[이전]</a>
            </c:if>
            <c:if test="${paging.page <= 1}">
                <span>[이전]</span>
            </c:if>

            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
                <c:if test="${i > 0}">
                    <c:choose>
                        <c:when test="${i eq paging.page}">
                            <span>${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/paging?page=${i}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </c:forEach>

            <c:if test="${paging.page < paging.maxPage}">
                <a href="${pageContext.request.contextPath}/paging?page=${paging.page + 1}">[다음]</a>
            </c:if>
            <c:if test="${paging.page >= paging.maxPage}">
                <span>[다음]</span>
            </c:if>
        </div>

        <div class="controls-container">
            <a href="${pageContext.request.contextPath}/write" class="write-button">
                <i class="fas fa-pencil-alt"></i> 글쓰기
            </a>
        </div>
    </div>
</div>
<footer class="footer">
    <div class="footer-links">
        <a href="#">이용약관</a> | <a href="#">개인정보처리방침</a> | <a href="#">고객센터</a>
    </div>
    <p>© 2025 커뮤니티. All rights reserved.</p>
</footer>
</body>
</html>