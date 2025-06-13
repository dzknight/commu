<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="회원가입 페이지로, 사용자 정보를 입력하고 여권 사진을 업로드하여 회원 가입을 진행합니다.">
    <title>회원가입</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/join.css">
    <script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    

</head>



<body>
    <!-- 포스트모던 배경 요소들 -->
    <div class="postmodern-bg">
        <div class="floating-shape shape-triangle"></div>
        <div class="floating-shape shape-circle"></div>
        <div class="floating-shape shape-square"></div>
        <div class="floating-shape shape-pentagon"></div>
        <div class="grid-overlay"></div>
        <div class="neon-strips">
            <div class="strip strip-1"></div>
            <div class="strip strip-2"></div>
            <div class="strip strip-3"></div>
        </div>
    </div>

    <div class="postmodern-container">
        <!-- 헤더 섹션 -->
        <header class="signup-header">
            <div class="header-content">
                <h1 class="main-title">
                    <span class="title-part-1">회원</span>
                    <span class="title-part-2">가입</span>
                    <span class="title-part-3">페이지</span>
                    <span class="title-part-4">입니다</span>
                </h1>
                <div class="subtitle-container">
                    <p class="subtitle">커뮤니티 회원 가입페이지입니다</p>
                    <div class="decorative-elements">
                        <span class="deco-icon">🎭</span>
                        <span class="deco-icon">🎨</span>
                        <span class="deco-icon">🚀</span>
                    </div>
                </div>
            </div>
        </header>

        <!-- 메인 폼 -->
        <main class="signup-main">
            <form action="${pageContext.request.contextPath}/join" method="post"
                  enctype="multipart/form-data" id="signUpForm" 
                  data-context-path="${pageContext.request.contextPath}"
                  class="postmodern-form">
                
                <!-- 진행 단계 표시 -->
                <div class="progress-indicator">
                    <div class="progress-bar">
                        <div class="progress-fill"></div>
                    </div>
                    <div class="progress-text">
                        <span class="current-step">01</span>
                        <span class="divider">/</span>
                        <span class="total-steps">05</span>
                        <span class="step-label">디지털 계정 만들기</span>
                    </div>
                </div>

                <!-- 섹션 1: 기본 정보 -->
                <section class="form-section identity-section">
                    <div class="section-header">
                        <h2 class="section-title">
                            <span class="section-number">01</span>
                            <span class="section-text">첫걸음</span>
                            <div class="title-decoration"></div>
                        </h2>
                    </div>

                    <div class="form-grid">
                        <!-- 아이디 입력 -->
                        <div class="form-group neon-purple">
                            <label for="userId" class="form-label">
                                <i class="fas fa-user-secret"></i>
                                디지털 닉네임을 선택하세요
                            </label>
                            <div class="input-container">
                                <input type="text" name="userId" id="userId" 
                                       maxlength="10" placeholder="유니크한 아이디를 선택하세요"
                                       pattern="[a-zA-Z0-9]{4,10}" required
                                       class="postmodern-input">
                                <button type="button" id="idCheckBtn" class="check-btn">
                                    <span>검증</span>
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                            <div class="validation-message" id="idCheckStatus"></div>
                        </div>

                        <!-- 비밀번호 -->
                        <div class="form-group neon-cyan">
                            <label for="userPassword" class="form-label">
                                <i class="fas fa-lock"></i>
                                Secret Code
                            </label>
                            <div class="input-container">
                                <input type="password" name="userPassword" id="userPassword"
                                       placeholder="비밀번호를 입력하세요" required maxlength="12"
                                       class="postmodern-input">
                                <div class="password-strength">
                                    <div class="strength-bar"></div>
                                </div>
                            </div>
                            <div class="validation-message" id="passwordCheck1"></div>
                        </div>

                        <!-- 비밀번호 확인 -->
                        <div class="form-group neon-pink">
                            <label for="userPasswordConfirm" class="form-label">
                                <i class="fas fa-shield-alt"></i>
                                비밀번호 재입력
                            </label>
                            <div class="input-container">
                                <input type="password" name="userPasswordConfirm" 
                                       id="userPasswordConfirm" placeholder="비밀번호를 다시 입력하세요"
                                       required maxlength="12" class="postmodern-input">
                            </div>
                            <div class="validation-message" id="passwordCheck2"></div>
                        </div>

                        <!-- 이름 -->
                        <div class="form-group neon-yellow">
                            <label for="userName" class="form-label">
                                <i class="fas fa-signature"></i>
                                이름 입력
                            </label>
                            <div class="input-container">
                                <input type="text" name="userName" id="userName" placeholder="실명을 입력하세요" required maxlength="10"
                                       pattern="[가-힣]{2,10}" class="postmodern-input">
                            </div>
                        </div>
                    </div>
                </section>

                <!-- 섹션 2: 위치 정보 -->
                <section class="form-section location-section">
                    <div class="section-header">
                        <h2 class="section-title">
                            <span class="section-number">02</span>
                            <span class="section-text">어디 살고 있나요?</span>
                        </h2>

                    </div>

                    <div class="form-grid">
                        <!-- 우편번호 -->
                        <div class="form-group neon-green">
                            <label for="zipCode" class="form-label">
                                <i class="fas fa-map-pin"></i>
                                우편번호찾기
                            </label>
                            <div class="input-container zipcode-container">
                                <input type="text" name="zipCode" id="zipCode" 
                                       placeholder="Find your zone..." readonly required
                                       class="postmodern-input">
                                <button type="button" class="search-btn" onclick="searchZipcode()">
                                    <span>찾기</span>
                                    <i class="fas fa-satellite-dish"></i>
                                </button>
                            </div>
                        </div>

                        <!-- 주소 -->
                        <div class="form-group neon-orange full-width">
                            <label for="address" class="form-label">
                                <i class="fas fa-home"></i>
                                당신의 거주지는?
                            </label>
                            <div class="address-inputs">
                                <input type="text" id="address" placeholder="자동입력되는 필드입니다"
                                       readonly required class="postmodern-input address-main">
                                <input type="text" name="detailAddress" id="detailAddress" 
                                       placeholder="상세주소를 입력하세요" required maxlength="30"
                                       class="postmodern-input address-detail">
                                <input type="hidden" name="address" id="fullAddress">
                            </div>
                        </div>
                    </div>
                </section>

                <!-- 섹션 3: 연락처 -->
                <section class="form-section contact-section">
                    <div class="section-header">
                        <h2 class="section-title">
                            <span class="section-number">03</span>
                            <span class="section-text">연락을 지속하기 위해서</span>
                            <div class="title-decoration"></div>
                        </h2>
                    </div>

                    <div class="form-grid">
                        <!-- 이메일 -->
                        <div class="form-group neon-purple full-width">
                            <label for="userEmail" class="form-label">
                                <i class="fas fa-at"></i>
                                디지털 이메일 주소
                            </label>
                            <div class="email-container">
                                <div class="email-input-group">
                                    <input type="text" name="email_id" id="email_id" 
                                           placeholder="Your ID..." required maxlength="10"
                                           class="postmodern-input email-id">
                                    <span class="email-separator">@</span>
                                    <select name="emailDomain" id="email_domain" required
                                            class="postmodern-select">
                                        <option value="naver.com">naver.com</option>
                                        <option value="gmail.com">gmail.com</option>
                                        <option value="daum.net">daum.net</option>
                                        <option value="nate.com">nate.com</option>
                                        <option value="yahoo.com">yahoo.com</option>
                                        <option value="hanmail.net">hanmail.net</option>
                                        <option value="hotmail.com">hotmail.com</option>
                                        <option value="kakao.com">kakao.com</option>
                                    </select>
                                    <input type="hidden" name="email_domain" id="email_domain_input" value="naver.com">
                                    <input type="hidden" name="email" id="address" value="dzknight@naver.com">
                                    <input type="text" name="fullEmail" id="fullEmail">
                                    <button type="button" id="emailAuthBtn" class="verify-btn">
                                        <span>코드 전송</span>
                                        <i class="fas fa-paper-plane"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <!-- 이메일 인증 섹션 -->
                            <div class="email-auth-section" id="emailAuthSection">
                                <div class="auth-header">
                                    <h4>🔐 이메일 인증 포탈</h4>
                                    <div class="timer-display" id="timer">05:00</div>
                                </div>
                                <div class="auth-input-container">
                                    <input type="text" id="authCode" name="authCode" 
                                           placeholder="6자리 숫자를 입력하세요" required
                                           class="postmodern-input auth-input">
                                    <button type="button" id="verifyCodeBtn" class="verify-btn">
                                        <span>인증버튼</span>
                                        <i class="fas fa-check"></i>
                                    </button>
                                </div>
                                <div id="emailAuthResult" class="auth-result"></div>
                            </div>
                        </div>

                        <!-- 전화번호 -->
                        <div class="form-group neon-cyan">
                            <label for="phoneNum" class="form-label">
                                <i class="fas fa-mobile-alt"></i>
                                휴대폰 번호
                            </label>
                            <div class="phone-container">
                                <input type="text" id="phoneNum" name="userPhoneNum" maxlength="11" placeholder="숫자만 입력" required >
                            </div>
                        </div>

                        <!-- 생년월일 -->
                        <div class="form-group neon-pink">
                            <label for="birthdate" class="form-label">
                                <i class="fas fa-birthday-cake"></i>
                                생년월일
                            </label>
                            <div class="input-container">
                                <input type="date" name="birthdate" id="birthdate" required
                                       class="postmodern-input date-input">
                            </div>
                        </div>
                    </div>
                </section>

                <!-- 섹션 4: 프로필 이미지 -->
                <section class="form-section avatar-section">
                    <div class="section-header">
                        <h2 class="section-title">
                            <span class="section-number">04</span>
                            <span class="section-text">디지털 아바타를 등록하세요</span>
                            <div class="title-decoration"></div>
                        </h2>
                    </div>

                    <div class="avatar-container">
                        <div class="upload-zone" id="uploadZone">
                            <div class="upload-content">
                                <div class="file-info">
                                    <span>JPEG, PNG • 최대 10MB</span>
                                </div>
                            </div>
                            <input type="file" id="profileImage" name="profileImageFile" accept="image/jpeg,image/jpg,image/png"
                                   class="file-input" required>
                        </div>

                        <div class="ai-options">
                            <div class="ai-toggle">
                                <label class="toggle-container">
                                    <input type="checkbox" id="enableAiConvert" checked>
                                    <span class="toggle-slider"></span>
                                    <span class="toggle-label">AI 사진규격 보정</span>
                                </label>
                            </div>
                            <select id="aiProvider" class="postmodern-select">
                                <option value="idphoto">IdPhoto.AI (추천)</option>
                            </select>
                        </div>

                        <div class="image-preview" id="imagePreview" style="display: none;">
                            <img id="photoPreview" alt="Profile preview">
                            <div class="preview-actions">
                                <button type="button" id="restoreOriginal" class="action-btn">
                                    <i class="fas fa-undo"></i>
                                    Restore Original
                                </button>
                            </div>
                        </div>

                        <div id="photoValidation" class="validation-display"></div>
                    </div>
                </section>

                <!-- 섹션 5: 제출 -->
                <section class="form-section submit-section">
                    <div class="section-header">
                        <h2 class="section-title">
                            <span class="section-number">05</span>
                            <span class="section-text">마지막 단계</span>
                            <div class="title-decoration"></div>
                        </h2>
                    </div>

                    <div class="submit-container">
                        <div class="action-buttons">
                            <button type="reset" id="cancelBtn" class="secondary-btn">
                                <i class="fas fa-redo"></i>
                                <span>초기화</span>
                            </button>
                            <button type="submit" id="submitBtn" class="primary-btn" >
                                <i class="fas fa-rocket"></i>
                                <span>회원가입!</span>
                                <div class="btn-glow"></div>
                            </button>
                        </div>
                    </div>
                </section>
            </form>
        </main>

        <!-- 푸터 -->
        <footer class="signup-footer">
            <div class="footer-content">
                <p>© 2025 포스트모던 Signup</p>
                <div class="footer-icons">
                    <span>🎨</span>
                    <span>🚀</span>
                    <span>🌈</span>
                </div>
            </div>
        </footer>
    </div>

    <script>
