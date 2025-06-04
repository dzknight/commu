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

<style>
@charset "UTF-8";

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Noto Sans KR', Arial, sans-serif;
    background-color: #f8f9fa;
    color: #343a40;
    line-height: 1.6;
}

.container {
    max-width: 1280px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}

/* 게시판 페이지 스타일 */
.content-wrapper {
    margin-top: 40px;
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
}
#boardTable {
    width: 100%;
    border: 1px solid #dee2e6;
    border-collapse: collapse;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    background-color: #fff;
    border-radius: 8px;
    overflow: hidden;
}
#boardTable th {
    background-color: #007bff;
    color: #fff;
    padding: 12px;
    border: 1px solid #dee2e6;
    font-weight: 600;
}
#boardTable td {
    padding: 12px;
    border: 1px solid #dee2e6;
    text-align: center;
}
#boardTable tr:nth-child(odd) {
    background-color: #f8f9fa;
}
#boardTable tr:nth-child(even) {
    background-color: #fff;
}
#boardTable td:first-child {
    background-color: transparent !important;
    color: #343a40;
}
#boardTable td a {
    color: #007bff;
    text-decoration: none;
}
#boardTable td a:hover {
    text-decoration: underline;
}
.empty-message {
    text-align: center;
    padding: 20px;
    color: #6c757d;
    font-style: italic;
    font-size: 16px;
}
.empty-message a {
    color: #fff;
    background-color: #007bff;
    padding: 8px 16px;
    border-radius: 4px;
    text-decoration: none;
}
.empty-message a:hover {
    background-color: #0056b3;
}
.controls-container {
    display: flex;
    justify-content: flex-end;
    width: 100%;
    margin-top: 15px;
    align-items: center;
}
.write-button {
    background-color: #007bff;
    color: #fff;
    padding: 8px 16px;
    border-radius: 4px;
    text-decoration: none;
    transition: background-color 0.2s;
}
.write-button:hover {
    background-color: #0056b3;
}

/* 페이지네이션 스타일 */
.pagination {
    margin-top: 24px;
    text-align: center;
}
.pagination a {
    margin: 0 8px;
    padding: 6px 12px;
    color: #007bff;
    text-decoration: none;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    font-size: 14px;
    transition: background-color 0.2s;
}
.pagination a:hover:not(.active) {
    background-color: #e9ecef;
}
.pagination span {
    margin: 0 8px;
    padding: 6px 12px;
    background-color: #007bff;
    color: #fff;
    border: 1px solid #007bff;
    border-radius: 4px;
    font-size: 14px;
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
    #boardTable {
        font-size: 13px;
    }
    #boardTable th, #boardTable td {
        padding: 8px;
    }
    .controls-container {
        justify-content: center;
    }
    .pagination a, .pagination span {
        padding: 6px 10px;
        font-size: 12px;
    }
}
</style>
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