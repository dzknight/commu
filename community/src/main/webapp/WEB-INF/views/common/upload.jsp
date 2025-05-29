<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>파일 업로드</title>
</head>
<body>
<%@ include file="top.jsp"%>
    <h2>파일 업로드</h2>
    
    <c:if test="${not empty message}">
        <div style="color: red; margin-bottom: 10px;">
            ${message}
        </div>
    </c:if>
    
    <form method="post" action="${pageContext.request.contextPath}/upload" 
          enctype="multipart/form-data">
        <div>
            <label for="files">파일 선택 (다중 선택 가능):</label>
            <input type="file" id="files" name="files" multiple required>
        </div>
        <div style="margin-top: 10px;">
            <button type="submit">업로드</button>
            <a href="${pageContext.request.contextPath}/files">파일 목록</a>
        </div>
    </form>
</body>
</html>