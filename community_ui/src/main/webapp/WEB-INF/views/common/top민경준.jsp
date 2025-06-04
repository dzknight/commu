<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Community Header</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
<c:if test="${not empty message}">
    alert('${message}');
</c:if>
$(document).ready(function() {
    const contextPath = "${pageContext.request.contextPath}";
    $('#loginBtn').click(function() {
        const userId = $('#userId').val();
        const userPassword = $('#userPassword').val();
        $.ajax({
            type: 'POST',
            url: contextPath + '/loginAccount',
            data: { userId, userPassword },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    alert('로그인 성공');
                    location.reload();
                } else {
                    alert('로그인 실패: 아이디 또는 비밀번호를 확인하세요.');
                }
            },
            error: function(xhr, status, error) {
                alert('로그인 중 오류가 발생했습니다: ' + error);
            }
        });
    });
});


$(document).ready(function() {
    const contextPath = "${pageContext.request.contextPath}";
    $('#logoutBtn').click(function(e) {
        e.preventDefault(); // a 태그의 기본 이동 동작 막기
        $.ajax({
            type: 'POST',
            url: contextPath + '/logout',
            success: function(response) {
                if(response.success){
                    alert("로그아웃");
                    location.reload();
                }
            },
            error: function(xhr, status, error) {
                alert('로그아웃 중 오류가 발생했습니다: ' + error);
            }
        });
    });
});


</script>
</head>
<body>
<header class="header">
    <div class="header-inner">
        <a href="${pageContext.request.contextPath}/" class="logo">
            <p class="logo-img">BugBuster</p>
        </a>
        <div class="login-area">
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <div class="user-info">
                        <span class="user-id"><strong>${sessionScope.loginUser.userId}</strong>님</span>
                        <a href="${pageContext.request.contextPath}/mypage" class="btn btn-mypage"><i class="fas fa-user"></i> 마이페이지</a>
                        <a href="${pageContext.request.contextPath}/logout" id="logoutBtn" class="btn btn-logout"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <form id="loginForm" class="login-form">
                        <input type="text" id="userId" name="userId" placeholder="아이디" class="input-field">
                        <input type="password" id="userPassword" name="userPassword" placeholder="비밀번호" class="input-field">
                        <button type="button" class="btn btn-login" id="loginBtn"><i class="fas fa-sign-in-alt"></i> 로그인</button>
                        <a href="${pageContext.request.contextPath}/signup" class="btn btn-signup"><i class="fas fa-user-plus"></i> 회원가입</a>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>
<div class="search-bar">
    <form action="${pageContext.request.contextPath}/searchContent" method="post" class="search-form">
        <select name="searchField" class="select-field">
            <option value="0">선택</option>
            <option value="title">제목</option>
            <option value="userId">작성자</option>
        </select>
        <input type="text" name="searchText" placeholder="검색어를 입력하세요" maxlength="100" class="input-field">
        <button type="submit" class="btn btn-search"><i class="fas fa-search"></i></button>
    </form>
</div>
<nav class="nav">
    <div class="nav-inner">
        <ul class="nav-menu">
            <li><a href="${pageContext.request.contextPath}/freeBoard">IT뉴스</a></li>
            <li><a href="${pageContext.request.contextPath}/fleaMarket">Q&A</a></li>
            <li><a href="${pageContext.request.contextPath}/gallery">커뮤니티</a></li>
        </ul>
    </div>
</nav>
</body>
</html>