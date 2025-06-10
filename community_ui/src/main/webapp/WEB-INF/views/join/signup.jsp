<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<!-- jQuery는 하나만 불러오도록 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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
	#signUp select, #signUp input[type="date"] {
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

.button-group {
	display: flex;
	gap: 10px;
	margin-top: 5px;
	justify-content: center;
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

#signUp button[type="submit"]:disabled {
	background-color: #6c757d;
	cursor: not-allowed;
}

#cancelBtn {
	padding: 10px 16px;
	background-color: #6c757d;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
	transition: background-color 0.3s ease;
	margin-top: 5px;
}

#cancelBtn:hover {
	background-color: #5a6268;
}

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

#signUp input[type="file"] {
	width: 100%;
	padding: 8px 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: #fff;
	cursor: pointer;
	box-sizing: border-box;
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

#photoPreview {
	display: none;
	max-width: 100%;
	max-height: 300px;
	border: 1px solid #ddd;
	margin-top: 10px;
}

#emailAuthBtn {
	padding: 8px 14px;
	background-color: #28a745;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
	transition: background-color 0.3s ease;
}

#emailAuthBtn:hover {
	background-color: #218838;
}

#photoValidation {
	margin-top: 10px;
	font-size: 14px;
}

.success {
	color: green;
}

.error {
	color: red;
}

.photo-grid {
    display: grid;
    grid-template-columns: 3.5fr;
    grid-template-rows: 4.5fr;
    width: 350px;
    height: 450px;
}

.passport-ratio-container {
    width: 350px;
    height: 450px;
    overflow: hidden;
    position: relative;
}

.passport-ratio-container img {
    width: 100%;
    height: 100%;
    object-fit: cover; /* 비율 유지하며 크롭 */
    object-position: center; /* 중앙 정렬 */
}

/* 로딩 상태 스타일 */
.loading {
    color: #007bff;
    font-weight: bold;
    animation: pulse 1.5s ease-in-out infinite alternate;
}

@keyframes pulse {
    from { opacity: 1; }
    to { opacity: 0.5; }
}

/* AI 변환 옵션 스타일 */
.ai-convert-options {
    margin-top: 10px;
    padding: 10px;
    background-color: #f8f9fa;
    border-radius: 4px;
    border: 1px solid #dee2e6;
}

.ai-convert-options label {
    font-weight: normal;
    margin-bottom: 5px;
}

.ai-convert-options select {
    width: auto;
    margin-left: 10px;
}
</style>

<script>
let isValidPhoto = false;
let isIdChecked = false;
let isPasswordValid = false;
let isPasswordConfirmed = false;

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
// 우편번호 검색 함수
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
            updateFullAddress();
        }
    }).open();
}

// 주소 업데이트 함수
function updateFullAddress() {
    const address = document.getElementById('address').value;
    const detailAddress = document.getElementById('detailAddress').value;
    document.getElementById('fullAddress').value = (address + ' ' + detailAddress).trim();
}

