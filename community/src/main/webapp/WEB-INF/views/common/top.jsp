<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<title>비밀번호 재설정</title>
</head>
<style>
ul li {
	display:inline-block;
	width:100px;
}
</style>
<body>
	<header>
		<h3>휴먼 홈페이지</h3>
	</header>
	<nav>
		<ul>
			<li><a href="${pageContext.request.contextPath}/memberjoin">회원가입</a></li>
			<li><a href="${pageContext.request.contextPath}/list">회원 전체보기</a></li>
			<li><a href="${pageContext.request.contextPath}/upload">첨부파일 올리기</a></li>
			<li><a href="${pageContext.request.contextPath}/email">이메일쓰기</a></li>
			<li><a href="${pageContext.request.contextPath}/passreset"> 회원 비밀번호 재설정테스트</a></li>
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