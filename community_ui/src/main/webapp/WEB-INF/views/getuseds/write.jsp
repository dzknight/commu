<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 작성/수정</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" defer></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', Arial, sans-serif;
            background-color: #f8f9fa;
            color: #343a40;
            line-height: 1.6;
        }

        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        /* 게시글 작성/수정 페이지 스타일 - 크기 확장 */
        .write-form-container {
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 900px; /* 기존 700px에서 900px로 확장 */
            margin: 40px auto;
        }

        .write-form-container h2 {
            text-align: center;
            color: #343a40;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 700;
            position: relative;
        }

        .write-form-container h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(135deg, #007bff, #0056b3);
            border-radius: 2px;
        }

        /* 테이블 스타일 개선 */
        .write-form-container table {
            width: 100%;
            border-collapse: collapse;
        }

        .write-form-container td {
            padding: 15px 0; /* 각 입력 필드 간 여백 추가 */
            vertical-align: top;
        }

        .form-label {
            display: block;
            margin-bottom: 12px; /* 기존 8px에서 12px로 확장 */
            font-weight: 600;
            color: #495057;
            font-size: 16px; /* 기존 14px에서 16px로 확장 */
        }

        .form-label.required::after {
            content: ' *';
            color: #dc3545;
            font-weight: bold;
        }

        /* 언어 선택 드롭다운 크기 대폭 확장 */
        .language-select {
            width: 100%;
            padding: 15px 20px; /* 기존 12px 16px에서 확장 */
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 16px; /* 기존 15px에서 16px로 확장 */
            font-family: inherit;
            background-color: #fff;
            color: #495057;
            transition: all 0.3s ease;
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill="%23495057" d="M8 11L3 6h10l-5 5z"/></svg>');
            background-repeat: no-repeat;
            background-position: right 15px center; /* 기존 12px에서 15px로 조정 */
            background-size: 18px; /* 기존 16px에서 18px로 확장 */
            cursor: pointer;
            min-height: 55px; /* 최소 높이 설정으로 더 큰 드롭다운 */
        }

        .language-select:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
        }

        .language-select option {
            padding: 12px; /* 기존 10px에서 12px로 확장 */
            font-size: 15px; /* 기존 14px에서 15px로 확장 */
        }

        /* 입력 필드 크기 대폭 확장 */
        .write-form-container input[type="text"],
        .write-form-container textarea {
            width: 100%;
            padding: 15px 20px; /* 기존 12px 16px에서 확장 */
            border: 2px solid #e9ecef;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 16px; /* 기존 15px에서 16px로 확장 */
            font-family: inherit;
            transition: all 0.3s ease;
            background-color: #fff;
        }

        /* 제목 입력 필드 특별 스타일 */
        .write-form-container input[type="text"] {
            min-height: 55px; /* 제목 입력칸 높이 설정 */
        }

        .write-form-container input[type="text"]:focus,
        .write-form-container textarea:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
        }

        /* 텍스트 영역 크기 대폭 확장 */
        .write-form-container textarea {
            resize: vertical;
            min-height: 320px; /* 기존 200px에서 320px로 대폭 확장 */
            line-height: 1.8; /* 기존 1.6에서 1.8로 확장 */
        }

        /* 파일 업로드 스타일 개선 */
        .write-form-container input[type="file"] {
            width: 100%;
            padding: 15px 20px; /* 패딩 확장 */
            border: 2px dashed #e9ecef;
            border-radius: 8px;
            background-color: #f8f9fa;
            cursor: pointer;
            font-size: 15px; /* 폰트 크기 확장 */
            transition: all 0.3s ease;
            min-height: 50px; /* 최소 높이 설정 */
        }

        .write-form-container input[type="file"]:hover {
            border-color: #007bff;
            background-color: #e3f2fd;
        }

        .btn-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            color: #fff;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            min-width: 120px;
            justify-content: center;
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #218838, #1ea085);
            transform: translateY(-2px);
        }

        .btn-warning {
            background: linear-gradient(135deg, #ffc107, #fd7e14);
        }

        .btn-warning:hover {
            background: linear-gradient(135deg, #e0a800, #e8590c);
            transform: translateY(-2px);
        }

        /* 푸터 스타일 */
        .footer {
            background-color: #343a40;
            color: #fff;
            padding: 20px 0;
            text-align: center;
            margin-top: 40px;
            width: 100%;
        }
        .footer-links a {
            color: #adb5bd;
            margin: 0 12px;
            text-decoration: none;
            font-size: 14px;
        }
        .footer-links a:hover {
            color: #fff;
        }
        .footer p {
            font-size: 13px;
            margin-top: 8px;
            color: #adb5bd;
        }

        /* 반응형 디자인 개선 */
        @media (max-width: 900px) {
            .container {
                flex-direction: column;
            }
            .write-form-container {
                padding: 25px 20px; /* 모바일에서 패딩 조정 */
                margin: 20px auto;
                max-width: 100%;
            }
            .write-form-container h2 {
                font-size: 24px;
            }
            .btn-container {
                flex-direction: column;
                align-items: center;
            }
            .btn {
                width: 100%;
                max-width: 200px;
            }

            /* 모바일에서 입력 필드 패딩 조정 */
            .language-select,
            .write-form-container input[type="text"],
            .write-form-container textarea,
            .write-form-container input[type="file"] {
                padding: 12px 15px;
                font-size: 15px;
            }

            .language-select {
                min-height: 50px;
            }

            .write-form-container input[type="text"] {
                min-height: 50px;
            }

            .write-form-container textarea {
                min-height: 280px;
            }
        }

        @media (max-width: 600px) {
            .write-form-container {
                padding: 20px 15px;
            }

            .language-select,
            .write-form-container input[type="text"],
            .write-form-container textarea,
            .write-form-container input[type="file"] {
                padding: 10px 12px;
                font-size: 14px;
            }

            .language-select {
                min-height: 45px;
            }

            .write-form-container input[type="text"] {
                min-height: 45px;
            }

            .write-form-container textarea {
                min-height: 250px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <%@ include file="../common/top.jsp"%>
    <div class="write-form-container">
        <h2>
            <c:choose>
                <c:when test="${not empty boardVO}">
                    <i class="fas fa-edit"></i> 게시글 수정
                </c:when>
                <c:otherwise>
                    <i class="fas fa-pen"></i> 질문 게시글 작성
                </c:otherwise>
            </c:choose>
        </h2>

        <form action="${pageContext.request.contextPath}${not empty boardVO ? '/modify' : '/insertContent'}"
              method="post"
              id="frm"
              enctype="multipart/form-data">

            <c:if test="${not empty boardVO}">
                <input type="hidden" name="postNum" value="${boardVO.postNum}" />
            </c:if>

            <table>
                <tr>
                    <td>
                        <label for="programmingLanguage" class="form-label required">
                            <i class="fas fa-code"></i> 프로그래밍 언어
                        </label>

                        <select id="programmingLanguage" name="programmingLanguage" class="language-select" required>
                            <option value="">질문할 원하는 기술스택을 선택하세요</option>

                            <optgroup label="프로그래밍 언어">
                                <option value="Python" ${boardVO.programmingLanguage == 'Python' ? 'selected' : ''}>Python</option>
                                <option value="JavaScript" ${boardVO.programmingLanguage == 'JavaScript' ? 'selected' : ''}>JavaScript</option>
                                <option value="Java" ${boardVO.programmingLanguage == 'Java' ? 'selected' : ''}>Java</option>
                                <option value="C++" ${boardVO.programmingLanguage == 'C++' ? 'selected' : ''}>C++</option>
                                <option value="C" ${boardVO.programmingLanguage == 'C' ? 'selected' : ''}>C</option>
                                <option value="C#" ${boardVO.programmingLanguage == 'C#' ? 'selected' : ''}>C#</option>
                                <option value="TypeScript" ${boardVO.programmingLanguage == 'TypeScript' ? 'selected' : ''}>TypeScript</option>
                                <option value="Go" ${boardVO.programmingLanguage == 'Go' ? 'selected' : ''}>Go</option>
                                <option value="Rust" ${boardVO.programmingLanguage == 'Rust' ? 'selected' : ''}>Rust</option>
                                <option value="Swift" ${boardVO.programmingLanguage == 'Swift' ? 'selected' : ''}>Swift</option>
                                <option value="Kotlin" ${boardVO.programmingLanguage == 'Kotlin' ? 'selected' : ''}>Kotlin</option>
                                <option value="PHP" ${boardVO.programmingLanguage == 'PHP' ? 'selected' : ''}>PHP</option>
                                <option value="Ruby" ${boardVO.programmingLanguage == 'Ruby' ? 'selected' : ''}>Ruby</option>
                                <option value="Dart" ${boardVO.programmingLanguage == 'Dart' ? 'selected' : ''}>Dart</option>
                                <option value="R" ${boardVO.programmingLanguage == 'R' ? 'selected' : ''}>R</option>
                                <option value="Julia" ${boardVO.programmingLanguage == 'Julia' ? 'selected' : ''}>Julia</option>
                                <option value="Mojo" ${boardVO.programmingLanguage == 'Mojo' ? 'selected' : ''}>Mojo</option>
                                <option value="Zig" ${boardVO.programmingLanguage == 'Zig' ? 'selected' : ''}>Zig</option>
                            </optgroup>

                            <optgroup label="프레임워크">
                                <option value="React" ${boardVO.programmingLanguage == 'React' ? 'selected' : ''}>React</option>
                                <option value="Vue.js" ${boardVO.programmingLanguage == 'Vue.js' ? 'selected' : ''}>Vue.js</option>
                                <option value="Angular" ${boardVO.programmingLanguage == 'Angular' ? 'selected' : ''}>Angular</option>
                                <option value="Svelte" ${boardVO.programmingLanguage == 'Svelte' ? 'selected' : ''}>Svelte</option>
                                <option value="Next.js" ${boardVO.programmingLanguage == 'Next.js' ? 'selected' : ''}>Next.js</option>
                                <option value="Nuxt.js" ${boardVO.programmingLanguage == 'Nuxt.js' ? 'selected' : ''}>Nuxt.js</option>
                                <option value="Node.js" ${boardVO.programmingLanguage == 'Node.js' ? 'selected' : ''}>Node.js</option>
                                <option value="Express.js" ${boardVO.programmingLanguage == 'Express.js' ? 'selected' : ''}>Express.js</option>
                                <option value="Nest.js" ${boardVO.programmingLanguage == 'Nest.js' ? 'selected' : ''}>Nest.js</option>
                                <option value="SpringBoot" ${boardVO.programmingLanguage == 'SpringBoot' ? 'selected' : ''}>SpringBoot</option>
                                <option value="Django" ${boardVO.programmingLanguage == 'Django' ? 'selected' : ''}>Django</option>
                                <option value="Flask" ${boardVO.programmingLanguage == 'Flask' ? 'selected' : ''}>Flask</option>
                                <option value="FastAPI" ${boardVO.programmingLanguage == 'FastAPI' ? 'selected' : ''}>FastAPI</option>
                                <option value="Deno" ${boardVO.programmingLanguage == 'Deno' ? 'selected' : ''}>Deno</option>
                                <option value="Bun" ${boardVO.programmingLanguage == 'Bun' ? 'selected' : ''}>Bun</option>
                            </optgroup>


                            <optgroup label="앱 개발">
                                <option value="Flutter" ${boardVO.programmingLanguage == 'Flutter' ? 'selected' : ''}>Flutter</option>
                                <option value="ReactNative" ${boardVO.programmingLanguage == 'ReactNative' ? 'selected' : ''}>React Native</option>
                            </optgroup>

                            <optgroup label="게임 개발">
                                <option value="Unity" ${boardVO.programmingLanguage == 'Unity' ? 'selected' : ''}>Unity</option>
                                <option value="UnrealEngine" ${boardVO.programmingLanguage == 'UnrealEngine' ? 'selected' : ''}>Unreal Engine</option>
                            </optgroup>

                            <optgroup label="클라우드">
                                <option value="AWS" ${boardVO.programmingLanguage == 'AWS' ? 'selected' : ''}>AWS</option>
                                <option value="Azure" ${boardVO.programmingLanguage == 'Azure' ? 'selected' : ''}>Azure</option>
                                <option value="GCP" ${boardVO.programmingLanguage == 'GCP' ? 'selected' : ''}>Google Cloud Platform</option>
                            </optgroup>

                            <optgroup label = "Devops">
                                <option value="Docker" ${boardVO.programmingLanguage == 'Docker' ? 'selected' : ''}>Docker</option>
                                <option value="Kubernetes" ${boardVO.programmingLanguage == 'Kubernetes' ? 'selected' : ''}>Kubernetes</option>
                            </optgroup>

                            <optgroup label="SQL">
                                <option value="MySQL" ${boardVO.programmingLanguage == 'MySQL' ? 'selected' : ''}>MySQL</option>
                                <option value="PostgreSQL" ${boardVO.programmingLanguage == 'PostgreSQL' ? 'selected' : ''}>PostgreSQL</option>
                                <option value="MongoDB" ${boardVO.programmingLanguage == 'MongoDB' ? 'selected' : ''}>MongoDB</option>
                                <option value="Oracle" ${boardVO.programmingLanguage == 'Oracle' ? 'selected' : ''}>Oracle</option>
                                <option value="SQLServer" ${boardVO.programmingLanguage == 'SQLServer' ? 'selected' : ''}>SQL Server</option>
                                <option value="SQLite" ${boardVO.programmingLanguage == 'SQLite' ? 'selected' : ''}>SQLite</option>
                                <option value="MariaDB" ${boardVO.programmingLanguage == 'MariaDB' ? 'selected' : ''}>MariaDB</option>
                            </optgroup>

                            <optgroup label="AI">
                                <option value="GPT" ${boardVO.programmingLanguage == 'GPT' ? 'selected' : ''}>GPT</option>
                                <option value="BERT" ${boardVO.programmingLanguage == 'BERT' ? 'selected' : ''}>BERT</option>
                                <option value="YOLO" ${boardVO.programmingLanguage == 'YOLO' ? 'selected' : ''}>YOLO</option>
                                <option value="OpenCV" ${boardVO.programmingLanguage == 'OpenCV' ? 'selected' : ''}>OpenCV</option>
                            </optgroup>

                            <optgroup label="머신러닝/딥러닝">
                                <option value="ScikitLearn" ${boardVO.programmingLanguage == 'ScikitLearn' ? 'selected' : ''}>Scikit-learn</option>
                                <option value="XGBoost" ${boardVO.programmingLanguage == 'XGBoost' ? 'selected' : ''}>XGBoost</option>
                                <option value="LightGBM" ${boardVO.programmingLanguage == 'LightGBM' ? 'selected' : ''}>LightGBM</option>
                                <option value="TensorFlow" ${boardVO.programmingLanguage == 'TensorFlow' ? 'selected' : ''}>TensorFlow</option>
                                <option value="PyTorch" ${boardVO.programmingLanguage == 'PyTorch' ? 'selected' : ''}>PyTorch</option>
                                <option value="Keras" ${boardVO.programmingLanguage == 'Keras' ? 'selected' : ''}>Keras</option>
                            </optgroup>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td>
                        <label for="title" class="form-label required">
                            <i class="fas fa-heading"></i> 제목
                        </label>
                        <input type="text" id="title" name="title" placeholder= "제목을 입력하세요"
                               value="${boardVO.title != null ? boardVO.title : ''}"
                               onfocus="this.placeholder=''" onblur="this.placeholder='제목을 입력하세요'" required>
                    </td>
                </tr>

                <tr>
                    <td>
                        <label for="content" class="form-label required">
                            <i class="fas fa-align-left"></i> 질문 내용
                        </label>
                        <textarea id="content" name="content" placeholder="질문 내용을 자세히 입력해주세요"
                                  onfocus="this.placeholder=''" onblur="this.placeholder='질문 내용을 자세히 입력해주세요'" required
                                  rows="12">${boardVO.content != null ? boardVO.content : ''}</textarea>
                    </td>
                </tr>

                <tr>
                    <td>
                        <input type="file" name="file">
                        <c:if test="${not empty boardVO.filename}">
                            <p>현재 업로드된 파일: ${boardVO.filename}</p>
                        </c:if>
                    </td>
                </tr>
            </table>
            <div class="btn-container">
                <button type="submit" class="btn btn-success">등록</button>
                <button type="reset" class="btn btn-warning">취소</button>
            </div>
        </form>

    </div>

    <footer class="footer">
        <div class="footer-links">
            <a href="#">이용약관</a> | <a href="#">개인정보처리방침</a> | <a href="#">고객센터</a>
        </div>
        <p>© 2025 커뮤니티. All rights reserved.</p>
    </footer>

    <script>
        // 폼 제출 전 유효성 검사
        document.getElementById('frm').addEventListener('submit', function(e) {
            const language = document.getElementById('programmingLanguage').value;
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();

            if (!language) {
                alert('프로그래밍 언어를 선택해주세요.');
                // 프로그래밍 언어 미선택시 폼 제출 방지
                e.preventDefault();
                return false;
            }

            if (!title) {
                alert('제목을 입력해주세요.');
                // 제목 미입력시 폼 제출 방지
                e.preventDefault();
                return false;
            }

            if (!content) {
                alert('질문 내용을 입력해주세요.');
                // 질문 내용 미입력시 폼 제출 방지
                e.preventDefault();
                return false;
            }

            if (title.length < 5) {
                alert('제목은 5자 이상 입력해주세요.');
                e.preventDefault();
                return false;
            }

            if (content.length < 10) {
                alert('질문 내용은 10자 이상 입력해주세요.');
                e.preventDefault();
                return false;
            }
        });
    </script>
</body>
</html>