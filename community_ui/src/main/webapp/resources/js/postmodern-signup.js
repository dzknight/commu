// 포스트모던 사인업 JavaScript
class PostmodernSignup {
  constructor() {
    this.currentStep = 1;
    this.totalSteps = 5;
    this.validationState = {
      isIdChecked: false,
      isPasswordValid: false,
      isPasswordConfirmed: false,
      emailVerified: false,
      isValidPhoto: false,
    };
    this.timerInterval = null;

    this.init();
  }

  init() {
    this.bindEvents();
    this.initAnimations();
    this.updateProgress();
  }

  bindEvents() {
    // 아이디 중복 체크
    $("#idCheckBtn").click(() => this.checkUserId());

    // 비밀번호 검증
    $("#userPassword").on("input", () => this.validatePassword());
    $("#userPasswordConfirm").on("input", () => this.validatePasswordConfirm());

    // 이메일 관련
    $("#email_id, #email_domain").on("input change", () =>
      this.updateFullEmail()
    );
    $("#emailAuthBtn").click(() => this.sendEmailVerification());
    $("#verifyCodeBtn").click(() => this.verifyEmailCode());

    // 전화번호 통합
    $("#phoneNum0, #phoneNum1, #phoneNum2").on("input", () =>
      this.updatePhoneNumber()
    );

    // 파일 업로드
    $("#profileImage").change((e) => this.handleFileUpload(e));
    $("#uploadZone").click(() => $("#profileImage").click());

    // 폼 제출
    $("#signUpForm").submit((e) => this.handleSubmit(e));

    // 우편번호 검색
    window.searchZipcode = () => this.searchZipcode();
  }

  initAnimations() {
    // 페이지 로드 애니메이션
    $(".form-section").each(function (index) {
      $(this)
        .css({
          opacity: 0,
          transform: "translateY(30px)",
        })
        .delay(index * 200)
        .animate(
          {
            opacity: 1,
          },
          600
        )
        .css("transform", "translateY(0)");
    });
  }

  updateProgress() {
    const progress = (this.currentStep / this.totalSteps) * 100;
    $(".progress-fill").css("width", `${progress}%`);
    $(".current-step").text(String(this.currentStep).padStart(2, "0"));

    // 단계별 레이블 업데이트
    const labels = [
      "Identity Creation",
      "Location Mapping",
      "Contact Establishment",
      "Avatar Configuration",
      "Launch Sequence",
    ];
    $(".step-label").text(labels[this.currentStep - 1]);
  }

  async checkUserId() {
    const userId = $("#userId").val().trim();
    const $btn = $("#idCheckBtn");
    const $status = $("#idCheckStatus");

    if (!userId) {
      this.showValidationMessage(
        $status,
        "🚫 Identity field cannot be empty!",
        "error"
      );
      return;
    }

    if (!/^[a-zA-Z0-9]{4,10}$/.test(userId)) {
      this.showValidationMessage(
        $status,
        "⚠️ Use only letters and numbers (4-10 chars)",
        "error"
      );
      return;
    }

    try {
      $btn
        .prop("disabled", true)
        .html('<i class="fas fa-spinner fa-spin"></i> CHECKING...');

      const response = await $.ajax({
        type: "POST",
        url: $("#signUpForm").data("context-path") + "/userIdCheck",
        data: { userId: userId },
        dataType: "json",
      });

      if (response.count === 0) {
        this.showValidationMessage(
          $status,
          "✅ Identity verified and available!",
          "success"
        );
        this.validationState.isIdChecked = true;
        this.updateStepProgress();
      } else {
        this.showValidationMessage(
          $status,
          "❌ This identity is already taken",
          "error"
        );
        this.validationState.isIdChecked = false;
      }
    } catch (error) {
      this.showValidationMessage(
        $status,
        "🔥 Connection error occurred",
        "error"
      );
      this.validationState.isIdChecked = false;
    } finally {
      $btn
        .prop("disabled", false)
        .html('<span>VERIFY</span><i class="fas fa-search"></i>');
      this.updateSubmitButton();
    }
  }

  validatePassword() {
    const password = $("#userPassword").val();
    const $message = $("#passwordCheck1");
    const $strengthBar = $(".strength-bar");

    if (!password) {
      this.showValidationMessage(
        $message,
        "🔐 Create your secret code",
        "info"
      );
      this.validationState.isPasswordValid = false;
      $strengthBar.css("width", "0%");
      return;
    }

    const strength = this.calculatePasswordStrength(password);
    $strengthBar.css("width", `${strength}%`);

    if (strength >= 80) {
      this.showValidationMessage(
        $message,
        "🔥 Incredibly strong secret!",
        "success"
      );
      this.validationState.isPasswordValid = true;
    } else if (strength >= 60) {
      this.showValidationMessage(
        $message,
        "⚡ Strong enough for most systems",
        "success"
      );
      this.validationState.isPasswordValid = true;
    } else {
      this.showValidationMessage(
        $message,
        "⚠️ Needs letters, numbers & symbols (8+ chars)",
        "error"
      );
      this.validationState.isPasswordValid = false;
    }

    this.updateSubmitButton();
  }

