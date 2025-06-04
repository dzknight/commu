<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="커뮤니티 중심의 소셜 플랫폼">
<title>커뮤니티 메인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" defer></script>
</head>
<body>
<div class="container">
    <%@ include file="./common/top.jsp" %>
    <main class="main-content">
        <h3 class="main-title">커뮤니티 메인</h3>
        <section class="post-section">
            <h4 class="section-title">오버뷰</h4>
            <div class="overview-content">
                <div class="overview-item">
                    <h5>지금 스벨트(Svelte)를 배워야 하는 이유</h5>
                    <p>최신 프레임워크 동향과 스벨트의 장점을 알아보세요.</p>
                </div>
            </div>
        </section>
        <section class="trending-section">
            <h4 class="section-title">트렌딩</h4>
            <div class="trending-list">
                <div class="trending-card">
                    <a href="#">AI로 코딩 배우기</a>
                </div>
                <div class="trending-card">
                    <a href="#">Svelte로 웹사이트 만들기</a>
                </div>
                <div class="trending-card">
                    <a href="#">Windos 11 튜토리얼</a>
                </div>
                <div class="trending-card">
                    <a href="#">Figjam 활용법</a>
                </div>
                <div class="trending-card">
                    <a href="#">Figma로 UI 디자인</a>
                </div>
            </div>
            <div class="notification-bar">
                <span>12시간 전 올라온 최신 콘텐츠를 확인하세요!</span>
            </div>
        </section>
        <section class="video-section">
            <h4 class="section-title">동영상 인기 영상</h4>
            <div class="video-list">
                <div class="video-card"><a href="#">동영상 1</a></div>
                <div class="video-card"><a href="#">동영상 2</a></div>
                <div class="video-card"><a href="#">동영상 3</a></div>
                <div class="video-card"><a href="#">동영상 4</a></div>
                <div class="video-card"><a href="#">동영상 5</a></div>
                <div class="video-card"><a href="#">동영상 6</a></div>
                <div class="video-card"><a href="#">동영상 7</a></div>
                <div class="video-card"><a href="#">동영상 8</a></div>
                <div class="video-card"><a href="#">동영상 9</a></div>
                <div class="video-card"><a href="#">동영상 10</a></div>
                <div class="video-card"><a href="#">동영상 11</a></div>
                <div class="video-card"><a href="#">동영상 12</a></div>
            </div>
        </section>
    </main>
</div>
<footer class="footer">
    <div class="footer-links">
        <a href="#">이용약관</a> | <a href="#">개인정보처리방침</a> | <a href="#">고객센터</a>
    </div>
    <p>© 2025 커뮤니티. All rights reserved.</p>
</footer>
</body>
</html>