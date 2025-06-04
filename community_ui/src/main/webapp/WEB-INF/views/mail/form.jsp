<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이메일 보내기</title>
</head>
<body>
    <form action="${pageContext.request.contextPath}/sendmail" method="post">
        <h2>이메일 보내기</h2>
        <table>
            <tr>
                <td>수신자 이메일:</td>
                <td><input type="email" name="address" id="address" required></td>
            </tr>
            <tr>
                <td>제목:</td>
                <td><input type="text" name="title" id="title" required></td>
            </tr>
            <tr>
                <td>내용:</td>
                <td><textarea name="message"  id="message" rows="5" cols="40" required></textarea></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="전송"></td>
            </tr>
        </table>
        <span style="color:red;">${message}</span>
    </form>
</body>
</html>