  calculatePasswordStrength(password) {
    let strength = 0;

    if (password.length >= 8) strength += 25;
    if (password.length >= 12) strength += 25;
    if (/[a-z]/.test(password)) strength += 12.5;
    if (/[A-Z]/.test(password)) strength += 12.5;
    if (/[0-9]/.test(password)) strength += 12.5;
    if (/[^a-zA-Z0-9]/.test(password)) strength += 12.5;

    return Math.min(strength, 100);
  }

  validatePasswordConfirm() {
    const password = $("#userPassword").val();
    const confirmPassword = $("#userPasswordConfirm").val();
    const $message = $("#passwordCheck2");

    if (!confirmPassword) {
      this.showValidationMessage(
        $message,
        "🔄 Confirm your secret code",
        "info"
      );
      this.validationState.isPasswordConfirmed = false;
      return;
    }

    if (password === confirmPassword) {
      this.showValidationMessage(
        $message,
        "✅ Secrets match perfectly!",
        "success"
      );
      this.validationState.isPasswordConfirmed = true;
    } else {
      this.showValidationMessage($message, "❌ Secrets don't match", "error");
      this.validationState.isPasswordConfirmed = false;
    }

    this.updateSubmitButton();
  }

  updateFullEmail() {
    const emailId = $("#email_id").val();
    const emailDomain = $("#email_domain").val();
    const fullEmail = emailId + "@" + emailDomain;

    $("#fullEmail").val(fullEmail);
    $("#email_domain_input").val(emailDomain);
  }

  async sendEmailVerification() {
    const email = $("#fullEmail").val();
    const $btn = $("#emailAuthBtn");

    if (!email || !email.includes("@")) {
      alert("🚫 Please enter a valid email address!");
      return;
    }

    try {
      $btn
        .prop("disabled", true)
        .html('<i class="fas fa-spinner fa-spin"></i> SENDING...');

      const response = await $.ajax({
        url: $("#signUpForm").data("context-path") + "/mailsend",
        type: "POST",
        data: { fullEmail: email },
        timeout: 10000,
      });

      if (response.success) {
        $("#emailAuthSection").show();
        this.startEmailTimer(300); // 5분
        this.showNotification(
          "📧 Verification code sent to your email!",
          "success"
        );
        $btn.html('<span>RESEND</span><i class="fas fa-redo"></i>');
      } else {
        this.showNotification("❌ Failed to send verification code", "error");
      }
    } catch (error) {
      this.showNotification("🔥 Network error occurred", "error");
    } finally {
      $btn.prop("disabled", false);
    }
  }

  async verifyEmailCode() {
    const email = $("#fullEmail").val();
    const code = $("#authCode").val();
    const $btn = $("#verifyCodeBtn");

    if (!code || code.length !== 6) {
      alert("🚫 Please enter the 6-digit verification code!");
      return;
    }

    try {
      $btn
        .prop("disabled", true)
        .html('<i class="fas fa-spinner fa-spin"></i> VERIFYING...');

      const response = await $.ajax({
        url: $("#signUpForm").data("context-path") + "/verify-email-code",
        type: "POST",
        data: { email: email, code: code },
      });

      if (response.success) {
        this.validationState.emailVerified = true;
        this.clearEmailTimer();
        $("#emailAuthSection").hide();
        $("#emailAuthBtn").prop("disabled", true).html("✅ VERIFIED");
        this.showNotification("🎉 Email verified successfully!", "success");
        this.updateStepProgress();
      } else {
        this.showNotification("❌ Invalid verification code", "error");
      }
    } catch (error) {
      this.showNotification("🔥 Verification failed", "error");
    } finally {
      $btn
        .prop("disabled", false)
        .html('<span>VERIFY</span><i class="fas fa-check"></i>');
      this.updateSubmitButton();
    }
  }

  startEmailTimer(duration) {
    this.clearEmailTimer();
    let timeLeft = duration;

    this.timerInterval = setInterval(() => {
      const minutes = Math.floor(timeLeft / 60);
      const seconds = timeLeft % 60;
      const display = `${minutes.toString().padStart(2, "0")}:${seconds
        .toString()
        .padStart(2, "0")}`;

      $("#timer").text(display);

      if (--timeLeft < 0) {
        this.clearEmailTimer();
        $("#timer").text("⏰ TIME OUT");
        $("#emailAuthSection").hide();
      }
    }, 1000);
  }

