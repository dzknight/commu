<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 상세정보</title>
    <style>
        .member-detail { max-width: 600px; margin: 0 auto; padding: 20px; }
        .profile-section { text-align: center; margin-bottom: 30px; }
        .profile-img { width: 150px; height: 150px; border-radius: 50%; border: 3px solid #ddd; }
        .info-table { width: 100%; border-collapse: collapse; }
        .info-table th, .info-table td { 
            border: 1px solid #ddd; 
            padding: 12px; 
            text-align: left; 
        }
        .info-table th { 
            background-color: #f2f2f2; 
            width: 30%; 
            font-weight: bold; 
        }
        .btn-group { text-align: center; margin-top: 20px; }
        .btn { 
            padding: 10px 20px; 
            margin: 0 5px; 
            text-decoration: none; 
            border-radius: 5px; 
            display: inline-block; 
        }
        .btn-primary { background-color: #007bff; color: white; }
        .btn-secondary { background-color: #6c757d; color: white; }
        .btn-danger { background-color: #dc3545; color: white; }
    </style>
</head>
<body>
    <div class="member-detail">
        <h2>회원 상세정보</h2>
        
        <!-- 프로필 사진 섹션 -->
        <div class="profile-section">
            <c:if test="${not empty member.profileImagePath}">
                <img src="/upload/profile/${member.profileImagePath}" 
                     alt="프로필 사진" class="profile-img">
            </c:if>
            <c:if test="${empty member.profileImagePath}">
                <img src="/resources/images/default-profile.png" 
                     alt="기본 프로필" class="profile-img">
            </c:if>
        </div>
        
        <!-- 회원 정보 테이블 -->
        <table class="info-table">
            <tr>
                <th>아이디</th>
                <td>${member.userid}</td>
            </tr>
            <tr>
                <th>이름</th>
                <td>${member.username}</td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>${member.fullEmail}</td>
            </tr>
            <tr>
                <th>가입일</th>
                <td>
                    <fmt:formatDate value="${member.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
            </tr>
            <tr>
                <th>프로필 이미지</th>
                <td>
                    <c:if test="${not empty member.profileImagePath}">
                        ${member.profileImagePath}
                    </c:if>
                    <c:if test="${empty member.profileImagePath}">
                        등록된 프로필 이미지가 없습니다.
                    </c:if>
                </td>
            </tr>
        </table>
        
        <!-- 버튼 그룹 -->
        <div class="btn-group">
            <a href="/member/edit/${member.userid}" class="btn btn-primary">정보수정</a>
            <a href="/member/list" class="btn btn-secondary">목록으로</a>
            <a href="/member/delete/${member.userid}" 
               class="btn btn-danger" 
               onclick="return confirm('정말로 삭제하시겠습니까?')">회원탈퇴</a>
        </div>
    </div>
</body>
</html>