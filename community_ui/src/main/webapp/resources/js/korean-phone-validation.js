
// 한국 전화번호 검증 및 처리 스크립트
class KoreanPhoneValidator {
    constructor() {
        this.currentPhoneType = 'mobile';
        this.selectedRegionCode = '';
        this.phoneNumber = '';
        this.verificationCode = '';
        this.timerInterval = null;
        this.timeRemaining = 300; // 5분
        
        // 한국 전화번호 정규식 패턴[1][4]
        this.patterns = {
            mobile: /^010-\d{4}-\d{4}$/, // 010-0000-0000
            landline: {
                seoul: /^02-\d{3,4}-\d{4}$/, // 02-000-0000 또는 02-0000-0000
                others: /^0(3[1-3]|4[1-4]|5[1-5]|6[1-4])-\d{3,4}-\d{4}$/ // 031-000-0000 등
            }
        };
        
        // 지역 코드 정보[1][2]
        this.regionCodes = {
            '02': { name: '서울특별시', pattern: /^\d{3,4}-\d{4}$/ },
            '031': { name: '경기도', pattern: /^\d{3,4}-\d{4}$/ },
            '032': { name: '인천광역시', pattern: /^\d{3,4}-\d{4}$/ },
            '033': { name: '강원도', pattern: /^\d{3,4}-\d{4}$/ },
            '041': { name: '충청남도', pattern: /^\d{3,4}-\d{4}$/ },
            '042': { name: '대전광역시', pattern: /^\d{3,4}-\d{4}$/ },
            '043': { name: '충청북도', pattern: /^\d{3,4}-\d{4}$/ },
            '044': { name: '세종특별자치시', pattern: /^\d{3,4}-\d{4}$/ },
            '051': { name: '부산광역시', pattern: /^\d{3,4}-\d{4}$/ },
            '052': { name: '울산광역시', pattern: /^\d{3,4}-\d{4}$/ },
            '053': { name: '대구광역시', pattern: /^\d{3,4}-\d{4}$/ },
            '054': { name: '경상북도', pattern: /^\d{3,4}-\d{4}$/ },
            '055': { name: '경상남도', pattern: /^\d{3,4}-\d{4}$/ }
        };
        
        this.init();
    }
    
    init() {
        this.bindEvents();
        this.setupPhoneInput();
        this.setupVerificationInputs();
    }
    
    bindEvents() {
        // 전화번호 타입 선택
        document.querySelectorAll('input[name="phoneType"]').forEach(radio => {
            radio.addEventListener('change', (e) => {
                this.handlePhoneTypeChange(e.target.value);
            });
        });
        
        // 지역 선택기
        const regionSelector = document.getElementById('regionDisplay');
        if (regionSelector) {
            regionSelector.addEventListener('click', () => {
                this.toggleRegionDropdown();
            });
        }
        
        // 지역 옵션 선택
        document.querySelectorAll('.dropdown-option').forEach(option => {
            option.addEventListener('click', (e) => {
                this.selectRegion(e.currentTarget);
            });
        });
        
        // 지역 검색
        const regionSearch = document.getElementById('regionSearch');
        if (regionSearch) {
            regionSearch.addEventListener('input', (e) => {
                this.filterRegions(e.target.value);
            });
        }
        
        // 전화번호 입력
        const phoneInput = document.getElementById('phoneNumber');
        if (phoneInput) {
            phoneInput.addEventListener('input', (e) => {
                this.handlePhoneInput(e.target.value);
            });
            
            phoneInput.addEventListener('keydown', (e) => {
                this.handlePhoneKeydown(e);
            });
        }
        
        // 버튼 이벤트
        const sendCodeBtn = document.getElementById('sendCodeBtn');
        if (sendCodeBtn) {
            sendCodeBtn.addEventListener('click', () => {
                this.sendVerificationCode();
            });
        }
        
        const verifyBtn = document.getElementById('verifyBtn');
        if (verifyBtn) {
            verifyBtn.addEventListener('click', () => {
                this.verifyCode();
            });
        }
        
        const resendBtn = document.getElementById('resendBtn');
        if (resendBtn) {
            resendBtn.addEventListener('click', () => {
                this.resendVerificationCode();
            });
        }
        
        // 개인정보 동의 체크박스
        const privacyCheck = document.getElementById('privacyCheck');
        if (privacyCheck) {
            privacyCheck.addEventListener('change', () => {
                this.updateButtonState();
            });
        }
        
        // 외부 클릭 시 드롭다운 닫기
        document.addEventListener('click', (e) => {
            if (!e.target.closest('.custom-select')) {
                this.closeRegionDropdown();
            }
        });
    }
    