  clearEmailTimer() {
    if (this.timerInterval) {
      clearInterval(this.timerInterval);
      this.timerInterval = null;
    }
  }

  updatePhoneNumber() {
    const phone0 = $("#phoneNum0").val();
    const phone1 = $("#phoneNum1").val();
    const phone2 = $("#phoneNum2").val();
    const fullPhone = phone0 + phone1 + phone2;

    $("#phoneNum").val(fullPhone);
  }

  searchZipcode() {
    new daum.Postcode({
      oncomplete: (data) => {
        $("#zipCode").val(data.zonecode);
        $("#address").val(data.address);
        $("#detailAddress").focus();

        const fullAddress = data.address + " " + $("#detailAddress").val();
        $("#fullAddress").val(fullAddress);

        this.showNotification("📍 Location coordinates acquired!", "success");
      },
    }).open();
  }

  handleFileUpload(e) {
    const file = e.target.files[0];

    if (!file) {
      $("#imagePreview").hide();
      this.validationState.isValidPhoto = false;
      return;
    }

    // 파일 유효성 검사
    const allowedTypes = ["image/jpeg", "image/jpg", "image/png"];
    if (!allowedTypes.includes(file.type)) {
      this.showNotification("❌ Only JPEG and PNG files allowed", "error");
      return;
    }

    if (file.size > 10 * 1024 * 1024) {
      this.showNotification("❌ File size must be under 10MB", "error");
      return;
    }

    // 이미지 미리보기
    const reader = new FileReader();
    reader.onload = (e) => {
      $("#photoPreview").attr("src", e.target.result);
      $("#imagePreview").show();
      this.validationState.isValidPhoto = true;
      this.updateSubmitButton();
      this.showNotification("🖼️ Avatar uploaded successfully!", "success");
    };
    reader.readAsDataURL(file);
  }

  updateStepProgress() {
    // 완료된 단계 수 계산
    const completed = Object.values(this.validationState).filter(
      Boolean
    ).length;
    this.currentStep = Math.min(completed + 1, this.totalSteps);
    this.updateProgress();

    // 체크 아이템 업데이트
    if (this.validationState.isIdChecked) {
      $("#checkId").addClass("completed");
    }
    if (
      this.validationState.isPasswordValid &&
      this.validationState.isPasswordConfirmed
    ) {
      $("#checkPassword").addClass("completed");
    }
    if (this.validationState.emailVerified) {
      $("#checkEmail").addClass("completed");
    }
    if (this.validationState.isValidPhoto) {
      $("#checkProfile").addClass("completed");
    }
  }

  updateSubmitButton() {
    const $submitBtn = $("#submitBtn");
    const allValid = Object.values(this.validationState).every(Boolean);

    $submitBtn.prop("disabled", !allValid);

    if (allValid) {
      $submitBtn.removeClass("disabled").addClass("ready");
      this.currentStep = this.totalSteps;
      this.updateProgress();
    }
  }

  handleSubmit(e) {
    // 최종 검증
    if (!Object.values(this.validationState).every(Boolean)) {
      e.preventDefault();
      this.showNotification(
        "🚫 Please complete all verification steps!",
        "error"
      );
      return false;
    }

    // 주소 통합
    const baseAddress = $("#address").val();
    const detailAddress = $("#detailAddress").val();
    $("#fullAddress").val(`${baseAddress} ${detailAddress}`);

    this.showNotification("🚀 Launching your account...", "success");
    return true;
  }

  showValidationMessage($element, message, type) {
    $element
      .removeClass("show success error info")
      .addClass(`${type} show`)
      .text(message);
  }

  showNotification(message, type) {
    // 임시 알림 표시 (실제로는 토스트 알림 구현)
    const $notification = $(`
            <div class="postmodern-notification ${type}">
                ${message}
            </div>
        `).appendTo("body");

    setTimeout(() => {
      $notification.fadeOut(() => $notification.remove());
    }, 3000);
  }
}

// DOM 로드 완료 시 초기화
$(document).ready(() => {
  new PostmodernSignup();

  // 추가 애니메이션 효과
  $(".postmodern-input")
    .focus(function () {
      $(this).closest(".form-group").addClass("focused");
    })
    .blur(function () {
      $(this).closest(".form-group").removeClass("focused");
    });
});

// 페이지 언로드 시 정리
$(window).on("beforeunload", () => {
  if (window.signupInstance && window.signupInstance.timerInterval) {
    clearInterval(window.signupInstance.timerInterval);
  }
});
