<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>파일 목록</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<%@ include file="top.jsp"%>
    <h2>업로드된 파일 목록</h2>
    
    <div>
        <a href="${pageContext.request.contextPath}/upload">새 파일 업로드</a>
    </div>
    
    <c:if test="${not empty message}">
        <div style="color: green; margin: 10px 0;">
            ${message}
        </div>
    </c:if>
    
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>파일명</th>
                <th>파일 타입</th>
                <th>파일 크기</th>
                <th>업로드 경로</th>
                <th>업로드 날짜</th>
                <th>다운로드</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="file" items="${files}">
                <tr>
                    <td>${file.id}</td>
                    <td>${file.filename}</td>
                    <td>${file.filetype}</td>
                    <td>${file.fileSize} bytes</td>
                    <td>${file.uploadPath}</td>
                    <td>${file.uploadDate}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/resources/upload/${file.uploadPath}/${file.uuid}_${file.filename}" 
                           download="${file.filename}">다운로드</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <c:if test="${empty files}">
        <p>업로드된 파일이 없습니다.</p>
    </c:if>
    
</body>
</html>