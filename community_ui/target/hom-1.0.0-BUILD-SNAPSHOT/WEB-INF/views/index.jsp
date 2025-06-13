<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="커뮤니티 중심의 소셜 플랫폼">
<title>커뮤니티 메인</title>
<script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" defer></script>
<style>

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

/* 메인 콘텐츠 스타일 */
.main-content {
    flex: 3;
    background-color: #fff;
    border-radius: 8px;
    padding: 24px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}
.main-title {
    font-size: 28px;
    margin-bottom: 24px;
    color: #343a40;
}
.section-title {
    font-size: 20px;
    margin-bottom: 16px;
    color: #343a40;
    border-bottom: 2px solid #007bff;
    padding-bottom: 8px;
}
.trending-list {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 16px;
    margin-bottom: 16px;
}
.trending-card {
    background-color: #f8f9fa;
    padding: 12px;
    border-radius: 6px;
    transition: transform 0.2s, box-shadow 0.2s;
}
.trending-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}
.trending-card a {
    font-size: 14px;
    color: #007bff;
    text-decoration: none;
    font-weight: 500;
}
.trending-card a:hover {
    text-decoration: underline;
}
.video-list {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 16px;
    margin-top: 16px;
}
.video-card {
    background-color: #f8f9fa;
    padding: 12px;
    border-radius: 6px;
    transition: transform 0.2s, box-shadow 0.2s;
}
.video-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}
.video-card a {
    font-size: 14px;
    color: #007bff;
    text-decoration: none;
    font-weight: 500;
}
.video-card a:hover {
    text-decoration: underline;
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
    .main-content {
        flex: 1;
        width: 100%;
    }
    .trending-list {
        grid-template-columns: 1fr;
    }
    .video-list {
        grid-template-columns: repeat(2, 1fr);
    }
}
</style>
</head>
<body>
<div class="container">
    <%@ include file="./common/top.jsp" %>
    <main class="main-content">
        <h3 class="main-title">BugBuster 메인</h3>
        <section class="post-section">
            <h4 class="section-title">IT뉴스</h4>
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
        </section>
        <section class="trending-section">
            <h4 class="section-title">Q&A</h4>
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
        </section>
        <section class="video-section">
            <h4 class="section-title">커뮤니티</h4>
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