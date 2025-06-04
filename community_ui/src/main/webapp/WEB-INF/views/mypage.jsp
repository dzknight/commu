<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@charset "UTF-8";

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Noto Sans KR', Arial, sans-serif;
    background-color: #f8f9fa;
    color: #343a40;
    line-height: 1.6;
}

.container {
    max-width: 1280px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}

/* 마이페이지 스타일 */
#middle {
    display: flex;
    width: 100%;
    max-width: 1280px;
    margin: 40px auto;
    padding: 24px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    gap: 20px;
}
#my {
    border: 1px solid #dee2e6;
    width: 200px;
    height: 200px;
    text-align: center;
    border-radius: 6px;
    padding: 16px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}
#name {
    margin-top: 20px;
    display: block;
    font-size: 16px;
    font-weight: bold;
    color: #343a40;
}
#update {
    margin-top: 20px;
    width: 150px;
    padding: 8px 16px;
    background-color: #28a745;
    color: #fff;
    border: none;
    border-radius: 4px;
    font-size: 16px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.2s;
}
#update:hover {
    background-color: #218838;
}
#scrap {
    border: 1px solid #dee2e6;
    flex: 1;
    padding: 16px;
    border-radius: 6px;
    display: flex;
    flex-direction: column;
    gap: 10px;
}
#data {
    width: 50px;
    height: 50px;
    background-color: #f8f9fa;
    border-radius: 4px;
}
#scraptext {
    color: #007bff;
    font-size: 16px;
    font-weight: 500;
}
#dawn {
    display: flex;
    width: 100%;
    max-width: 1280px;
    margin: 0 auto 40px;
    padding: 0 24px;
    gap: 20px;
}
#setting {
    width: 200px;
    padding: 8px 16px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.2s;
}
#setting:hover {
    background-color: #0056b3;
}
#dash {
    border: 1px solid #dee2e6;
    flex: 1;
    padding: 16px;
    border-radius: 6px;
    text-align: center;
    font-size: 16px;
    color: #343a40;
}

/* 푸터 스타일 */
.footer {
    background-color: #343a40;
    color: #fff;
    padding: 20px 0;
    text-align: center;
    margin-top: 40px;
    width: 100%;
}
.footer-links a {
    color: #adb5bd;
    margin: 0 12px;
    text-decoration: none;
    font-size: 14px;
}
.footer-links a:hover {
    color: #fff;
}
.footer p {
    font-size: 13px;
    margin-top: 8px;
    color: #adb5bd;
}

/* 반응형 디자인 */
@media (max-width: 900px) {
    .container {
        flex-direction: column;
    }
    #middle {
        flex-direction: column;
        margin: 20px auto;
        padding: 20px;
    }
    #my, #scrap, #dash {
        width: 100%;
        margin-left: 0;
    }
    #dawn {
        flex-direction: column;
        margin: 0 auto 20px;
        padding: 0 20px;
    }
    #setting {
        width: 100%;
    }
}
</style>
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
	        <span id="scraptext">${sessionScope.loginUser.userId}님의 좋아요</span>
	    </div>
	</div>
	<div id="dawn">
	    <button id="setting">회원 탈퇴</button>
	    <div id="dash">
	        <span>총 조회수: ${totalview != null ? totalview : 0},받은 좋아요 수</span>
	    </div>
	</div>
	<footer class="footer">
	    <div class="footer-links">
	        <a href="#">이용약관</a> | <a href="#">개인정보처리방침</a> | <a href="#">고객센터</a>
	    </div>
	    <p>© 2025 커뮤니티. All rights reserved.</p>
	</footer>
</body>
</html>