// jQuery 기반 기능들
$(document).ready(function(){
    let isIdChecked = false;
    
    // 아이디 중복체크
    $("#idCheckBtn").click(function(){
        var userId = $("#userId").val().trim();
        
        if(userId === "") {
            alert("사용할 아이디를 입력하세요");
            $("#userId").focus();
            return false;
        }
        
        // 아이디 유효성 검사 (영문, 숫자만 허용)
        var idPattern = /^[a-zA-Z0-9]+$/;
        if(!idPattern.test(userId)) {
            alert("아이디는 영문과 숫자만 사용 가능합니다.");
            $("#userId").focus();
            return false;
        }
        
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/userIdCheck",
            data: { userId: userId },
            dataType: "json",
            beforeSend: function() {
                $("#idCheckBtn").prop("disabled", true).text("확인중...");
            },
            success: function(data){
                if(data.count === 0) {
                    $("#idCheckStatus").text("사용 가능한 아이디입니다.").css("color", "green");
                    isIdChecked = true;
                    alert("사용 가능한 아이디입니다.");
                } else {
                    $("#idCheckStatus").text("이미 사용 중인 아이디입니다.").css("color", "red");
                    isIdChecked = false;
                    alert("이미 사용 중인 아이디입니다.");
                }
            },
            error: function(xhr, status, error){
                console.error("AJAX 오류:", error);
                alert("서버와 통신 중 오류가 발생했습니다.");
                isIdChecked = false;
            },
            complete: function() {
                $("#idCheckBtn").prop("disabled", false).text("중복체크");
                updateSubmitButtonState();
            }
        });
    });
    
    // 비밀번호 유효성 검사
    $('#userPassword').keyup(function() {
        let password = $(this).val();
        
        if (password === '') {
            $('#passwordCheck1').html('<b style="font-size:14px; color:red;">[사용할 비밀번호를 입력하세요]</b>');
            isPasswordValid = false;
            updateSubmitButtonState();
            return;
        }
        
        // 클라이언트 사이드 비밀번호 검증
        const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
        if (passwordRegex.test(password)) {
            $('#passwordCheck1').html('<b style="font-size:14px; color:green;">[사용 가능한 비밀번호입니다.]</b>');
            isPasswordValid = true;
        } else {
            $('#passwordCheck1').html('<b style="font-size:14px; color:red;">[비밀번호는 영문, 숫자, 특수문자를 포함해 8자 이상이어야 합니다.]</b>');
            isPasswordValid = false;
        }
        updateSubmitButtonState();
    });
    
    // 비밀번호 확인
    $('#userPasswordConfirm').keyup(function() {
        let confirmPwd = $(this).val();
        let pwd = $('#userPassword').val();
        
        if (confirmPwd === '') {
            $('#passwordCheck2').html('<b style="font-size:14px; color:blue;">[비밀번호 확인은 필수 정보입니다.]</b>');
            isPasswordConfirmed = false;
        } else if (confirmPwd !== pwd) {
            $('#passwordCheck2').html('<b style="font-size:14px; color:red;">[입력한 비밀번호가 일치하지 않습니다.]</b>');
            isPasswordConfirmed = false;
        } else {
            $('#passwordCheck2').html('<b style="font-size:14px; color:green;">[비밀번호가 일치합니다.]</b>');
            isPasswordConfirmed = true;
        }
        updateSubmitButtonState();
    });
    
    // 폼 제출 시 최종 검증
    $('#signUpForm').submit(function(event) {
        // 필수 유효성 검사
        if (!isPasswordValid) {
            alert('비밀번호가 유효하지 않습니다.');
            event.preventDefault();
            return false;
        }
        
        if (!isPasswordConfirmed) {
            alert('비밀번호 확인이 일치하지 않습니다.');
            event.preventDefault();
            return false;
        }
        
        // 프로필 사진이 업로드되었지만 유효하지 않은 경우
        const profileImage = document.getElementById('profileImage');
        if (profileImage && profileImage.files.length > 0 && !isValidPhoto) {
            alert('프로필 사진이 여권사진 규격에 맞지 않습니다.');
            event.preventDefault();
            return false;
        }
        
        return true;
    });
});

