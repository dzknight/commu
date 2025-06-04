<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<!-- jQuery는 하나만 불러오도록 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
body {
	font-family: sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 40px 0;
	display: flex;
	justify-content: center;
	align-items: flex-start;
}

#signUpForm {
	background-color: #fff;
	padding: 30px 40px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	width: 500px;
}

#signUp td {
	padding: 10px 0;
	vertical-align: top;
}

#signUp label {
	display: block;
	font-weight: bold;
	margin-bottom: 5px;
}

#signUp input[type="text"], #signUp input[type="password"], #signUp input[type="email"],
	#signUp select {
	width: calc(100% - 20px);
	padding: 8px 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

#signUp input[readonly] {
	background-color: #e9ecef;
	cursor: not-allowed;
}

/* 버튼 2개 같은 줄에 배치 + 가운데 정렬 */
.button-group {
	display: flex;
	gap: 10px;
	margin-top: 5px;
	justify-content: center; /* 가운데 정렬 */
}

#signUp button[type="submit"] {
	padding: 10px 16px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
	transition: background-color 0.3s ease;
	margin-top: 5px;
}

#signUp button[type="submit"]:hover {
	background-color: #0056b3;
}

#cancelBtn {
	padding: 10px 16px;
	background-color: #6c757d; /* 회색 */
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
	transition: background-color 0.3s ease;
	margin-top: 5px;
}

#cancelBtn:hover {
	background-color: #5a6268; /* 어두운 회색 */
}

#signUp button[type="button"] {
	padding: 10px 16px;
	font-size: 14px;
	border-radius: 4px;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s ease;
	margin-top: 5px;
}

/* 중복체크 버튼 스타일 */
#idCheckBtn {
	padding: 8px 14px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
	transition: background-color 0.3s ease;
	margin-top: 0;
	white-space: nowrap;
	min-width: 90px;
}

#idCheckBtn:hover {
	background-color: #0056b3;
}

#signUp span {
	padding: 0 5px;
	font-weight: bold;
}

.hidden-field {
	display: none;
}

/* 이메일 입력 개선 */
.email-group {
	display: flex;
	align-items: center;
	flex-wrap: wrap;
	gap: 5px;
}

.email-group input[type="text"], .email-group select {
	width: auto;
	min-width: 120px;
	flex: 1;
}

.email-group span {
	font-weight: bold;
	padding: 0 5px;
}

/* 아이디 입력 + 중복체크 버튼 컨테이너 */
.id-check-container {
	display: flex;
	align-items: center;
	gap: 10px;
}

#signUp button.zipcode-btn {
	padding: 10px 16px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
	transition: background-color 0.3s ease;
	margin-left: 10px;
}

#signUp button.zipcode-btn:hover {
	background-color: #0056b3;
}

/* 프로필 사진 첨부 input 스타일 */
#signUp input[type="file"] {
	width: 100%; /* 가로 꽉 채우기 */
	padding: 8px 10px; /* 내부 여백 */
	font-size: 14px; /* 글자 크기 */
	border: 1px solid #ccc; /* 테두리 */
	border-radius: 4px; /* 모서리 둥글게 */
	background-color: #fff;
	cursor: pointer;
	box-sizing: border-box; /* 패딩 포함 크기 계산 */
	transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

#signUp input[type="file"]:hover {
	border-color: #007bff;
	box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
}

#signUp input[type="file"]:focus {
	outline: none;
	border-color: #0056b3;
	box-shadow: 0 0 8px rgba(0, 86, 179, 0.7);
}
</style>

<script>
function searchZipcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var fullAddress = data.address;
            var extraAddress = '';

            if (data.addressType === 'R') {
                if (data.bname !== '') {
                    extraAddress += data.bname;
                }
                if (data.buildingName !== '') {
                    extraAddress += (extraAddress !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if (extraAddress !== '') {
                    fullAddress += ' (' + extraAddress + ')';
                }
            }

            document.getElementById('zipCode').value = data.zonecode;
            document.getElementById('address').value = fullAddress;
            document.getElementById('detailAddress').focus();
            document.getElementById('fullAddress').value = fullAddress + ' ' + document.getElementById('detailAddress').value;
        }
    }).open();
}

window.addEventListener('DOMContentLoaded', () => {
    // 상세 주소 입력 시 fullAddress 갱신
    document.getElementById('detailAddress').addEventListener('input', function() {
        const full = document.getElementById('address').value + ' ' + this.value;
        document.getElementById('fullAddress').value = full.trim();
    });

    // 이메일 조합
    const emailId = document.getElementById('userEmail');
    const emailDomain = document.getElementById('email_domain');
    const fullEmail = document.getElementById('fullEmail');

    function updateEmail() {
        fullEmail.value = emailId.value.trim() + '@' + emailDomain.value.trim();
    }

    emailId.addEventListener('input', updateEmail);
    emailDomain.addEventListener('change', updateEmail);

    // 초기 이메일 fullEmail 셋팅
    updateEmail();
});

$(document).ready(function(){
    $("#idCheckBtn").click(function(){
      var userId = $("#userId").val().trim();

      if(userId === "") {
        alert("사용할 아이디를 입력하세요");
        return;
      }

      $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/userIdCheck",
        data: { userId: userId },
        success: function(data){
        	  // data.count로 접근
        	  if(data.count === 0) {
        	    $("#idCheckStatus").text("사용 가능한 아이디입니다.").css("color", "green");
        	  } else {
        	    $("#idCheckStatus").text("이미 사용 중인 아이디입니다.").css("color", "red");
        	  }
        	},
        error: function(){
          alert("서버와 통신 중 오류가 발생했습니다.");
        }
      });
    });
  });
 
