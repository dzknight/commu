<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>Insert title here</title>
</head>
<style>
        body {
            background-color: #f9f9f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .write-form-container {
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 25px;
            font-size: 24px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        td {
            padding: 12px 0;
        }

        input[type="text"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 14px;
            font-family: inherit;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        textarea:focus,
        select:focus {
            border-color: #007bff;
            outline: none;
        }

        textarea {
            resize: vertical;
            min-height: 150px;
        }

        select {
            appearance: none;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12"><path fill="%23333" d="M6 9l-4-4h8z"/></svg>') no-repeat right 10px center;
            background-size: 12px;
            padding-right: 30px;
        }

        input[type="file"] {
            display: block;
            margin-bottom: 12px;
            font-size: 14px;
        }

        button {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        button[type="submit"] {
            background-color: #007bff; /* 파랑 */
            color: #fff;
        }

        button[type="submit"]:hover {
            background-color: #0056b3; /* 더 어두운 파랑 */
        }

        button[type="reset"] {
            background-color: #6c757d; /* 회색 */
            color: #fff;
        }

        button[type="reset"]:hover {
            background-color: #5a6268; /* 더 어두운 회색 */
        }

        @media (max-width: 600px) {
            .write-form-container {
                padding: 20px;
                margin: 10px;
            }

            h2 {
                font-size: 20px;
            }

            input[type="text"],
            input[type="number"],
            textarea,
            select,
            button {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <div class="write-form-container">
        <h2>게시글 작성</h2>
        <form action = "${pageContext.request.contextPath}/insertContent" method = "post" id="frm" enctype="multipart/form-data">
            <table>
                <tr>
                    <td>
                        <input type="text" id="title" name="title" placeholder="제목을 입력하세요"
                               onfocus="this.placeholder=''" onblur="this.placeholder='제목을 입력하세요'">
                    </td>
                </tr>
                <tr>
                    <td>
                        <textarea id="content" name="content" placeholder="내용을 입력하세요"
                                  onfocus="this.placeholder=''" onblur="this.placeholder='내용을 입력하세요'"
                                  rows="10" cols="50"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="text" id="price" name="price" placeholder="가격을 입력하세요"
                               onfocus="this.placeholder=''" onblur="this.placeholder='가격을 입력하세요'">
                    </td>
                </tr>
                <tr>
                    <td>
                        <select name="saleStatus">
                        	<option selected>유형을 선택하세요</option>
                            <option value="판매중">판매중</option>
                            <option value="판매완료">판매완료</option>
                            <option value="예약중">예약중</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><input type="file" name="file"></td> 
                </tr>
                <tr>
                	
        
        			<td><input type = "file" name = "file"></td>
                	
                </tr>	
                <tr>
                    <td style="text-align: right;">
                        <button type="submit" class="btn btn-success btn-sm">등록</button>
                        <button type="reset" class="btn btn-warning btn-sm">취소</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>