</script>

<script>

// 이메일 인증번호 전송
$('#emailAuthBtn1').click(function() {
    //alert("ss");
    const email = $('#fullEmail').val();
    alert(email);
    if (!email) {
        alert('이메일을 입력해주세요.');
        return;
    }
    
    $.ajax({
        url: '${pageContext.request.contextPath}/mailsend',
        type: 'POST',
        data: { email: email },
        success: function(response) {
        	if (response.success) {
                $('#emailAuthResult').html('<div class="success">' + response.message + '</div>');
                $('#authCodeSection').show();
                $('#emailAuthBtn').text('재전송').removeClass('btn-primary').addClass('btn-secondary');
                
                // 5분 타이머 시작
                startTimer(300);
            } else {
                $('#emailAuthResult').html('<div class="error">' + response.message + '</div>');
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX 오류:', xhr, status, error); // 디버깅용
            
            let errorMessage = '인증번호 전송 중 오류가 발생했습니다.';
            if (status === 'timeout') {
                errorMessage = '요청 시간이 초과되었습니다. 다시 시도해주세요.';
            } else if (xhr.status === 404) {
                errorMessage = '서버를 찾을 수 없습니다. 관리자에게 문의하세요.';
            } else if (xhr.status === 500) {
                errorMessage = '서버 내부 오류가 발생했습니다.';
            }
            
            $('#emailAuthResult').html('<div class="error">' + errorMessage + '</div>');
            alert(errorMessage);
        },
        complete: function() {
            // 버튼 다시 활성화
            $('#emailAuthBtn').prop('disabled', false);
            if ($('#emailAuthBtn').text() === '전송중...') {
                $('#emailAuthBtn').text('인증메일 보내기');
            }
        }
    });
});

// 인증번호 검증
$('#verifyCodeBtn').click(function() {
    const email = $('#userEmail').val();
    const code = $('#authCode').val();
    
    if (!code) {
        alert('인증번호를 입력해주세요.');
        return;
    }
    
    $.ajax({
        url: '${pageContext.request.contextPath}/verify-email-code',
        type: 'POST',
        data: { 
            email: email,
            code: code 
        },
        success: function(response) {
            if (response.success) {
                $('#emailAuthResult').html('<div class="success">' + response.message + '</div>');
                $('#authCodeSection').hide();
                $('#sendEmailBtn').prop('disabled', true).text('인증완료');
                $('#userEmail').prop('readonly', true);
                emailVerified = true;
                updateSubmitButton();
                clearInterval(timerInterval);
            } else {
                $('#emailAuthResult').html('<div class="error">' + response.message + '</div>');
            }
        },
        error: function() {
            $('#emailAuthResult').html('<div class="error">인증 처리 중 오류가 발생했습니다.</div>');
        }
    });
});

// 타이머 시작
function startTimer(duration) {
    clearInterval(timerInterval);
    let timer = duration;
    
    timerInterval = setInterval(function() {
        const minutes = parseInt(timer / 60, 10);
        const seconds = parseInt(timer % 60, 10);
        
        const display = minutes + ":" + (seconds < 10 ? "0" + seconds : seconds);
        $('#timer').text('남은 시간: ' + display);
        
        if (--timer < 0) {
            clearInterval(timerInterval);
            $('#timer').text('인증시간이 만료되었습니다. 재전송해주세요.');
            $('#authCodeSection').hide();
        }
    }, 1000);
}

// 회원가입 버튼 활성화 체크
//function updateSubmitButton() {
//    if (emailVerified) {
//        $('#submitBtn').removeClass('disabled').prop('disabled', false);
//   }
//}
 
// 폼 제출 시 이메일 인증 확인
/* $('#signUpForm').submit(function(e) {
    if (!emailVerified) {
        e.preventDefault();
        alert('이메일 인증을 완료해주세요.');
        return false;
    }
}); */


let emailVerified = false;
// DOM이 완전히 로드된 후 스크립트가 실행되도록 합니다.
document.addEventListener('DOMContentLoaded', function() {

    // 전송 버튼 클릭 이벤트 리스너를 등록합니다.
    document.getElementById('emailAuthBtn').addEventListener('click', function() {
        // 입력 필드에서 이메일 주소, 제목, 메시지를 가져옵니다.
        const address = document.getElementById('fullEmail').value;
        // 이메일 인증용 기본 제목과 메시지 설정
        const title = "이메일 인증";
        const message = "이메일 인증을 완료해주세요";
        alert(address);
       
        // 전송할 데이터를 객체 형태로 만듭니다.
        const mailData = {
            address: address,
            title: title,
            message: message
        };
        alert("이메일 전송 버튼이 클릭되었습니다.");
        const responseSpan = document.getElementById('responseMessage');
        responseSpan.innerText = '전송 중...'; // 사용자에게 진행 상황을 알립니다.
        // fetch API를 사용하여 서버에 POST 요청을 보냅니다.
        fetch('${pageContext.request.contextPath}/mailsend', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json' // 전송하는 데이터가 JSON 형식임을 명시합니다.
            },
            body: JSON.stringify(mailData) // JavaScript 객체를 JSON 문자열로 변환합니다.
        })
        .then(response => {
            if (!response.ok) {
                // 서버 응답이 실패한 경우(예: 500 에러) 예외를 발생시킵니다.
                throw new Error('서버 응답이 올바르지 않습니다.');
            }
            return response.json(); // 서버가 보낸 JSON 응답을 파싱합니다.
        })
        .then(data => {
            // 성공적으로 응답을 받았을 때 메시지를 표시합니다.
            responseSpan.style.color = data.success ? 'blue' : 'red';
            responseSpan.innerText = data.message;
            
            // 성공 시 입력 필드를 비웁니다.
            if (data.success) {
                document.getElementById('mailForm').reset();
            }
        })
        .catch(error => {
            // 네트워크 오류나 위의 then 블록에서 발생한 예외를 처리합니다.
            console.error('Error:', error);
            responseSpan.style.color = 'red';
            responseSpan.innerText = '메일 전송 중 오류가 발생했습니다.';
        });
    });
});
</script>