$(document).ready(function() {
    // 비밀번호 유효성 검사 (AJAX)
    $('#userPassword').keyup(function() {
        let password = $(this).val();

        if (password === '') {
            $('#passwordCheck1').html('<b style="font-size:14px; color:red;">[사용할 비밀번호를 입력하세요]</b>');
            return;
        }

        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/checkPassword',
            data: { password: password },
            success: function(response) {
                if (response.valid) {
                    $('#passwordCheck1').html('<b style="font-size:14px; color:green;">[사용 가능한 비밀번호입니다.]</b>');
                } else {
                    $('#passwordCheck1').html('<b style="font-size:14px; color:red;">[비밀번호는 영문, 숫자, 특수문자를 포함해 8자 이상이어야 합니다.]</b>');
                }
            },
            error: function() {
                $('#passwordCheck1').html('<b style="font-size:14px; color:red;">[서버 오류가 발생했습니다.]</b>');
            }
        });
    });

    // 비밀번호 확인란 일치 여부 (동기 처리)
    $('#userPasswordConfirm').keyup(function() {
        let confirmPwd = $(this).val();
        let pwd = $('#userPassword').val();

        if (confirmPwd === '') {
            $('#passwordCheck2').html('<b style="font-size:14px; color:blue;">[비밀번호 확인은 필수 정보입니다.]</b>');
        } else if (confirmPwd !== pwd) {
            $('#passwordCheck2').html('<b style="font-size:14px; color:red;">[입력한 비밀번호가 일치하지 않습니다.]</b>');
        } else {
            $('#passwordCheck2').html('<b style="font-size:14px; color:green;">[비밀번호가 일치합니다.]</b>');
        }
    });

    // 폼 제출 시 클라이언트 측 검증
    $('#signUpForm').submit(function(event) {
        let password = $('#userPassword').val();
        let confirmPwd = $('#userPasswordConfirm').val();

        // 비밀번호 유효성 검사
        if (!password.match(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/)) {
            alert('비밀번호는 영문, 숫자, 특수문자를 포함해 8자 이상이어야 합니다.');
            event.preventDefault();
            return false;
        }

        // 비밀번호 일치 여부 확인
        if (password !== confirmPwd) {
            alert('비밀번호가 일치하지 않습니다.');
            event.preventDefault();
            return false;
        }
    });
});





</script>
</head>

<body>
	<form action="${pageContext.request.contextPath}/join" method="post"
		enctype="multipart/form-data" id="signUpForm">
		<table id="signUp">
			<tr>
				<td><label for="userId">아이디</label>
					<div class="id-check-container">
						<input type="text" name="userId" id="userId"
							placeholder="아이디를 입력하세요" required>
						<button type="button" id="idCheckBtn">중복체크</button>
						<div>
							<font id="idCheckStatus" size="2"></font>
						</div>
					</div></td>
			</tr>
			<tr>
				<td><label for="userPassword">비밀번호</label> <input
					type="password" name="userPassword" id="userPassword"
					placeholder="비밀번호를 입력하세요" required>
					<div id="passwordCheck1"></div></td>
			</tr>
			<tr>
				<td><label for="userPasswordConfirm">비밀번호 확인</label> <input
					type="password" name="userPasswordConfirm" id="userPasswordConfirm"
					placeholder="비밀번호를 한 번 더 입력하세요" required>
					<div id="passwordCheck2"></div></td>
			</tr>

			<tr>
				<td><label for="userName">이름</label> <input type="text"
					name="userName" id="userName" placeholder="이름을 입력하세요" required>
				</td>
			</tr>
			<tr>
				<td><label for="zipCode">우편번호</label> <input type="text"
					name="zipCode" id="zipCode" placeholder="우편번호" readonly required>
					<button type="button" class="zipcode-btn" onclick="searchZipcode()">우편번호
						검색</button></td>
			</tr>
			<tr>
				<td><label for="address">주소</label> <input type="text"
					id="address" placeholder="주소를 입력하세요" readonly required> <input
					type="text" id="detailAddress" placeholder="상세 주소를 입력하세요" required>
					<input type="hidden" name="address" id="fullAddress"></td>
			</tr>
			<tr>
				<td>
				<label for="userEmail">이메일</label>
					<div class="email-group">
						<input type="text" name="email" id="userEmail"
							placeholder="이메일 아이디" required> <span>@</span> <select
							name="emailDomain" id="email_domain" required>
							<option value="naver.com" selected>naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="daum.net">daum.net</option>
						</select> <input type="hidden" name="userEmail" id="fullEmail">
					</div>
				</td>
			</tr>

			<tr>
				<td><label for="phoneNum">휴대폰번호</label> <input type="text"
					id="phoneNum" name="userPhoneNum" maxlength="11"
					placeholder="숫자만 입력" required></td>
			</tr>

			
			<tr>
				<td>
					<div class="button-group">
						<button type="submit">가입</button>
						<button type="reset" id="cancelBtn">취소</button>
					</div>
				</td>
			</tr>
		</table>

	</form>
</body>
</html>
