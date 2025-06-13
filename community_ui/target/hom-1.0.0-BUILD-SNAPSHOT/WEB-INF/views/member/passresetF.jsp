<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호재설정</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 20px;
    }
    h1 {
        color: #333;
    }
    form {
        background-color: #fff;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    label {
        display: block;
        margin-bottom: 10px;
    }
    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    button {
        padding: 10px 15px;
        background-color: #28a745;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    button:hover {
        background-color: #218838;
    }
    .error {
        color: red;
    }
    .success {
        color: green;
    }
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

</head>
<body>
<h1>비밀번호 재설정</h1>
<form action="${pageContext.request.contextPath}/resetPassword" method="post"  >
    <label for="userid">유저아이디:</label>
    <input type="text" name="userid" id="userid" class="uclass"  value="${sessionScope.loginUser.userId}"  required readonly />
    <br>
    <!--기존 비밀번호를 입력하고 db와 비교하는 로직을 추가-->
    <label for="oldPassword">이전 비밀번호 :</label>
    <input type="password" id="oldPassword" name="oldPassword" required>
    <br>
    <label for="newPassword">새 비밀번호 :</label>
    <input type="password" id="password" name="password" pattern=".{8,}" required>
    <br>
    <label for="confirmPassword">새 비밀번호 확인 :</label>
    <input type="password" id="confirmPassword" name="confirmPassword" pattern=".{8,}" required>
    <button type="submit" onclick="return validateForm()">비밀번호 재설정</button>
</form>
<!--newPassword가 confirmPassword와 일치하는지 확인하는 로직을 추가-->

<script>
// 새 비밀번호와 확인 비밀번호가 일치하는지 확인하는 로직
    document.querySelector('form').addEventListener('submit', function(event) {
        const newPassword = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (newPassword !== confirmPassword) {
            event.preventDefault();
            alert('새 비밀번호와 확인 비밀번호가 일치해야 합니다.');
        }
    });
    // 아이디 입력란에 대한 유효성 검사
    document.querySelector('.uclass').addEventListener('input', function() {
        this.value = this.value.replace(/[^a-zA-Z0-9]/g, '');
    });
    // 비밀번호 입력란에 대한 유효성 검사

    function validateForm() {
        const oldPassword = document.getElementById('oldPassword').value;
        const newPassword = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (newPassword !== confirmPassword) {
            alert('새 비밀번호는 확인 비밀번호와 일치해야 합니다.');
            return false;
        }
        if (oldPassword === newPassword) {
            alert('새 비밀번호는 이전 비밀번호와 같을 수 없습니다.');
            return false;
        }
        return true;
    }
</script>
</body>
</html>