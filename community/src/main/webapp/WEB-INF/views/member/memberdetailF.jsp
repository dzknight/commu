<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>회원 상세정보</title>
    <meta charset="UTF-8">
    <style>
        .member-detail {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
        }
        .profile-section {
            text-align: center;
            margin-bottom: 30px;
        }
        .profile-image {
            width: 200px;
            height: 260px;
            border: 2px solid #ddd;
            border-radius: 10px;
            object-fit: cover;
        }
        .default-profile {
            width: 200px;
            height: 260px;
            border: 2px solid #ddd;
            border-radius: 10px;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
            font-size: 16px;
        }
        .member-info {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
        }
        .info-row {
            display: flex;
            margin-bottom: 10px;
        }
        .info-label {
            font-weight: bold;
            width: 100px;
            color: #495057;
        }
        .info-value {
            flex: 1;
        }
    </style>
</head>
<body>
    <div class="member-detail">
        <h2>회원 상세정보</h2>
        
        <div class="profile-section">
            <c:choose>
                <c:when test="${not empty fileAttach}">
                    <img src="${pageContext.request.contextPath}/resources/upload/${fileAttach.uploadPath}/${fileAttach.uuid}_${fileAttach.filename}" 
                         alt="프로필 사진" class="profile-image">
                    <p><small>여권 규격 프로필 사진</small></p>
                    <p><small>파일명: ${fileAttach.filename}</small></p>
                    <p><small>파일 크기: ${fileAttach.fileSize} bytes</small></p>
                </c:when>
                <c:otherwise>
                    <div class="default-profile">
                        프로필 사진 없음
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="member-info">
            <div class="info-row">
                <span class="info-label">아이디:</span>
                <span class="info-value">${member.memberId}</span>
            </div>
            <div class="info-row">
                <span class="info-label">이름:</span>
                <span class="info-value">${member.name}</span>
            </div>
            <div class="info-row">
                <span class="info-label">이메일:</span>
                <span class="info-value">${member.email}</span>
            </div>
            <div class="info-row">
                <span class="info-label">전화번호:</span>
                <span class="info-value">${member.phone}</span>
            </div>
            <div class="info-row">
                <span class="info-label">주소:</span>
                <span class="info-value">${member.address}</span>
            </div>
            <div class="info-row">
                <span class="info-label">가입일:</span>
                <span class="info-value">${member.regDate}</span>
            </div>
        </div>
        
        <div style="text-align: center; margin-top: 20px;">
            <a href="${pageContext.request.contextPath}/">홈으로</a>
        </div>
    </div>
</body>
</html>