    handlePhoneTypeChange(type) {
        this.currentPhoneType = type;
        
        // 타입 옵션 UI 업데이트
        document.querySelectorAll('.type-option').forEach(option => {
            option.classList.remove('active');
        });
        
        document.querySelector(`[data-type="${type}"]`).classList.add('active');
        
        // 지역 선택기 표시/숨김
        const regionSelector = document.getElementById('regionSelector');
        const areaCodeDisplay = document.getElementById('areaCodeDisplay');
        const areaCodeText = document.getElementById('areaCodeText');
        
        if (type === 'landline') {
            regionSelector.style.display = 'block';
            areaCodeText.textContent = this.selectedRegionCode || '지역';
        } else {
            regionSelector.style.display = 'none';
            areaCodeText.textContent = '010';
            this.selectedRegionCode = '010';
        }
        
        // 입력 필드 초기화
        this.resetPhoneInput();
        this.updatePlaceholder();
        this.updateButtonState();
    }
    
    toggleRegionDropdown() {
        const customSelect = document.querySelector('.custom-select');
        customSelect.classList.toggle('open');
    }
    
    closeRegionDropdown() {
        const customSelect = document.querySelector('.custom-select');
        customSelect.classList.remove('open');
    }
    
    selectRegion(optionElement) {
        const code = optionElement.dataset.code;
        const name = optionElement.dataset.name;
        
        this.selectedRegionCode = code;
        
        // UI 업데이트
        document.getElementById('regionDisplay').querySelector('.selected-text').textContent = name;
        document.getElementById('areaCodeText').textContent = code;
        
        // 선택된 옵션 표시
        document.querySelectorAll('.dropdown-option').forEach(opt => {
            opt.classList.remove('selected');
        });
        optionElement.classList.add('selected');
        
        this.closeRegionDropdown();
        this.resetPhoneInput();
        this.updatePlaceholder();
        this.updateButtonState();
    }
    
    filterRegions(searchTerm) {
        const options = document.querySelectorAll('.dropdown-option');
        
        options.forEach(option => {
            const name = option.dataset.name.toLowerCase();
            const code = option.dataset.code;
            const search = searchTerm.toLowerCase();
            
            if (name.includes(search) || code.includes(search)) {
                option.style.display = 'flex';
            } else {
                option.style.display = 'none';
            }
        });
    }
    
    setupPhoneInput() {
        this.updatePlaceholder();
    }
    
    updatePlaceholder() {
        const phoneInput = document.getElementById('phoneNumber');
        
        if (this.currentPhoneType === 'mobile') {
            phoneInput.placeholder = '1234-5678';
            phoneInput.maxLength = 9;
        } else {
            if (this.selectedRegionCode === '02') {
                phoneInput.placeholder = '123-4567 또는 1234-5678';
            } else {
                phoneInput.placeholder = '123-4567';
            }
            phoneInput.maxLength = 9;
        }
    }
    
    handlePhoneInput(value) {
        // 숫자와 하이픈만 허용
        let cleanValue = value.replace(/[^\d-]/g, '');
        
        // 자동 하이픈 삽입
        cleanValue = this.formatPhoneNumber(cleanValue);
        
        // 입력 필드 업데이트
        const phoneInput = document.getElementById('phoneNumber');
        phoneInput.value = cleanValue;
        
        this.phoneNumber = cleanValue;
        this.validatePhoneNumber(cleanValue);
    }
    
