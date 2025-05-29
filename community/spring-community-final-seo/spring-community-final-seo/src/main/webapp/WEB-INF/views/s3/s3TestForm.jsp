<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AWS S3 업로드 테스트</title>
</head>
<body>
<%@ include file="../common/top.jsp"%>
    <h2>AWS S3 파일 업로드 테스트</h2>

    <form method="post" action="${pageContext.request.contextPath}/s3test/upload" enctype="multipart/form-data">
        <input type="file" name="file" required />
        <button type="submit">업로드</button>
    </form>

    <c:if test="${not empty errorMessage}">
        <p style="color: red;">${errorMessage}</p>
    </c:if>
</body>
</html>