<script>
let isValidPhoto = false;
let isIdChecked = false;
let isPasswordValid = false;
let isPasswordConfirmed = false;
//이메일검증여부

//시간간격
let timerInterval;

//AI 여권사진 변환을 위한 전역 변수
let isProcessing = false;
let originalFile = null;

// IdPhoto.AI API 설정
const IDPHOTO_API_CONFIG = {
    apiKey: f8qfQmSMPkXz3MA9,
    apiSecret: 7Z1bK0YSCwQnq2Oz5JxldDmtA8bpXq9qMR7DdKnPwd6Z9uyj5opSJv8Nw7ltsC9g,
    endpoint: 'https://api.idphoto.ai/v2/makeIdPhoto',
    specCode: 'korea-passport' // 한국 여권 규격
};



// 파일을 Base64로 변환하는 함수
function fileToBase64(file) {
    return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = () => {
            const base64 = reader.result.split(',')[1]; // data:image/jpeg;base64, 부분 제거
            resolve(base64);
        };
        reader.onerror = reject;
        reader.readAsDataURL(file);
    });
}

// IdPhoto.AI API를 사용한 여권사진 변환
async function convertWithIdPhotoAI(file) {
    try {
        const imageBase64 = await fileToBase64(file);
        
        const requestBody = {
            apiKey: f8qfQmSMPkXz3MA9,
            apiSecret: 7Z1bK0YSCwQnq2Oz5JxldDmtA8bpXq9qMR7DdKnPwd6Z9uyj5opSJv8Nw7ltsC9g,
            imageBase64: imageBase64,
            specCode: IDPHOTO_API_CONFIG.specCode
        };

        const response = await fetch(IDPHOTO_API_CONFIG.endpoint, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(requestBody)
        });

        if (!response.ok) {
            throw new Error(`API 호출 실패: ${response.status}`);
        }

        const result = await response.json();
        
        if (result.issues && result.issues.length > 0) {
            showValidationMessage(`사진 품질 문제: ${result.issues.join(', ')}`, false);
            return null;
        }

        return result.idPhotoUrl;
        
    } catch (error) {
        console.error('IdPhoto.AI API 오류:', error);
        throw error;
    }
}

