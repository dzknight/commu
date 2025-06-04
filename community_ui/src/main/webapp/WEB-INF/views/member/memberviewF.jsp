<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="ko_KR" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보</title>
    <style>
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
        }
        .profile-container {
            text-align: center;
            margin: 20px 0;
        }
        .profile-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #ddd;
        }
        .info-group {
            margin-bottom: 15px;
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        .info-label {
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
        .info-value {
            color: #666;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 5px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>회원 정보</h2>
        
        <!-- 프로필 사진 영역 -->
        <div class="profile-container">
            <c:choose>
                <c:when test="${not empty member.profile_img && member.profile_img != 'default.jpg'}">
                    <img src="${pageContext.request.contextPath}/resources/uploads/${member.profile_img}" 
                         class="profile-image" alt="프로필 사진">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/resources/images/default.jpg" 
                         class="profile-image" alt="기본 프로필">
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="info-group">
            <div class="info-label">아이디</div>
            <div class="info-value">${member.userId}</div>
        </div>
        
        <div class="info-group">
            <div class="info-label">이름</div>
            <div class="info-value">${member.userName}</div>
        </div>
        
        <div class="info-group">
            <div class="info-label">이메일</div>
            <div class="info-value">${member.userEmail}</div>
        </div>
        
        <div class="info-group">
            <div class="info-label">전화번호</div>
            <div class="info-value">
            <c:set var="phone" value="${member.userPhoneNum}" />
				<c:if test="${fn:length(phone) eq 11}">
				    ${fn:substring(phone, 0, 3)}-${fn:substring(phone, 3, 7)}-${fn:substring(phone, 7, 11)}
				</c:if>
            </div>
        </div>
        
        <div class="info-group">
            <div class="info-label">생년월일</div>
            <div class="info-value">
	        <c:choose>
			<c:when test="${not empty member.birthdate}">
			        <c:set var="formattedDate">
			            <fmt:formatDate value="${member.birthdate}" pattern="yyyy-MM-dd"/>
			        </c:set>
			        ${formattedDate}
			    </c:when>
			    <c:otherwise>
			        <c:set var="formattedDate" value="정보 없음"/>
			        ${formattedDate}
			    </c:otherwise>
	        </c:choose>
            </div>
        </div>
        
        <div class="info-group">
            <div class="info-label">주소</div>
            <div class="info-value">
                (${member.zipCode}) ${member.address} ${member.detailAddress}
            </div>
        </div>
        
        <div class="info-group">
            <div class="info-label">가입일</div>
            <div class="info-value">
                <fmt:formatDate value="${member.regDate}" pattern="yyyy-MM-dd"/>
            </div>
        </div>
        
        <div style="text-align: center; margin-top: 30px;">
            <a href="${pageContext.request.contextPath}/membermod" class="btn btn-primary">
                정보 수정
            </a>
        </div>
    </div>
</body>
</html>