    formatPhoneNumber(value) {
        // 하이픈 제거
        const numbersOnly = value.replace(/-/g, '');
        
        if (this.currentPhoneType === 'mobile') {
            // 휴대폰: 1234-5678
            if (numbersOnly.length <= 4) {
                return numbersOnly;
            } else {
                return numbersOnly.slice(0, 4) + '-' + numbersOnly.slice(4, 8);
            }
        } else {
            // 일반전화: 지역에 따라 다름
            if (this.selectedRegionCode === '02') {
                // 서울: 123-4567 또는 1234-5678
                if (numbersOnly.length <= 3) {
                    return numbersOnly;
                } else if (numbersOnly.length <= 7) {
                    return numbersOnly.slice(0, 3) + '-' + numbersOnly.slice(3);
                } else if (numbersOnly.length === 8) {
                    return numbersOnly.slice(0, 4) + '-' + numbersOnly.slice(4);
                }
            } else {
                // 기타 지역: 123-4567
                if (numbersOnly.length <= 3) {
                    return numbersOnly;
                } else {
                    return numbersOnly.slice(0, 3) + '-' + numbersOnly.slice(3, 7);
                }
            }
        }
        
        return value;
    }
    
    handlePhoneKeydown(e) {
        // 백스페이스로 하이픈 자동 삭제
        if (e.key === 'Backspace') {
            const input = e.target;
            const cursorPos = input.selectionStart;
            const value = input.value;
            
            if (cursorPos > 0 && value[cursorPos - 1] === '-') {
                e.preventDefault();
                const newValue = value.slice(0, cursorPos - 2) + value.slice(cursorPos);
                input.value = newValue;
                input.setSelectionRange(cursorPos - 1, cursorPos - 1);
                this.handlePhoneInput(newValue);
            }
        }
    }
    
    validatePhoneNumber(phoneNumber) {
        const container = document.getElementById('phoneInputContainer');
        const validationStatus = document.getElementById('validationStatus');
        const validationMessage = document.getElementById('validationMessage');
        
        // 상태 아이콘 초기화
        validationStatus.querySelectorAll('.status-icon').forEach(icon => {
            icon.classList.remove('active');
        });
        
        if (!phoneNumber) {
            container.classList.remove('valid', 'invalid');
            validationMessage.classList.remove('show');
            this.updateButtonState();
            return;
        }
        
        let isValid = false;
        let message = '';
        
        if (this.currentPhoneType === 'mobile') {
            // 휴대폰 번호 검증[4]
            const fullNumber = `010-${phoneNumber}`;
            isValid = this.patterns.mobile.test(fullNumber);
            
            if (phoneNumber.length < 9) {
                message = '휴대폰 번호를 완전히 입력해주세요.';
                this.showValidationMessage(message, 'info');
                validationStatus.querySelector('.loading').classList.add('active');
            } else if (isValid) {
                message = '유효한 휴대폰 번호입니다.';
                this.showValidationMessage(message, 'success');
                validationStatus.querySelector('.valid').classList.add('active');
                container.classList.add('valid');
                container.classList.remove('invalid');
            } else {
                message = '올바른 휴대폰 번호 형식이 아닙니다.';
                this.showValidationMessage(message, 'error');
                validationStatus.querySelector('.invalid').classList.add('active');
                container.classList.add('invalid');
                container.classList.remove('valid');
            }
        } else {
            // 일반전화 번호 검증
            if (!this.selectedRegionCode) {
                message = '지역을 먼저 선택해주세요.';
                this.showValidationMessage(message, 'error');
                validationStatus.querySelector('.invalid').classList.add('active');
                container.classList.add('invalid');
                container.classList.remove('valid');
                this.updateButtonState();
                return;
            }
            
            const regionInfo = this.regionCodes[this.selectedRegionCode];
            if (regionInfo) {
                isValid = regionInfo.pattern.test(phoneNumber);
                
                if (phoneNumber.length < 7) {
                    message = '전화번호를 완전히 입력해주세요.';
                    this.showValidationMessage(message, 'info');
                    validationStatus.querySelector('.loading').classList.add('active');
                } else if (isValid) {
                    message = `유효한 ${regionInfo.name} 전화번호입니다.`;
                    this.showValidationMessage(message, 'success');
                    validationStatus.querySelector('.valid').classList.add('active');
                    container.classList.add('valid');
                    container.classList.remove('invalid');
                } else {
                    message = '올바른 전화번호 형식이 아닙니다.';
                    this.showValidationMessage(message, 'error');
                    validationStatus.querySelector('.invalid').classList.add('active');
                    container.classList.add('invalid');
                    container.classList.remove('valid');
                }
            }
        }
        
        this.updateButtonState();
        return isValid;
    }
    
