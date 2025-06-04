<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">    
<head>
    <meta charset="UTF-8">
    <meta name="description" content="4조 단어 공부 테이블">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>4조 단어 공부 테이블</title>
    <link rel="stylesheet" href="./resources/css/common.css">

    <!-- 영어단어와 단어뜻을 구성하는 2차원 배열 단어장에서 랜덤으로 영어단어와 한글뜻을 테이블에 5개 동적으로 띄어주는 화면 -->
     <!--단어는 자바에서 랜덤으로 5개 동적으로 가져와서 테이블에 저장한다-->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
   
</head>

<header>
    <h1>단어 페이지에 오신 것을 환영합니다</h1>
</header>

<body>
    <div class="container">
        <h2>랜덤 단어 디스플레이</h2>
        <table id="vocabTable">
            <tr>
           		<th><input type="checkbox" id="checkall" onclick="selectAll()"></th>
                <th>영어단어</th>
                <th>한글뜻</th>
            </tr>
            <h2>검색결과</h2>
            <tbody id="order-table-body">

            	 <c:forEach var="word_dto" items="${word_list}">
            	 		<tr>
            	 		<td><input type="checkbox"></td>
			             <td>${word_dto.engWord}</td>
			            <td>${word_dto.korMean}</td>
			            </tr>
	            </c:forEach>
    
            </tbody>

        </table>
    </div>
    <div>
    <input type="button" value="삭제" id="delAll" >
     <input type="button" value="새로고침" id="refreshButton">
     
    </div>
    <script>

        
        // 삭제 버튼 클릭 이벤트
        $('#deleteButton').click(function() {
            $('#vocabTable tr').last().remove();
           
        });
        // 새로고침 버튼 클릭 이벤트
        $('#refreshButton').click(function() {
            location.reload();
            
        });
        function selectAll() {
            let checkboxes = document.querySelectorAll('input[type="checkbox"]');
            checkboxes.forEach(checkbox => {
                checkbox.checked = !checkbox.checked; // 체크박스 상태 반전
            });
        }
        document.getElementById('delAll').addEventListener('click',()=>{
            let checkboxes=document.querySelectorAll('input[type=checkbox]:checked');
                checkboxes.forEach(checkbox => {
                    checkbox.parentElement.parentElement.remove();//체크된 행 삭제
                });
        });
        </script>
</body>
</html>