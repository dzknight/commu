// common.js
// 공통 자바스크립트 함수들
// 이 파일은 HTML 문서에서 공통적으로 사용되는 자바스크립트 함수들을 포함합니다.

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