// 이메일 업데이트 함수
function updateFullEmail() {
    const emailId = document.getElementById('email_id').value;
    const emailDomain = document.getElementById('email_domain_input').value;
    document.getElementById('fullEmail').value = emailId + '@' + emailDomain;
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

// DOM 로드 완료 후 이벤트 리스너 등록
document.addEventListener('DOMContentLoaded', function() {
    // 상세 주소 입력 시 fullAddress 갱신
    const detailAddressInput = document.getElementById('detailAddress');
    if (detailAddressInput) {
        detailAddressInput.addEventListener('input', updateFullAddress);
    }
    
    // 이메일 도메인 변경 시
    const emailDomainSelect = document.getElementById('email_domain');
    if (emailDomainSelect) {
        emailDomainSelect.addEventListener('change', function() {
            const selectedValue = this.value;
            const emailDomainInput = document.getElementById('email_domain_input');
            if (emailDomainInput) {
                emailDomainInput.value = selectedValue;
                updateFullEmail();
            }
        });
    }
    
    // 이메일 아이디 입력 시
    const emailIdInput = document.getElementById('email_id');
    if (emailIdInput) {
        emailIdInput.addEventListener('input', updateFullEmail);
    }
    
    // 프로필 이미지 변경 시 - 완전한 이벤트 리스너
    const profileImageInput = document.getElementById('profileImage');
    if (profileImageInput) {
        profileImageInput.addEventListener('change', function(e) {
            const file = e.target.files[0];
            const photoPreview = document.getElementById('photoPreview');
            const photoValidation = document.getElementById('photoValidation');
            
            if (!file) {
                if (photoPreview) photoPreview.style.display = 'none';
                if (photoValidation) photoValidation.innerHTML = '';
                isValidPhoto = false;
                updateSubmitButtonState();
                return;
            }
            
            // 파일 크기 검증 (2MB 제한으로 증가)
            const maxSize = 3 * 1024 * 1024;
            if (file.size > maxSize) {
                showValidationMessage('파일 크기가 3MB를 초과합니다.', false);
                return;
            }
            
            // 파일 형식 검증
            const allowedTypes = ['image/jpeg', 'image/png', 'image/jpg'];
            if (!allowedTypes.includes(file.type)) {
                showValidationMessage('JPEG 또는 PNG 파일만 업로드 가능합니다.', false);
                return;
            }
            
            // 이미지 크기 및 비율 검증
            validateImageDimensions(file);
        });
    }
});
</script>
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
</head>

<body>
	<form action="${pageContext.request.contextPath}/join" method="post"
		enctype="multipart/form-data" id="signUpForm">
		<table id="signUp">
			<thead>
				<tr>
					<th>회원가입 정보 입력</th>
				</tr>
			</thead>
			<tbody>
			<tr>
				<td>
					<label for="userId">아이디</label>
					<div class="id-check-container">
						<input type="text" name="userId" id="userId" maxlength="10"
							placeholder="아이디를 입력하세요" required onkeyup="validateUserId()">
						<button type="button" id="idCheckBtn">중복체크</button>
					</div>
					<div>
						<span id="idCheckStatus" style="font-size: small;"></span>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<label for="userPassword">비밀번호</label> 
					<input type="password" name="userPassword" id="userPassword"
						placeholder="비밀번호를 입력하세요" required maxlength="12">
					<div id="passwordCheck1"></div>
				</td>
			</tr>
			<tr>
				<td>
					<label for="userPasswordConfirm">비밀번호 확인</label> 
					<input type="password" name="userPasswordConfirm" id="userPasswordConfirm" 
						placeholder="비밀번호를 한 번 더 입력하세요" required maxlength="12">
					<div id="passwordCheck2"></div>
				</td>
			</tr>
			<tr>
				<td>
					<label for="userName">이름</label> 
					<input type="text" name="userName" id="userName" placeholder="이름을 입력하세요" 
						required maxlength="10" pattern="[가-힣]{2,10}" 
						title="이름은 한글로 2자 이상 10자 이하로 입력해주세요." onkeyup="validateUserName()">	
				</td>
			</tr>
			<tr>
				<td>
					<label for="zipCode">우편번호</label>
					<input type="text" name="zipCode" id="zipCode" placeholder="우편번호" readonly required>
					<button type="button" class="zipcode-btn" onclick="searchZipcode()">우편번호검색</button>
				</td>
			</tr>
			<tr>
				<td>
					<label for="address">주소</label>
					<input type="text" id="address" placeholder="주소를 입력하세요" readonly required>
				    <input type="text" name="detailAddress" id="detailAddress" placeholder="상세 주소를 입력하세요" required>
					<input type="hidden" name="address" id="fullAddress">
				</td>
			</tr>
			<tr>
				<td>
					<label for="userEmail">이메일</label>
					<div class="email-group">
						<input type="text" name="email_id" id="email_id" placeholder="이메일 아이디" 
							required onkeyup="validateEmail()" maxlength="10" />
						<span>@</span>
						<input type="hidden" name="email_domain" id="email_domain_input" value="naver.com" required />   
						<select name="emailDomain" id="email_domain" required>
							<option value="naver.com" selected>naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="daum.net">daum.net</option>
							<option value="nate.com">nate.com</option>
							<option value="yahoo.com">yahoo.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="hotmail.com">hotmail.com</option>
							<option value="kakao.com">kakao.com</option>
						</select>
						<button type="button" name="email" id="emailAuthBtn">인증메일 보내기</button>
						<input type="hidden" name="fullEmail" id="fullEmail">
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<label for="phoneNum">휴대폰번호</label> 
					<input type="text" id="phoneNum" name="userPhoneNum" maxlength="11" 
						placeholder="숫자만 입력" required>
				</td>
			</tr>
			<tr>
				<td>
					<label for="birthdate">생년월일:</label>
					<input type="date" name="birthdate" id="birthdate" required onchange="validateBirthdate()" />
				</td>
			</tr>
			<tr>
				<td>
					<label for="profileImage">프로필 사진 (여권 규격):</label>
					<!-- AI 변환 옵션 -->
			        <div class="ai-convert-options">
			            <label>
			                <input type="checkbox" id="enableAiConvert" checked> 
			                AI 자동 여권사진 변환 사용
			            </label>
			            <select id="aiProvider">
			                <option value="idphoto">IdPhoto.AI (권장)</option>
			            </select>
			        </div>
			        
			        <input type="file" id="profileImage" name="profileImageFile" accept="image/jpeg,image/jpg,image/png">
			        <div id="photoValidation"></div>
			        <img id="photoPreview" class="profile-preview" style="display: none;" alt="프로필 사진 미리보기">
			        
			        <!-- 원본 이미지 복원 버튼 -->
			        <button type="button" id="restoreOriginal" style="display: none; margin-top: 10px;">
			            원본 이미지로 복원
			        </button>
			    </td>
			</tr>
			<tr>
				<td>
					<div class="button-group">
						<button type="submit" id="submitBtn">가입</button>
						<button type="reset" id="cancelBtn">초기화</button>
					</div>
				</td>
			</tr>
			</tbody>
		</table>
	</form>
</body>
</html>