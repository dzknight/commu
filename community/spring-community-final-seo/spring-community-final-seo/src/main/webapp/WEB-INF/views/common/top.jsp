<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
ul li {
	display: inline-block;
	width: 100px;
}
</style>
<body>
	<header>
		<h3>휴먼 홈페이지</h3>
	</header>
	<nav>
		<ul>
			<li><a href="${pageContext.request.contextPath}/memberjoin">회원가입</a></li>
			<li><a href="${pageContext.request.contextPath}/intoTxt">글쓰기</a></li>
			<li><a href="${pageContext.request.contextPath}/allMember">회원 전체보기</a></li>
			<li><a href="${pageContext.request.contextPath}/allWritingr">글 전체보기</a></li>
			<li><a href="${pageContext.request.contextPath}/email">이메일쓰기</a></li>
			<li><a href="${pageContext.request.contextPath}/s3test"> s3 업로드 테스트</a></li>
			<li><a href="${pageContext.request.contextPath}/membermod">회원정보 수정하기</a></li>
		</ul>
	</nav>
	<div>
		<h3>로그인</h3>
		<form action="${pageContext.request.contextPath}/login" method="post">
			<label for="id">아이디</label>
			id<input type="text" name="id" id="id" required>
			<label for="password">비밀번호</label>
			pass<input type="password" name="password" id="password" required>
			<input type="submit" value="로그인">
		</form>
		<span style="color: red;">
			<c:if test="${id != null}">
				${id} 로그인 중
			</c:if>
			<c:if test="${id == null}">
				<span><a href="${pageContext.request.contextPath}/logout">로그아웃</a></span>
			</c:if>
		</span>
	</div>
	<hr>
</body>
</html>