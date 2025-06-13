<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<style>
body {
	margin: 0;
	font-family: 'Arial', sans-serif;
	background-color: #f5f5f5;
}

.container {
	max-width: 800px;
	margin: 100px auto;
	padding: 30px;
	background-color: #fff;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.post-title {
	font-size: 28px;
	font-weight: bold;
	margin-bottom: 20px;
	color: #333;
}

.post-title span {
	color: #007bff;
	font-weight: bold;
}

.post-meta {
	font-size: 14px;
	color: #666;
	margin-bottom: 20px;
}

.post-meta span {
	margin-right: 20px;
}

.post-content {
	font-size: 17px;
	line-height: 1.8;
	margin-bottom: 30px;
	white-space: pre-wrap;
	border-left: 4px solid #007bff;
	padding-left: 12px;
	background-color: #f9f9f9;
	padding: 10px;
	border-radius: 6px;
}

.post-content span {
	font-weight: bold;
	color: #007bff;
	display: block;
	margin-bottom: 5px;
}

.post-info {
	margin-top: 20px;
	font-size: 15px;
}

.price {
	font-weight: bold;
	color: #007bff;
}

.status {
	color: #28a745;
	font-weight: bold;
}

.actions {
	margin-top: 30px;
	display: flex;
	gap: 15px;
}

.actions a {
	text-decoration: none;
	color: white;
	background-color: #007bff;
	padding: 10px 16px;
	border-radius: 8px;
	transition: 0.3s;
}

.actions a:hover {
	background-color: #0056b3;
}

/* 좋아요/채팅하기 버튼 */
.likechat {
	margin-top: 30px;
	display: flex;
	gap: 20px;
	justify-content: center;
}

.likechat button {
	padding: 12px 24px;
	font-size: 16px;
	border: 2px solid transparent;
	border-radius: 10px;
	cursor: pointer;
	transition: all 0.3s ease;
	font-weight: bold;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
	min-width: 120px; /* 버튼 크기 통일 */
}

#likebtn {
	background-color: #ff6b6b;
	color: white;
	border-color: #ff6b6b;
}

#likebtn:hover {
	background-color: #e63946;
	border-color: #e63946;
}

#chatbtn {
	background-color: #007bff;
	color: white;
	border-color: #007bff;
}

#chatbtn:hover {
	background-color: #0056b3;
	border-color: #0056b3;
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
	border-radius: 10px;
	box-shadow: 0 2px 8px rgba(0,0,0,0.1);
	object-fit: cover;
	cursor: pointer;
	transition: transform 0.3s ease;
}

.post-attach-content img:hover {
	transform: scale(1.05);
	box-shadow: 0 4px 12px rgba(0,0,0,0.2);
}
</style>
</head>
<body>

	<%@ include file="../common/top.jsp"%>

	<div class="container">
		<div class="post-title"><span>글 제목: </span>${post.title}</div>

		<div class="post-meta">
			<span>작성자: ${post.writer}</span>
			<span>작성일시: <fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd" /></span>
		</div>

		<div class="post-content"><span>글 내용: </span>${post.content}</div>

		<div class="post-attach-content">
			<c:forEach var="item" items="${attachList}">
				<img src="download?filename=${item}">
			</c:forEach>
		</div>

		<div class="post-info">
			<p class="price">판매금액: ${post.price}원</p>
			<p class="status">판매상태: ${post.saleStatus}</p>
		</div>

		<div class="actions">
			<a href="${pageContext.request.contextPath}/edit?postNum=${post.postNum}">수정</a>
			<a href="${pageContext.request.contextPath}/delete?postNum=${post.postNum}">삭제</a>
		</div>

		<div class="likechat">
			<button id="likebtn">좋아요</button>
			<button id="chatbtn">채팅하기</button>
		</div>
	</div>

</body>
</html>
