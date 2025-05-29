<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입페이지</title>
</head>
<!--
	회원정보수정 페이지
	1. 회원정보수정을 위한 폼을 작성합니다.
	2. 회원정보수정을 위한 폼은 html로 작성합니다.
	3. 회원정보수정을 위한 폼은 post방식으로 전송합니다.
	4. 회원정보수정을 위한 폼은 enctype="multipart/form-data"로 설정합니다.
	5. 회원정보수정을 위한 폼은 action="/memberjoind"로 설정합니다.
	6. 회원정보수정을 위한 폼은 method="post"로 설정합니다.
-->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
    body {
        font-family: Arial, Helvetica, sans-serif;
        margin: 20px;
    }
    form{
        max-width: 700px;
        margin: 0 auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 10px;
        background-color: #f9f9f9;
    }
    label {
        display: block;
        margin-bottom: 5px;
    }
	input[type="text"]{
		width: 50%;
		padding: 10px;
		margin-bottom: 15px;
		border: 1px solid #ccc;
		border-radius: 5px;

	}

   select, button {
       width: 50%;
       padding: 10px;
       margin-bottom: 15px;
       border: 1px solid #ccc;
       border-radius: 5px;

   }
    button {
        background-color: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
    }
    button:hover {
        background-color:  #0056b3;
    }
    .inline {
        display: flex;
        gap: 10px;
    }
    .inline input {
        width:calc(50% - 5px); /* 버튼 너비를 제외한 나머지 공간 차지 */   
    }

	#findZipcode {
		width: 30%;
		background-color: #4CAF50;
		color: white;
		border: none;
		cursor: pointer;
	}
    input[type="date"] {
        width: 50%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-bottom: 15px;
        background-color: #f9f9f9;
        font-size: 16px;
        color: #333;
        transition: background-color 0.3s ease;
    }
    input[type="date"]:focus {
        background-color: #e0f7fa;
        outline: none;
    }   
</style>
<body>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function searchZipcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        // 선택된 주소 정보를 가져옵니다.
        var fullAddress = data.address; // 도로명 주소
        var extraAddress = ''; // 참고 항목

        // 참고 항목이 있을 경우 추가
        if (data.addressType === 'R') {
          if (data.bname !== '') {
            extraAddress += data.bname;
          }
          if (data.buildingName !== '') {
            extraAddress += (extraAddress !== '' ? ', ' + data.buildingName : data.buildingName);
          }
          fullAddress += (extraAddress !== '' ? ' (' + extraAddress + ')' : '');
        }

        // 우편번호와 주소 정보를 해당 필드에 넣습니다.
        document.getElementById('zipcode').value = data.zonecode; // 우편번호
        document.getElementById('address').value = fullAddress; // 기본 주소

        // 상세주소 입력란에 포커스를 줍니다.
        document.getElementById('detailAddress').focus();
      }
    }).open();
  }
