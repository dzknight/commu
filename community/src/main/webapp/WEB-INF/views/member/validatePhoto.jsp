<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>프로필 사진 검증 결과</title>
    <meta charset="UTF-8">
    <style>
        .validation-result {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            border-radius: 10px;
        }
        .success {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }
        .error {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }
        .warning {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            color: #856404;
        }
        .file-info {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
        }
        .btn {
            padding: 10px 20px;
            margin: 10px 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
    </style>
</head>
<body>
    <div class="validation-result">
        <h2>프로필 사진 검증 결과</h2>
        
        <c:if test="${not empty error}">
            <div class="error">
                <h3>오류</h3>
                <p>${error}</p>
            </div>
        </c:if>
        
        <c:if test="${not empty validation}">
            <div class="${validation.valid ? 'success' : 'error'}">
                <h3>${validation.valid ? '검증 성공' : '검증 실패'}</h3>
                <p>${validation.message}</p>
                
                <c:if test="${not empty validation.warning}">
                    <div class="warning" style="margin-top: 10px;">
                        <strong>주의사항:</strong> ${validation.warning}
                    </div>
                </c:if>
            </div>
            
            <div class="file-info">
                <h4>파일 정보</h4>
                <p><strong>파일명:</strong> ${fileName}</p>
                <p><strong>파일 크기:</strong> ${Math.round(fileSize / 1024)} KB</p>
            </div>
            
            <div style="text-align: center; margin-top: 30px;">
                <c:choose>
                    <c:when test="${validation.valid}">
                        <a href="javascript:window.close();" class="btn btn-primary">확인</a>
                        <a href="${pageContext.request.contextPath}/member/join" class="btn btn-secondary">회원가입 계속</a>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:window.close();" class="btn btn-secondary">닫기</a>
                        <a href="${pageContext.request.contextPath}/member/join" class="btn btn-primary">다시 선택</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
    </div>
</body>
</html>