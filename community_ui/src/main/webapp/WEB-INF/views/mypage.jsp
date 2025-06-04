<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="./common/top.jsp" %>
<div id="middle">
    <div id="my">
    <c:choose>
     <c:when test="${not empty sessionScope.loginUser}">
        <span id="name"><strong>${sessionScope.loginUser.userId}</strong>님</span>
     </c:when>
     <c:otherwise>
    	 <span>로그인이 필요합니다</span>
     </c:otherwise>
    </c:choose>
        <button id="update">프로필 수정</button>
        <a href="${pageContext.request.contextPath}/passreset" class="btn btn-mypage"><i class="fas fa-user"></i> 비번 재설정</a> 
    </div>
    <div id="scrap">
        <div id="data">

        </div>
        <span id="scraptext"><strong>${sessionScope.loginUser.userId}</strong>님의 스크랩북</span>
    </div>
    </div>
    <div id="dawn">
     <button id="setting">계정 설정</button>
<div id="dash">
    <span>대시보드</span>
</div>
</div>
</body>
</html>