// 이미지 URL을 File 객체로 변환
async function urlToFile(url, filename = 'passport-photo.jpg') {
    try {
        const response = await fetch(url);
        const blob = await response.blob();
        return new File([blob], filename, { type: 'image/jpeg' });
    } catch (error) {
        console.error('URL to File 변환 오류:', error);
        throw error;
    }
}

// 변환된 이미지를 미리보기에 표시
function displayConvertedImage(imageUrl) {
    const photoPreview = document.getElementById('photoPreview');
    if (photoPreview) {
        photoPreview.src = imageUrl;
        photoPreview.style.display = 'block';
    }
}

// 로딩 상태 표시
function showLoadingState(isLoading) {
    const validationDiv = document.getElementById('photoValidation');
    const submitBtn = document.querySelector('button[type="submit"]');
    
    if (isLoading) {
        validationDiv.innerHTML = '<div class="loading">🔄 AI가 여권사진으로 변환 중입니다...</div>';
        if (submitBtn) submitBtn.disabled = true;
    }
}

//기존 프로필 이미지 이벤트 리스너 수정
document.addEventListener('DOMContentLoaded', function() {
    const profileImageInput = document.getElementById('profileImage');
    
    if (profileImageInput) {
        profileImageInput.addEventListener('change', async function(e) {
            const file = e.target.files[0];
            const photoPreview = document.getElementById('photoPreview');
            const photoValidation = document.getElementById('photoValidation');
            const enableAiConvert = document.getElementById('enableAiConvert');
            const aiProvider = document.getElementById('aiProvider');
            
            if (!file) {
                if (photoPreview) photoPreview.style.display = 'none';
                if (photoValidation) photoValidation.innerHTML = '';
                isValidPhoto = false;
                return;
            }

            // 원본 파일 저장
            originalFile = file;
            
            // 파일 형식 검증
            const allowedTypes = ['image/jpeg', 'image/png', 'image/jpg'];
            if (!allowedTypes.includes(file.type)) {
                showValidationMessage('JPEG 또는 PNG 파일만 업로드 가능합니다.', false);
                return;
            }

            // 파일 크기 검증 (10MB 제한 - AI 처리용)
            const maxSize = 10 * 1024 * 1024;
            if (file.size > maxSize) {
                showValidationMessage('파일 크기가 10MB를 초과합니다.', false);
                return;
            }

            // AI 변환 여부 확인
            if (enableAiConvert && enableAiConvert.checked) {
                // AI 변환 시작
                isProcessing = true;
                showLoadingState(true);
                
                try {
                    let convertedImageUrl = null;
                    const selectedProvider = aiProvider ? aiProvider.value : 'segmind';
                    
                    if (selectedProvider === 'idphoto') {
                        // IdPhoto.AI 사용
                        try {
                            convertedImageUrl = await convertWithIdPhotoAI(file);
                        } catch (error) {
                            console.warn('IdPhoto.AI 실패, Segmind로 전환:', error);
                        }
                    }
                    
                    // IdPhoto.AI 실패 시 또는 Segmind 선택 시
                    if (!convertedImageUrl) {
                        convertedImageUrl = await convertWithSegmindAI(file);
                    }
                    
                    if (convertedImageUrl) {
                        // 변환된 이미지 표시
                        displayConvertedImage(convertedImageUrl);
                        
                        // 변환된 이미지를 File 객체로 변환하여 검증
                        const convertedFile = await urlToFile(convertedImageUrl);
                        
                        // 변환된 이미지로 기존 검증 로직 실행
                        validateImageDimensions(convertedFile);
                        
                        // 폼 제출용 파일 교체
                        replaceFileInput(convertedFile);
                        
                        showValidationMessage('✅ AI가 여권 규격에 맞게 자동 변환했습니다!', true);
                        
                    } else {
                        throw new Error('모든 AI 서비스 변환 실패');
                    }
                    
                } catch (error) {
                    console.error('AI 변환 오류:', error);
                    showValidationMessage(`AI 변환 실패: ${error.message}. 수동으로 조정해주세요.`, false);
                    
                    // 원본 이미지로 기존 검증 로직 실행
                    validateImageDimensions(originalFile);
                    
                    // 원본 이미지 미리보기 표시
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        if (photoPreview) {
                            photoPreview.src = e.target.result;
                            photoPreview.style.display = 'block';
                        }
                    };
                    reader.readAsDataURL(originalFile);
                } finally {
                    isProcessing = false;
                }
            } else {
                // AI 변환 비활성화 시 기존 검증만 수행
                validateImageDimensions(file);
                
                // 원본 이미지 미리보기 표시
                const reader = new FileReader();
                reader.onload = function(e) {
                    if (photoPreview) {
                        photoPreview.src = e.target.result;
                        photoPreview.style.display = 'block';
                    }
                };
                reader.readAsDataURL(originalFile);
            }
        });
    }
});

