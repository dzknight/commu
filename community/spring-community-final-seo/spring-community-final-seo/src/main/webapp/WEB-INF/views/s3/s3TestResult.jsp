<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AWS S3 업로드 결과</title>
</head>
<body>
<%@ include file="../common/top.jsp"%>
    <h2>AWS S3 파일 업로드 결과</h2>

    <c:if test="${not empty successMessage}">
        <p style="color: green;">${successMessage}</p>
        <p>원본 파일명: ${originalFileName}</p>
        <p>S3 URL: <a href="${uploadedFileUrl}" target="_blank">${uploadedFileUrl}</a></p>
        <img src="${uploadedFileUrl}" alt="Uploaded Image" style="max-width: 300px; max-height: 300px;"/>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <p style="color: red;">${errorMessage}</p>
    </c:if>

    <p><a href="${pageContext.request.contextPath}/s3test">다시 테스트하기</a></p>
</body>
</html>