</script>
	<%@ include file="../common/top.jsp"%>
	<h3>회원정보 수정</h3>
	<form action="${pageContext.request.contextPath}/membermodd" method="post" enctype="multipart/form-data">
		<!--  데이터 베이스에 삽입 작업은 대개 post로 넘긴다. -->
		<div>
		    <label for="userid">아이디:</label>
            <div class="inline">
				<input type="text" name="userid" id="userid" class="uclass" placeholder="아이디를 입력하세요" required />
			</div>
			<button type="button" id="duplexid"  > 이미존재하는아이디인지확인</button>

			<label for="password">비밀번호:</label>
            <input type="password" name="password" id="password" placeholder="새비밀번호를 입력하세요" required />

            <label for="confirm-password">비밀번호 확인:</label>
            <input type="password" name="confirm-password" id="confirm-password" placeholder="새비밀번호를 다시 입력하세요"  required/>
		    <label for="name">이름:</label>
            <input type="text" name="username" id="username" class="uclass" required />
		    <label for="zipcode">우편번호:</label>
            <div class="inline">
                <input type="text" name="zipcode" id="zipcode" placeholder="우편번호" readonly required />
                <button type="button" onclick="searchZipcode()">우편번호검색</button>
            </div>
		    <label for="address">주소:</label>
		    <div  class="inline"> 
                <input type="text" name="address" id="address" placeholder="주소를 입력하세요" readonly required />
                <input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소를 입력하세요"  required />
            </div>
            <script>

                document.getElementById('email_domain').addEventListener('change', function() {
                    const selectedValue = this.value;
                    document.getElementById('email_domain_input').value = selectedValue; // 이메일 도메인 필드에 설정
                });
                </script>
		    <label for="email">이메일:</label>
            <div class="inline">
                <input type="text" name="email_id" id="email_id" placeholder="이메일아이디를 입력하세요" required />
                <span>@</span>
                <input type="text" name="email_domain" id="email_domain_input"  value="naver.com" required />   
               <select name="email_domain" id="email_domain" required>
                    <option value="naver.com" selected>naver.com</option>
                    <option value="gmail.com">gmail.com</option>
                    <option value="daum.net">daum.net</option>
                </select>
            <input type="hidden" name="fullEmail" id="fullEmail" />
            <script>
                document.getElementById('email_id').addEventListener('input', function() {
                    const emailId = this.value;
                    const emailDomain = document.getElementById('email_domain_input').value;
                    document.getElementById('fullEmail').value = emailId + '@' + emailDomain; // 전체 이메일을 업데이트
                }); 
            </script>    

            </div>
		</div>
        <label for =birthdate>생년월일:</label>
        <div class="inline">
            <input type="date" name="birthdate" id="birthdate"   required />

        </div>
		<label for="mobile">휴대폰:</label>
		<div class="inline">
			<input type="text" name="mobile1" maxlength="3">
			<span> - </span>
			<!-- 전화번호 중간번호 -->
			<input type="text" name="mobile2" maxlength="4">
			<span> - </span>
			<!-- 전화번호 끝번호 -->
			<input type="text"  name="mobile3"  maxlength="4">
            <!-- 전화번호 전체 -->
            <input type="text"  name="fullPhoneNumber"  id="fullPhoneNumber" >
			<!--인증문자 받기-->
			<button type="button" onclick="sendAuthCode()">인증문자 받기</button>
			</td>
		</div>
		<label for="birthdate">프로필사진:</label>
		<input type="file" name="file" id="file">
		<button type="submit">가입</button>
	</form>
</body>
</html>
<script>
// 실시간 업데이트 방식


$("#duplexid").click(()=>{  // id가 userid인 태그를 선택해서 click이벤트를 정의한다
	let uid = $("#userid").val(); // 아이디로 지정한 곳의 값을 가져옴
	alert(uid)
	//비동기 통신으로 서버에 전송해 보겠습니다. 
	// request(비동기)  url, parameter, method
	$.ajax({
		async:true,    // false라고 하면 동기방식으로 설정.
		url: "duplexid",  //url된다. 
		data: {
				'id': uid  //  키   : 값
		},
		type : 'GET',   //get방식으로 보내겠다.
		dataType: "text",
		success : function(data){ // data 서버로 부터 받은 데이터를 저장..
			alert(data +" 서버로 부터 받음")
			if(data!=''){
                alert("존재하지 않는 아이디입니다.")
                $("#userid").val('');  // 아이디로 지정한 곳에 값을 변경
				
			}else{
				alert("비밀번호 수정가능 아이디입니다.")
                $("#duplexid").text(data+' 비번 변경 가능 아이디')
                $("#userid").attr("readonly", true); // 아이디 입력 필드를 읽기 전용으로 설정
			}
		},
		error : function(){
			alert("통신오류")
		}				
	})				
})

        function sendAuthCode() {
            const mobile1 = document.querySelector('input[name="mobile1"]').value;
            const mobile2 = document.querySelector('input[name="mobile2"]').value;
            const mobile3 = document.querySelector('input[name="mobile3"]').value;

            // 전체 전화번호를 조합
            const fullPhoneNumber = mobile1 + mobile2 + mobile3;
            document.getElementById('fullPhoneNumber').value = fullPhoneNumber; // 전체 전화번호 필드에 설정

            // 인증 문자 전송 로직을 여기에 추가하세요.
            alert(fullPhoneNumber);
        }
    
        // 비밀번호 확인
        document.getElementById('confirm-password').addEventListener('change', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            alert(document.getElementById('password').value);
            if (password === confirmPassword) {
            	
            	
                alert('비밀번호가 일치합니다.');
            } else {
                alert('비밀번호가 일치하지 않습니다.');
            }
        });
</script>