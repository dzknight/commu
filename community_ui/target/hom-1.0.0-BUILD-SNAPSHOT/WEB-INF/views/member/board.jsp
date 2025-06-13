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
body {
	margin: 0;
	font-family: 'Arial', sans-serif;
	background-color: #f5f5f5;
	min-height: 100vh;
}

header {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	padding: 20px 40px;
	background-color: #fff;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.content-wrapper {
	margin-top: 140px;
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 100%;
}

#boardTable {
	width: 700px;
	border: 1px solid #ddd;
	border-collapse: collapse;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	background-color: #fff;
	border-radius: 8px;
	overflow: hidden;
}

#boardTable th {
	background-color: #007bff;
	color: #fff;
	padding: 12px;
	border: 1px solid #ddd;
	font-weight: 600;
}

#boardTable td {
	padding: 12px;
	border: 1px solid #ddd;
}

/* 홀수 행 배경색 */
#boardTable tr:nth-child(odd) {
	background-color: #fafafa;
}

/* 짝수 행 배경색 */
#boardTable tr:nth-child(even) {
	background-color: #f1f1f1;
}

/* 글 번호(td 첫번째 셀) 배경색 제거 */
#boardTable td:first-child {
	background-color: transparent !important;
	color: #000;
}

#boardTable th, #boardTable td {
	text-align: center;
}

.controls-container {
	display: flex;
	justify-content: flex-end;
	width: 700px;
	margin-top: 15px;
	align-items: center;
}

button {
	padding: 8px 16px;
	background-color: #007bff;
	color: #fff;
	font-weight: 600;
	border-radius: 12px;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s, transform 0.1s;
}

button:hover {
	background-color: #0056b3;
	transform: translateY(-1px);
}

a {
	text-decoration: none;
	color: #fff;
	background-color: #007bff;
	border-radius: 12px;
	font-weight: 600;
	padding: 8px 16px;
	display: inline-flex;
	align-items: center;
	transition: background-color 0.3s, transform 0.1s;
}

a:hover {
	background-color: #0056b3;
	color: #fff;
	transform: translateY(-1px);
}

.empty-message {
	text-align: center;
	padding: 20px;
	color: #666;
	font-style: italic;
	font-size: 16px;
}

.pagination {
	margin-top: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
}

.pagination a, .pagination span {
	padding: 8px 14px;
	border-radius: 8px;
	text-decoration: none;
	font-size: 14px;
	font-weight: 500;
	transition: all 0.3s ease;
}

.pagination a {
	color: #007bff;
	background-color: #fff;
	border: 1px solid #007bff;
}

.pagination a:hover {
	background-color: #007bff;
	color: #fff;
	border-color: #0056b3;
}

.pagination span {
	color: #fff;
	background-color: #007bff;
	border: 1px solid #007bff;
	cursor: default;
}

@media ( max-width : 768px) {
	#boardTable, .controls-container {
		width: 95%;
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
	.pagination {
		gap: 5px;
	}
	.pagination a, .pagination span {
		padding: 6px 10px;
		font-size: 12px;
	}
}

</style>

</head>
<body>

	<%@ include file="../common/top.jsp"%>

	<div class="content-wrapper">
		<table id="boardTable">
			<tr>
				<th>글 번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성일시</th>
				<th>가격</th>
				<th>판매상태</th>
			</tr>
			<tbody>
				<c:if test="${empty contentlist}">
					<tr>
						<td colspan="7" class="empty-message">게시글이 없습니다. <a
							href="${pageContext.request.contextPath}/write">지금 글을 작성해보세요!</a></td>
					</tr>
				</c:if>
				<c:forEach var="item" items="${contentlist}">
					<tr>
						<td>
							<a href="${pageContext.request.contextPath}/textview?postNum=${item.postNum}">
								<c:out value="${item.postNum}" />
							</a>
						</td>
						<td><c:out value="${item.writer}" /></td>
						<td><c:out value="${item.title}" /></td>
						<td>
							<c:out value="${fn:substring(item.content, 0, 50)}" />
							<c:if test="${fn:length(item.content) > 50}">...</c:if>
						</td>
						<td>
							<c:choose>
								<c:when test="${not empty item.createdAt}">
									<fmt:formatDate value="${item.createdAt}" pattern="yyyy-MM-dd" />
								</c:when>
								<c:otherwise>날짜 없음</c:otherwise>
							</c:choose>
						</td>
						<td><c:out value="${item.price}" /></td>
						<td><c:out value="${item.saleStatus}" /></td>
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
				<i class="fa-solid fa-pencil"></i> 글쓰기
			</a>
		</div>
	</div>
</body>
</html>
