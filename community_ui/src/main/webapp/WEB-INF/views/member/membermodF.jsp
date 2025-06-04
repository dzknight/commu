<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="ko_KR" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보 수정</title>
    <style>
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
        }
        .profile-container {
            text-align: center;
            margin: 20px 0;
        }
        .profile-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #ddd;
        }
        .profile-upload {
            margin-top: 10px;
        }
        .form-group {
            margin-bottom: 15px;
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        .form-label {
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
            display: block;
        }
        .form-control {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .form-control:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
        }
        .form-control[readonly] {
            background-color: #f8f9fa;
            color: #6c757d;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 5px;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn:hover {
            opacity: 0.9;
        }
        .address-group {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        .address-group input[type="text"] {
            flex: 1;
        }
        .btn-small {
            padding: 8px 16px;
            font-size: 12px;
        }
        .error-message {
            color: #dc3545;
            font-size: 12px;
            margin-top: 5px;
        }
        .phone-group {
            display: flex;
            gap: 5px;
            align-items: center;
        }
        .phone-group input {
            flex: 1;
            text-align: center;
        }
        .phone-separator {
            font-weight: bold;
        }
    </style>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
    <div class="container">
        <h2>회원 정보 수정</h2>
        
        <form action="${pageContext.request.contextPath}/member/membermodF" method="post" enctype="multipart/form-data" id="memberForm">
            <!-- 프로필 사진 영역 -->
            <div class="profile-container">
                <c:choose>
                    <c:when test="${not empty member.profile_img && member.profile_img != 'default.jpg'}">
                        <img src="${pageContext.request.contextPath}/resources/uploads/${member.profile_img}" 
                             class="profile-image" alt="프로필 사진" id="profilePreview">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/resources/images/default.jpg" 
                             class="profile-image" alt="기본 프로필" id="profilePreview">
                    </c:otherwise>
                </c:choose>
                <div class="profile-upload">
                    <input type="file" name="profileImage" id="profileImage" accept="image/*" style="display: none;">
                    <button type="button" class="btn btn-secondary btn-small" onclick="document.getElementById('profileImage').click();">
                        프로필 사진 변경
                    </button>
                </div>
            </div>
            
            <div class="form-group">
                <label class="form-label">아이디</label>
                <input type="text" name="userId" value="${member.userId}" class="form-control" readonly>
            </div>
            
            <div class="form-group">
                <label class="form-label">이름</label>
                <input type="text" name="userName" id="userName" value="${member.userName}" class="form-control" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">이메일</label>
                <input type="email" name="userEmail" id="userEmail" value="${member.userEmail}" class="form-control" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">전화번호</label>
                <c:set var="phone" value="${member.userPhoneNum}" />
                <c:choose>
                    <c:when test="${fn:length(phone) eq 11}">
                        <div class="phone-group">
                            <input type="text" name="phone1" value="${fn:substring(phone, 0, 3)}" class="form-control" maxlength="3" required>
                            <span class="phone-separator">-</span>
                            <input type="text" name="phone2" value="${fn:substring(phone, 3, 7)}" class="form-control" maxlength="4" required>
                            <span class="phone-separator">-</span>
                            <input type="text" name="phone3" value="${fn:substring(phone, 7, 11)}" class="form-control" maxlength="4" required>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="phone-group">
                            <input type="text" name="phone1" class="form-control" maxlength="3" required>
                            <span class="phone-separator">-</span>
                            <input type="text" name="phone2" class="form-control" maxlength="4" required>
                            <span class="phone-separator">-</span>
                            <input type="text" name="phone3" class="form-control" maxlength="4" required>
                        </div>
                    </c:otherwise>
                </c:choose>
                
            </div>
            
            <div class="form-group">
                <label class="form-label">생년월일</label>
                <c:choose>
                    <c:when test="${not empty member.birthdate}">
                        <input type="date" name="birthdate" value="<fmt:formatDate value='${member.birthdate}' pattern='yyyy-MM-dd'/>" class="form-control">
                    </c:when>
                    <c:otherwise>
                        <input type="date" name="birthdate" class="form-control">
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div class="form-group">
                <label class="form-label">주소</label>
                <div class="address-group">
                    <input type="text" name="zipCode" value="${member.zipCode}" class="form-control" placeholder="우편번호" readonly>
                    <button type="button" class="btn btn-secondary btn-small" onclick="execDaumPostcode()">우편번호 찾기</button>
                </div>
                <input type="text" name="address" value="${member.address}" class="form-control" placeholder="기본주소" readonly style="margin-top: 10px;">
                <input type="text" name="detailAddress" value="${member.detailAddress}" class="form-control" placeholder="상세주소" style="margin-top: 10px;">
            </div>
            
            <div class="form-group">
                <label class="form-label">가입일</label>
                <input type="text" value="<fmt:formatDate value='${member.regDate}' pattern='yyyy-MM-dd'/>" class="form-control" readonly>
            </div>
            
            <div style="text-align: center; margin-top: 30px;">
                <button type="submit" class="btn btn-primary">수정 완료</button>
                <a href="${pageContext.request.contextPath}/member/passreset" class="btn btn-secondary">취소</a>
                
            </div>
        </form>
    </div>

    <script>
        // 프로필 이미지 미리보기
        document.getElementById('profileImage').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('profilePreview').src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });

        // 전화번호 숫자만 입력 허용
        document.querySelectorAll('input[name^="phone"]').forEach(function(input) {
            input.addEventListener('input', function(e) {
                this.value = this.value.replace(/[^0-9]/g, '');
            });
        });

        // 다음 우편번호 API
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var addr = '';
                    if (data.userSelectedType === 'R') {
                        addr = data.roadAddress;
                    } else {
                        addr = data.jibunAddress;
                    }
                    
                    document.querySelector('input[name="zipCode"]').value = data.zonecode;
                    document.querySelector('input[name="address"]').value = addr;
                    document.querySelector('input[name="detailAddress"]').focus();
                }
            }).open();
        }

        // 비밀번호 변경 페이지로 이동
        function changePassword() {
            location.href = '${pageContext.request.contextPath}/member/changePassword';
        }

        // 폼 제출 시 전화번호 합치기
        document.getElementById('memberForm').addEventListener('submit', function(e) {
            const phone1 = document.querySelector('input[name="phone1"]').value;
            const phone2 = document.querySelector('input[name="phone2"]').value;
            const phone3 = document.querySelector('input[name="phone3"]').value;
            
            if (phone1 && phone2 && phone3) {
                const fullPhone = phone1 + phone2 + phone3;
                
                // 숨겨진 input 생성하여 전체 전화번호 전송
                const hiddenInput = document.createElement('input');
                hiddenInput.type = 'hidden';
                hiddenInput.name = 'userPhoneNum';
                hiddenInput.id='phoneNum';
                hiddenInput.value = fullPhone;
                this.appendChild(hiddenInput);
            }
        });

        // 폼 유효성 검사
        document.getElementById('memberForm').addEventListener('submit', function(e) {
            const userName = document.querySelector('input[name="userName"]').value.trim();
            const userEmail = document.querySelector('input[name="userEmail"]').value.trim();
            const phone1 = document.querySelector('input[name="phone1"]').value;
            const phone2 = document.querySelector('input[name="phone2"]').value;
            const phone3 = document.querySelector('input[name="phone3"]').value;
            
            if (!userName) {
                alert('이름을 입력해주세요.');
                e.preventDefault();
                return;
            }
            
            if (!userEmail) {
                alert('이메일을 입력해주세요.');
                e.preventDefault();
                return;
            }
            
            if (!phone1 || !phone2 || !phone3) {
                alert('전화번호를 모두 입력해주세요.');
                e.preventDefault();
                return;
            }
            
            if (phone1.length !== 3 || phone2.length !== 4 || phone3.length !== 4) {
                alert('올바른 전화번호 형식으로 입력해주세요.');
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>