// File input을 새로운 파일로 교체하는 함수
function replaceFileInput(newFile) {
    const profileImageInput = document.getElementById('profileImage');
    if (profileImageInput) {
        // DataTransfer 객체를 사용하여 파일 교체
        const dataTransfer = new DataTransfer();
        dataTransfer.items.add(newFile);
        profileImageInput.files = dataTransfer.files;
    }
}
</script>


<script>
// 유효성 검사 메시지 표시 함수
function showValidationMessage(message, isValid) {
    const validationDiv = document.getElementById('photoValidation');
    
    if (validationDiv) {
        validationDiv.innerHTML = `<div class="${isValid ? 'success' : 'error'}">${message}</div>`;
    }
    alert(message);
    isValidPhoto = isValid;
    updateSubmitButtonState();
}

// 제출 버튼 상태 업데이트
function updateSubmitButtonState() {
    const submitButton = document.getElementById('submitBtn');
    const profileImage = document.getElementById('profileImage');
    
    if (submitButton) {
        // 프로필 사진이 선택되었다면 유효성 검사 결과에 따라 결정
        if (profileImage && profileImage.files.length > 0) {
            submitButton.disabled = !isValidPhoto;
        } else {
            // 프로필 사진이 선택되지 않았다면 다른 조건들 확인
            submitButton.disabled = false;
        }
    }
}

