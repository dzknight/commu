<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>카카오 회원 추가정보 입력</title>
</head>
<body>
    <h2>카카오 회원가입 - 추가정보 입력</h2>
    
    <p><strong>${member.userName}</strong>님, 카카오 로그인이 완료되었습니다.</p>
    <p>서비스 이용을 위해 추가 정보를 입력해주세요.</p>
    
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>
    
    <form action="/kakao/additional-info" method="post">
        <div>
            <label>전화번호:</label>
            <input type="tel" name="userPhoneNumber" required>
        </div>
        <div>
            <label>우편번호:</label>
            <input type="text" name="zipcode">
        </div>
        <div>
            <label>주소:</label>
            <input type="text" name="address">
        </div>
        <div>
            <label>상세주소:</label>
            <input type="text" name="detailAddress">
        </div>
        <div>
            <label>생년월일:</label>
            <input type="date" name="birthDate" required>
        </div>
        
        <button type="submit">회원가입 완료</button>
    </form>
</body>
</html>