    showValidationMessage(message, type) {
        const validationMessage = document.getElementById('validationMessage');
        
        validationMessage.textContent = message;
        validationMessage.className = `validation-message ${type} show`;
    }
    
    getFullPhoneNumber() {
        if (this.currentPhoneType === 'mobile') {
            return `010-${this.phoneNumber}`;
        } else {
            return `${this.selectedRegionCode}-${this.phoneNumber}`;
        }
    }
    
    updateButtonState() {
        const sendCodeBtn = document.getElementById('sendCodeBtn');
        const privacyCheck = document.getElementById('privacyCheck');
        
        const isPhoneValid = this.validatePhoneNumber(this.phoneNumber);
        const isPrivacyChecked = privacyCheck.checked;
        
        sendCodeBtn.disabled = !(isPhoneValid && isPrivacyChecked);
    }
    
    resetPhoneInput() {
        const phoneInput = document.getElementById('phoneNumber');
        const container = document.getElementById('phoneInputContainer');
        const validationMessage = document.getElementById('validationMessage');
        const validationStatus = document.getElementById('validationStatus');
        
        phoneInput.value = '';
        this.phoneNumber = '';
        container.classList.remove('valid', 'invalid');
        validationMessage.classList.remove('show');
        
        validationStatus.querySelectorAll('.status-icon').forEach(icon => {
            icon.classList.remove('active');
        });
    }
    
    setupVerificationInputs() {
        const codeInputs = document.querySelectorAll('.code-input');
        
        codeInputs.forEach((input, index) => {
            input.addEventListener('input', (e) => {
                this.handleCodeInput(e, index);
            });
            
            input.addEventListener('keydown', (e) => {
                this.handleCodeKeydown(e, index);
            });
            
            input.addEventListener('paste', (e) => {
                this.handleCodePaste(e);
            });
        });
    }
    
    handleCodeInput(e, index) {
        const input = e.target;
        const value = input.value.replace(/[^\d]/g, ''); // 숫자만 허용
        
        input.value = value;
        
        if (value) {
            input.classList.add('filled');
            
            // 다음 입력 필드로 포커스 이동
            if (index < 5) {
                const nextInput = document.querySelector(`[data-index="${index + 1}"]`);
                if (nextInput) {
                    nextInput.focus();
                }
            }
        } else {
            input.classList.remove('filled');
        }
        
        this.updateVerificationCode();
        this.updateVerifyButtonState();
    }
    
    handleCodeKeydown(e, index) {
        if (e.key === 'Backspace' && !e.target.value && index > 0) {
            // 현재 입력이 비어있으면 이전 입력으로 포커스 이동
            const prevInput = document.querySelector(`[data-index="${index - 1}"]`);
            if (prevInput) {
                prevInput.focus();
            }
        } else if (e.key === 'ArrowLeft' && index > 0) {
            const prevInput = document.querySelector(`[data-index="${index - 1}"]`);
            if (prevInput) {
                prevInput.focus();
            }
        } else if (e.key === 'ArrowRight' && index < 5) {
            const nextInput = document.querySelector(`[data-index="${index + 1}"]`);
            if (nextInput) {
                nextInput.focus();
            }
        }
    }
    
    handleCodePaste(e) {
        e.preventDefault();
        const pastedData = e.clipboardData.getData('text').replace(/[^\d]/g, '');
        
        if (pastedData.length === 6) {
            const codeInputs = document.querySelectorAll('.code-input');
            
            codeInputs.forEach((input, index) => {
                if (index < pastedData.length) {
                    input.value = pastedData[index];
                    input.classList.add('filled');
                }
            });
            
            this.updateVerificationCode();
            this.updateVerifyButtonState();
            
            // 마지막 입력 필드에 포커스
            codeInputs[5].focus();
        }
    }
    
    updateVerificationCode() {
        const codeInputs = document.querySelectorAll('.code-input');
        this.verificationCode = Array.from(codeInputs).map(input => input.value).join('');
    }
    