function validateImageDimensions(file) {
    const reader = new FileReader();
    reader.onload = function(e) {
        const img = new Image();
        img.onload = function() {
            const width = this.width;
            const height = this.height;
            
            // 여권사진 비율 검증 (3.5:4.5)
            const expectedRatio = 3.5/4.5; // 약 0.7778
            const actualRatio = width/height;
            const ratioTolerance = 0.1; // 허용 오차 증가
            
            // 권장 해상도 검증 (600 DPI 기준)
            const recommendedWidth = Math.round(3.5 * 600 / 2.54); // 약 827px
            const recommendedHeight = Math.round(4.5 * 600 / 2.54); // 약 1063px
            
            // 최소 해상도 검증 (300 DPI 기준)
            const minWidth = Math.round(3.5 * 300 / 2.54); // 약 413px
            const minHeight = Math.round(4.5 * 300 / 2.54); // 약 531px
            
            if (width < minWidth || height < minHeight) {
                showValidationMessage(`해상도가 너무 낮습니다. 최소 ${minWidth}×${minHeight}px 이상이어야 합니다.`, false);
                return;
            }
            
            //if (width < recommendedWidth || height < recommendedHeight) {
            //    showValidationMessage(`권장 해상도는 ${recommendedWidth}×${recommendedHeight}px (600 DPI) 입니다. 현재: ${width}×${height}px`, false);
            //    return;
           // }
            
            if (Math.abs(actualRatio - expectedRatio) > ratioTolerance) {
                showValidationMessage(`여권사진 비율(3.5:4.5)에 맞지 않습니다. 현재 비율: ${actualRatio.toFixed(3)}`, false);
                return;
            }
            
            // 얼굴 크기 검증 추가
            //validateFaceSize(img, width, height);
        };
        img.src = e.target.result;
        
        // 미리보기 표시
        const photoPreview = document.getElementById('photoPreview');
        if (photoPreview) {
            photoPreview.src = e.target.result;
            photoPreview.style.display = 'block';
        }
    };
    reader.readAsDataURL(file);
}



