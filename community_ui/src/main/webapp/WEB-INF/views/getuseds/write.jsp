<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 작성/수정</title>
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

/* 게시글 작성/수정 페이지 스타일 */
.write-form-container {
    background-color: #fff;
    padding: 30px 40px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    width: 100%;
    max-width: 600px;
    margin: 40px auto;
}
.write-form-container h2 {
    text-align: center;
    color: #343a40;
    margin-bottom: 25px;
    font-size: 24px;
}
.write-form-container table {
    width: 100%;
    border-collapse: collapse;
}
.write-form-container td {
    padding: 12px 0;
}
.write-form-container input[type="text"],
.write-form-container input[type="number"],
.write-form-container textarea,
.write-form-container select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ced4da;
    border-radius: 4px;
    box-sizing: border-box;
    font-size: 14px;
    font-family: inherit;
    transition: border-color 0.2s;
}
.write-form-container input[type="text"]:focus,
.write-form-container input[type="number"]:focus,
.write-form-container textarea:focus,
.write-form-container select:focus {
    border-color: #007bff;
    outline: none;
}
.write-form-container textarea {
    resize: vertical;
    min-height: 150px;
}
.write-form-container select {
    appearance: none;
    background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12"><path fill="%23333" d="M6 9l-4-4h8z"/></svg>') no-repeat right 10px center;
    background-size: 12px;
    padding-right: 30px;
}
.write-form-container input[type="file"] {
    display: block;
    margin-bottom: 12px;
    font-size: 14px;
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
.btn-success {
    background-color: #007bff;
}
.btn-warning {
    background-color: #dc3545;
}
.btn:hover {
    filter: brightness(90%);
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
    .write-form-container {
        padding: 20px;
        margin: 10px auto;
    }
    .write-form-container h2 {
        font-size: 20px;
    }
    .write-form-container input[type="text"],
    .write-form-container input[type="number"],
    .write-form-container textarea,
    .write-form-container select,
    .write-form-container button {
        font-size: 13px;
    }
}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" defer></script>
</head>
<body>
<div class="container">
    <%@ include file="../common/top.jsp"%>
    <div class="write-form-container">
        <h2>
            <c:choose>
                <c:when test="${not empty boardVO}">
                    게시글 수정
                </c:when>
                <c:otherwise>
                    게시글 작성
                </c:otherwise>
            </c:choose>
        </h2>

        <form action="${pageContext.request.contextPath}${not empty boardVO ? '/modify' : '/insertContent'}"
              method="post"
              id="frm"
              enctype="multipart/form-data">

            <c:if test="${not empty boardVO}">
                <input type="hidden" name="postNum" value="${boardVO.postNum}" />
            </c:if>

            <table>
                <tr>
                    <td>
                        <input type="text" id="title" name="title" placeholder="제목을 입력하세요"
                               value="${boardVO.title != null ? boardVO.title : ''}"
                               onfocus="this.placeholder=''" onblur="this.placeholder='제목을 입력하세요'">
                    </td>
                </tr>
                <tr>
                    <td>
                        <textarea id="content" name="content" placeholder="내용을 입력하세요"
                                  onfocus="this.placeholder=''" onblur="this.placeholder='내용을 입력하세요'"
                                  rows="10" cols="50">${boardVO.content != null ? boardVO.content : ''}</textarea>
                    </td>
                </tr>
              
            
                <tr>
                    <td>
                        <input type="file" name="file">
                        <c:if test="${not empty boardVO.filename}">
                            <p>현재 업로드된 파일: ${boardVO.filename}</p>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;">
                        <button type="submit" class="btn btn-success">등록</button>
                        <button type="reset" class="btn btn-warning">취소</button>
                    </td>
                </tr>
            </table>
        </form>
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