<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>카카오 로그인</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
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

/* 헤더 스타일 */
.header {
    background-color: #fff;
    padding: 15px 0;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    position: sticky;
    top: 0;
    z-index: 100;
    width: 100%;
}
.header-inner {
    max-width: 1280px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 20px;
}
.logo-img {
    height: 36px;
}
.login-area {
    display: flex;
    align-items: center;
}
.login-form {
    display: flex;
    align-items: center;
    gap: 8px;
}
.user-info {
    display: flex;
    align-items: center;
    gap: 12px;
    font-size: 14px;
}
.input-field {
    padding: 8px;
    border: 1px solid #ced4da;
    border-radius: 4px;
    font-size: 14px;
    width: 140px;
    transition: border-color 0.2s;
}
.input-field:focus {
    outline: none;
    border-color: #007bff;
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
.btn-login, .btn-search, .btn-success {
    background-color: #007bff;
}
.btn-signup, .btn-mypage {
    background-color: #28a745;
}
.btn-logout, .btn-warning {
    background-color: #dc3545;
}
.btn:hover {
    filter: brightness(90%);
}
.btn-postLike {
    background-color: #ff6b6b;
}
.btn-postLike:hover {
    background-color: #e63946;
}

/* 검색 바 스타일 */
.search-bar {
    background-color: #fff;
    padding: 12px 0;
    border-bottom: 1px solid #e9ecef;
    width: 100%;
}
.search-form {
    max-width: 600px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    gap: 8px;
}
.select-field {
    padding: 8px;
    border: 1px solid #ced4da;
    border-radius: 4px;
    font-size: 14px;
    width: 120px;
}
.search-form .input-field {
    width: 100%;
    max-width: 300px;
}

/* 네비게이션 스타일 */
.nav {
    background-color: #fff;
    padding: 12px 0;
    border-bottom: 1px solid #e9ecef;
    width: 100%;
}
.nav-inner {
    max-width: 1280px;
    margin: 0 auto;
    padding: 0 20px;
}
.nav-menu {
    list-style: none;
    display: flex;
    gap: 24px;
    justify-content: center;
}
.nav-menu li a {
    text-decoration: none;
    color: #495057;
    font-size: 16px;
    font-weight: 500;
    transition: color 0.2s;
}
.nav-menu li a:hover {
    color: #007bff;
}

/* 반응형 디자인 */
@media (max-width: 900px) {
    .header-inner, .search-form, .login-form {
        flex-direction: column;
        align-items: stretch;
        gap: 12px;
    }
    .login-form .input-field, .login-form .btn {
        width: 100%;
    }
    .search-form .input-field, .search-form .select-field, .search-form .btn {
        width: 100%;
    }
    .nav-menu {
        flex-wrap: wrap;
        gap: 16px;
    }
}
</style>
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
</script>
</head>
<body>
<header class="header">
    <di class="header-inner">
        <a href="${pageContext.request.contextPath}/" class="logo">
            <p class="logo-img">BugBuster</p>
        </a>
         <header>
        <c:choose>
            <c:when test="${not empty sessionScope.loginMember}">
                <div class="user-info">
                    <span>안녕하세요, <strong>${sessionScope.loginMember.userName}</strong>님!</span>
                    <c:if test="${sessionScope.loginMember.loginType == 'KAKAO'}">
                        <span class="kakao-badge">카카오톡 로그인</span>
                    </c:if>
                    <a href="/logout" style="margin-left: 10px;">로그아웃</a>
                </div>
            </c:when>
            <c:otherwise>
                <a href="/login">로그인</a>
            </c:otherwise>
        </c:choose>
    </header>
        <a href="javascript:loginWithKakao()">
            <img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="222" alt="카카오 로그인 버튼" />
        </a>
        <script>
            Kakao.init('86ef5b0f9e204aa70b13ea8bb47de612'); // 카카오 앱의 JavaScript 키

            function loginWithKakao() {
                Kakao.Auth.authorize({
                    redirectUri: 'http://localhost:8090/hom2/'
                });
            }
        </script>
        
        <div class="login-area">
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <div class="user-info">
                        <span class="user-id"><strong>${sessionScope.loginUser.userId}</strong>님</span>
                        <a href="${pageContext.request.contextPath}/mypage" class="btn btn-mypage"><i class="fas fa-user"></i> 마이페이지</a> 
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
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