//배경색 검증 - 더 엄격한 기준
function validateBackgroundColor(img, width, height) {
    const canvas = document.createElement('canvas');
    const ctx = canvas.getContext('2d');
    canvas.width = width;
    canvas.height = height;
    
    ctx.drawImage(img, 0, 0);
    
    // 배경 영역 샘플링 (가장자리 영역)
    const samplePoints = [];
    
    // 상단 가장자리
    for (let x = 0; x < width; x += 10) {
        samplePoints.push(ctx.getImageData(x, 0, 1, 1).data);
    }
    
    // 하단 가장자리
    for (let x = 0; x < width; x += 10) {
        samplePoints.push(ctx.getImageData(x, height-1, 1, 1).data);
    }
    
    // 좌우 가장자리
    for (let y = 0; y < height; y += 10) {
        samplePoints.push(ctx.getImageData(0, y, 1, 1).data);
        samplePoints.push(ctx.getImageData(width-1, y, 1, 1).data);
    }
    
    let whitePixelCount = 0;
    const threshold = 240; // 더 엄격한 흰색 기준
    
    samplePoints.forEach(pixel => {
        const [r, g, b] = pixel;
        if (r >= threshold && g >= threshold && b >= threshold) {
            whitePixelCount++;
        }
    });
    
    const whiteRatio = whitePixelCount / samplePoints.length;
    
    if (whiteRatio < 0.8) {
        showValidationMessage('배경이 충분히 흰색이 아닙니다. 완전한 흰색 배경을 사용해주세요.', false);
        return;
    }
    
    showValidationMessage('여권사진 규격에 적합합니다.', true);
}


async function convertWithIdPhotoAI(file) {
    try {
        // API 키 유효성 검사
        if (IDPHOTO_API_CONFIG.apiKey === 'YOUR_API_KEY') {
            throw new Error('IdPhoto.AI API 키가 설정되지 않았습니다.');
        }
        
        const imageBase64 = await fileToBase64(file);
        
        const requestBody = {
        	apiKey: f8qfQmSMPkXz3MA9,
            apiSecret: 7Z1bK0YSCwQnq2Oz5JxldDmtA8bpXq9qMR7DdKnPwd6Z9uyj5opSJv8Nw7ltsC9g,
            imageBase64: imageBase64,
            specCode: IDPHOTO_API_CONFIG.specCode
        };

        const response = await fetch(IDPHOTO_API_CONFIG.endpoint, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(requestBody)
        });

        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(`API 호출 실패: ${response.status} - ${errorText}`);
        }

        const result = await response.json();
        
        if (result.issues && result.issues.length > 0) {
            console.warn('사진 품질 문제:', result.issues);
            // 경고만 표시하고 계속 진행
        }

        return result.idPhotoUrl;
        
    } catch (error) {
        console.error('IdPhoto.AI API 오류:', error);
        throw error;
    }
}
</script>


</body>

</html>