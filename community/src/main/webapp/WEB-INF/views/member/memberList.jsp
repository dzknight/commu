<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 목록</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
        .profile-img { width: 50px; height: 50px; border-radius: 50%; }
    </style>
</head>
<body>
    <h2>회원 목록</h2>
    
    <table>
        <thead>
            <tr>
                <th>프로필</th>
                <th>아이디</th>
                <th>이름</th>
                <th>이메일</th>
                <th>가입일</th>
                <th>상세보기</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="member" items="${memberList}">
                <tr>
                    <td>
                        <c:if test="${not empty member.profileImagePath}">
                            <img src="/upload/profile/${member.profileImagePath}" 
                                 alt="프로필" class="profile-img">
                        </c:if>
                        <c:if test="${empty member.profileImagePath}">
                            <img src="/resources/images/default-profile.png" 
                                 alt="기본프로필" class="profile-img">
                        </c:if>
                    </td>
                    <td>${member.userid}</td>
                    <td>${member.username}</td>
                    <td>${member.fullEmail}</td>
                    <td>${member.regDate}</td>
                    <td>
                        <a href="/member/detail/${member.userid}">상세보기</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <div style="margin-top: 20px;">
        <a href="/">회원가입</a>
    </div>
</body>
</html>