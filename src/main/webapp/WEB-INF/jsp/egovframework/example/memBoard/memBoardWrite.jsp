<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>게시물 작성</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <style>
        body {
            background-color: #f8f9fa;
            font-family: "Arial", sans-serif;
        }
        #border {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
        }
        textarea {
            width: 100%;
            height: 150px;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            resize: none;
        }
        input[type="text"], input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }
        img {
            display: block;
            margin: 10px auto;
            max-width: 170px;
            max-height: 100px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        #submitBtn {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #1A90D8;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        #submitBtn:hover {
            background-color: #1374c3;
        }
        #plusBtn {
        	display: block;
            margin: 20px auto;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #1A90D8;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        #plusBtn:hover {
            background-color: #1374c3;
        }
        #logoutButton {
            position: absolute;
            top: 20px;
            right: 20px;
        }
        #logoutButton a {
            display: inline-block;
            padding: 8px 16px;
            font-size: 14px;
            color: #fff;
            background-color: #d9534f;
            border-radius: 4px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        #logoutButton a:hover {
            background-color: #c9302c;
        }
        .preview {
            margin-bottom: 10px;
        }
        .btn_red_l {
    display: inline-block; /* 블록으로 만들어 간격 조정 가능 */
    padding: 10px 20px; /* 패딩 */
    font-size: 16px; /* 글자 크기 */
    color: #fff; /* 텍스트 색상 */
    background-color: #dc3545; /* 빨간색 배경 */
    border: none; /* 테두리 제거 */
    border-radius: 4px; /* 테두리 둥글게 */
    text-decoration: none; /* 기본 밑줄 제거 */
    transition: background-color 0.3s; /* 효과 전환 */
	}
	
	.btn_red_l:hover {
	    background-color: #c82333; /* 호버 시 배경 색상 변화 */
	}
	
	.btn_red_l:focus {
	    outline: none; /* 포커스 시 외곽선 제거 */
	}
    </style>
</head>
<body>
    <div id="border">
        <h1>게시물 작성</h1>
        <form id="memBoardForm" method="post" action="/board/memBoardSave.do" enctype="multipart/form-data">
            <sec:csrfInput/>
            <input type="hidden" name="memBoardNo" value="${memBoard.memBoardNo}" />
            <input type="hidden" name="searchCondition" value="${searchCondition }"/>
            <input type="hidden" name="searchKeyword" value="${searchKeyword }"/>
            <div class="form-group">
                <label for="memBoardTitle">제목</label>
                <input type="text" id="memBoardTitle" name="memBoardTitle">
            </div>
            <div class="form-group">
                <label for="memBoardWriter">작성자</label>
                <input type="text" id="memBoardWriter" name="memBoardWriter" value="${memVO.memId }" readonly>
            </div>
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="memBoardContent" name="memBoardContent"></textarea>
            </div>
            <div id="fileUploadContainer">
                <div class="form-group" id="fileGroup1">
                    <img src="" id="preview1" class="preview" alt=""/><br>
                    <label for="memBoardFile1">파일 업로드</label>
                    <input type="file" class="files" name="memBoardFile" id="memBoardFile1" onchange="previewImage(this)">
                </div>
            </div>
            <button id="plusBtn" type="button">파일 추가</button>
            <button id="submitBtn" type="button">작성하기</button>
            <a href="/board/memBoardList.do?searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" class="btn_red_l">취소</a>
        </form>
        <div id="logoutButton">
            <a href="logout.jsp">로그아웃</a>
        </div>
    </div>

    <script>
        $(document).ready(function() {
        	
        	console.log("searchKeyword : " + "${searchKeyword}");
        	console.log("searchCondition : " + "${searchCondition}");
        	/* $('input[name="memBoardFile"]').each(function(index) {
                $(this).change(function(){
                    setImageFromFile(this, '#preview' + (index + 1)); // 인덱스를 사용하여 고유 ID 설정
                });
            });
        	
        	function setImageFromFile(input, expression) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(expression).attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            } */
        	
        	let fileCount = 1; // 현재 파일 입력 수

            // 파일 추가 버튼 클릭 이벤트
            $("#plusBtn").click(function() {
                if (fileCount < 5) {
                    fileCount++;
                    const newFileGroup = `
                        <div class="form-group" id="fileGroup${fileCount}">
                            <label for="memBoardFile${fileCount}">파일 업로드</label>
                            <input type="file" class="files" name="memBoardFile" id="memBoardFile${fileCount}" onchange="previewImage(this)">
                        </div>
                    `;
                    $('#fileUploadContainer').append(newFileGroup);

                    // 파일 개수가 5개가 되면 버튼 숨기기
                    if (fileCount === 5) {
                        $('#plusBtn').hide();
                    }
                }
            });
        	
         // 파일 미리보기 함수
         window.previewImage = function(input) {
               const index = input.id.replace('memBoardFile', ''); // ID에서 숫자 추출
               const preview = document.getElementById(`preview1`);
               if (input.files && input.files[0]) {
                   const file = input.files[0];

                   // 이미지 파일인지 체크
                   if (!isImageFile(file)) {
                       alert("등록된 확장자 파일만 업로드할 수 있습니다. (jpg, jpeg, gif, png, txt, pdf, hwp, xlsx)");
                       input.value = ""; // 잘못된 파일 선택 시 input 초기화
                       preview.src = ""; // 미리보기 초기화
                       return; // 함수 종료
                   }

                   const reader = new FileReader();
                   reader.onload = function(e) {
                       preview.src = e.target.result; // 미리보기 이미지 설정
                   }
                   reader.readAsDataURL(file);
               } else {
                   preview.src = ""; // 파일이 없을 경우 미리보기 초기화
               }
			}
         
         	// 등록된 확장자 파일인지 체크
            function isImageFile(file) {
            	var ext = file.name.split(".").pop().toLowerCase();		// 파일명에서 확장자를 가져옵니다.
            	return ($.inArray(ext, ["jpg", "jpeg", "gif", "png", "txt", "pdf", "hwp", "xlsx"]) === -1) ? false : true;
            }
        	
            $('#submitBtn').click(function() {
                var formData = new FormData($('#memBoardForm')[0]);
                $.ajax({
                    url: '/board/memBoardSave.do',
                    type: 'POST',
                    data: formData,
                    processData: false, 
                    contentType: false, 
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content') 
                    },
                    success: function(data) {
                        alert('등록 완료: ' + data.message);
                        window.location.href = '/board/memBoardList.do';
                    },
                    error: function(xhr, status, error) {
                        alert('오류 발생: ' + xhr.statusText);
                    }
                });

                // 추가적인 스크립트
                var writer = $("#memBoardWriter").val();
                console.log(writer);
            });
        });
    </script>
</body>
</html>