    updateVerifyButtonState() {
        const verifyBtn = document.getElementById('verifyBtn');
        verifyBtn.disabled = this.verificationCode.length !== 6;
    }
    
    async sendVerificationCode() {
        const sendCodeBtn = document.getElementById('sendCodeBtn');
        const fullPhoneNumber = this.getFullPhoneNumber();
        
        try {
            // 로딩 상태 표시
            sendCodeBtn.classList.add('loading');
            sendCodeBtn.disabled = true;
            
            // 서버에 인증번호 전송 요청 (실제 구현에서는 서버 API 호출)
            await this.simulateApiCall(2000); // 2초 대기
            
            // 성공 시 UI 업데이트
            this.showVerificationSection();
            this.updateProgressStep(2);
            this.startTimer();
            
            // 버튼 상태 변경
            sendCodeBtn.style.display = 'none';
            document.getElementById('verifyBtn').style.display = 'block';
            
            this.showValidationMessage(
                `${fullPhoneNumber}로 인증번호가 전송되었습니다.`, 
                'success'
            );
            
        } catch (error) {
            console.error('인증번호 전송 실패:', error);
            this.showValidationMessage('인증번호 전송에 실패했습니다. 다시 시도해주세요.', 'error');
        } finally {
            sendCodeBtn.classList.remove('loading');
            sendCodeBtn.disabled = false;
        }
    }
    
    async verifyCode() {
        const verifyBtn = document.getElementById('verifyBtn');
        
        if (this.verificationCode.length !== 6) {
            this.showCodeError('6자리 인증번호를 입력해주세요.');
            return;
        }
        
        try {
            // 로딩 상태 표시
            verifyBtn.classList.add('loading');
            verifyBtn.disabled = true;
            
            // 서버에 인증 확인 요청 (실제 구현에서는 서버 API 호출)
            await this.simulateApiCall(1500);
            
            // 인증 성공 (실제로는 서버 응답에 따라 결정)
            const isValid = this.verificationCode === '123456'; // 테스트용
            
            if (isValid) {
                this.handleVerificationSuccess();
            } else {
                this.showCodeError('인증번호가 일치하지 않습니다.');
            }
            
        } catch (error) {
            console.error('인증 확인 실패:', error);
            this.showCodeError('인증 확인 중 오류가 발생했습니다.');
        } finally {
            verifyBtn.classList.remove('loading');
            verifyBtn.disabled = false;
        }
    }
    
    handleVerificationSuccess() {
        // 타이머 중지
        this.stopTimer();
        
        // 진행 단계 업데이트
        this.updateProgressStep(3);
        
        // 버튼 변경
        document.getElementById('verifyBtn').style.display = 'none';
        document.getElementById('completeBtn').style.display = 'block';
        
        // 인증 코드 입력 비활성화
        document.querySelectorAll('.code-input').forEach(input => {
            input.disabled = true;
            input.classList.add('filled');
        });
        
        // 성공 메시지
        this.showValidationMessage('전화번호 인증이 완료되었습니다!', 'success');
        
        // 성공 모달 표시
        setTimeout(() => {
            this.showSuccessModal();
        }, 500);
    }
    
    showCodeError(message) {
        // 인증번호 입력 필드에 오류 표시
        document.querySelectorAll('.code-input').forEach(input => {
            input.classList.add('error');
        });
        
        // 오류 메시지 표시
        this.showValidationMessage(message, 'error');
        
        // 0.5초 후 오류 스타일 제거
        setTimeout(() => {
            document.querySelectorAll('.code-input').forEach(input => {
                input.classList.remove('error');
            });
        }, 500);
    }
    
    async resendVerificationCode() {
        const resendBtn = document.getElementById('resendBtn');
        
        try {
            resendBtn.disabled = true;
            resendBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 전송중...';
            
            // 서버에 재전송 요청
            await this.simulateApiCall(1500);
            
            // 타이머 재시작
            this.timeRemaining = 300;
            this.startTimer();
            
            // 인증번호 입력 필드 초기화
            this.clearVerificationCode();
            
            this.showValidationMessage('인증번호가 재전송되었습니다.', 'success');
            
        } catch (error) {
            console.error('재전송 실패:', error);
            this.showValidationMessage('인증번호 재전송에 실패했습니다.', 'error');
        } finally {
            resendBtn.innerHTML = '<i class="fas fa-redo"></i> 인증번호 재전송';
            
            // 30초 후 재활성화
            setTimeout(() => {
                resendBtn.disabled = false;
            }, 30000);
        }
    }
    
