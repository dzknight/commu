<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 작성/수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
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