    showVerificationSection() {
        const verificationSection = document.getElementById('verificationSection');
        verificationSection.style.display = 'block';
        
        // 첫 번째 입력 필드에 포커스
        setTimeout(() => {
            document.querySelector('.code-input').focus();
        }, 300);
    }
    
    startTimer() {
        this.stopTimer(); // 기존 타이머 중지
        
        const timerDisplay = document.getElementById('timerDisplay');
        const resendBtn = document.getElementById('resendBtn');
        
        resendBtn.disabled = true;
        
        this.timerInterval = setInterval(() => {
            this.timeRemaining--;
            
            const minutes = Math.floor(this.timeRemaining / 60);
            const seconds = this.timeRemaining % 60;
            
            timerDisplay.textContent = 
                `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
            
            if (this.timeRemaining <= 0) {
                this.stopTimer();
                this.handleTimerExpired();
            }
        }, 1000);
    }
    
    stopTimer() {
        if (this.timerInterval) {
            clearInterval(this.timerInterval);
            this.timerInterval = null;
        }
    }
    
    handleTimerExpired() {
        const timerDisplay = document.getElementById('timerDisplay');
        const resendBtn = document.getElementById('resendBtn');
        
        timerDisplay.textContent = '시간 만료';
        timerDisplay.style.color = 'var(--error-color)';
        
        resendBtn.disabled = false;
        
        // 인증번호 입력 필드 비활성화
        document.querySelectorAll('.code-input').forEach(input => {
            input.disabled = true;
        });
        
        this.showValidationMessage('인증 시간이 만료되었습니다. 인증번호를 재전송해주세요.', 'error');
    }
    
    clearVerificationCode() {
        document.querySelectorAll('.code-input').forEach(input => {
            input.value = '';
            input.disabled = false;
            input.classList.remove('filled', 'error');
        });
        
        this.verificationCode = '';
        this.updateVerifyButtonState();
        
        // 첫 번째 입력 필드에 포커스
        document.querySelector('.code-input').focus();
    }
    
    updateProgressStep(step) {
        const steps = document.querySelectorAll('.step');
        
        steps.forEach((stepElement, index) => {
            const stepNumber = index + 1;
            
            if (stepNumber < step) {
                stepElement.classList.add('completed');
                stepElement.classList.remove('active');
            } else if (stepNumber === step) {
                stepElement.classList.add('active');
                stepElement.classList.remove('completed');
            } else {
                stepElement.classList.remove('active', 'completed');
            }
        });
    }
    
    showSuccessModal() {
        const modal = document.getElementById('successModal');
        modal.style.display = 'flex';
        
        // 애니메이션을 위한 지연
        setTimeout(() => {
            modal.classList.add('show');
        }, 10);
    }
    
    // API 호출 시뮬레이션 (실제 구현에서는 실제 서버 API 호출)
    simulateApiCall(delay) {
        return new Promise((resolve, reject) => {
            setTimeout(() => {
                // 90% 확률로 성공
                if (Math.random() > 0.1) {
                    resolve({ success: true });
                } else {
                    reject(new Error('API 호출 실패'));
                }
            }, delay);
        });
    }
}

// 성공 모달 닫기 함수
function closeSuccessModal() {
    const modal = document.getElementById('successModal');
    modal.classList.remove('show');
    
    setTimeout(() => {
        modal.style.display = 'none';
        
        // 실제 회원가입 폼으로 이동하거나 다음 단계 처리
        alert('회원가입 다음 단계로 이동합니다.');
        // window.location.href = '/signup/next';
    }, 300);
}

// DOM 로드 완료 시 초기화
document.addEventListener('DOMContentLoaded', () => {
    new KoreanPhoneValidator();
});

// 페이지 언로드 시 타이머 정리
window.addEventListener('beforeunload', () => {
    const validator = window.koreanPhoneValidator;
    if (validator && validator.timerInterval) {
        clearInterval(validator.timerInterval);
    }
});

