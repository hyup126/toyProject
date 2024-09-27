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
            background-color: #ffffff;
        }
        /* Border 크기 조정 및 중앙 정렬 */
        div#border {
            width: 1250px; /* 너비를 1250px로 설정 */
            margin: 0 auto; /* 중앙 정렬 */
            padding: 20px;
        }
        /* 리스트 테이블 */
        .listTable {
            border-top: #1A90D8 2px solid;
            border-bottom: #BABABA 1px solid;
            border-collapse: collapse;
            width: 100%;
        }
        .listTable th {
            border-bottom: #A3A3A3 1px solid;
            padding: 2px;
            background-color: #E4EAF8;
            height: 20px;
            text-align: center;
        }
        .listTable td {
            border-bottom: #E0E0E0 1px solid;
            padding: 2px;
            background-color: #F7F7F7;
            height: 20px;
        }
        /* 스타일 클래스 */
        .listCenter {
            font-size: 9pt;
            color: #000000;
            font-family: "돋움, Arial";
            text-align: center;
            vertical-align: middle;
        }
        .listRight {
            font-size: 9pt;
            color: #000000;
            font-family: "돋움, Arial";
            text-align: right;
            vertical-align: middle;
        }
        
        /* 페이징 스타일 */
        .pagination {
            text-align: center;
            margin: 20px 0;
        }
        .pagination a, .pagination span {
            display: inline-block;
            padding: 8px 16px;
            margin: 0 2px;
            border: 1px solid #ddd;
            border-radius: 4px;
            color: #333;
            text-decoration: none;
            font-size: 14px;
            background-color: #f9f9f9;
        }
        .pagination a:hover {
            background-color: #ddd;
        }
        .pagination .active {
            background-color: #1A90D8;
            color: white;
            border: 1px solid #1A90D8;
        }
        .pagination .disabled {
            color: #ccc;
            border: 1px solid #ccc;
            cursor: not-allowed;
        }
        
        /* 검색창 전체 스타일 */
        #search {
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        /* 검색 조건 드롭다운 스타일 */
        #search select {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-right: 10px;
            background-color: #ffffff;
            cursor: pointer;
            width: 150px; /* 드롭다운 너비 조정 */
        }

        /* 검색어 입력창 스타일 */
        #search input[type="text"] {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-right: 10px;
            width: 200px; /* 입력창 너비 조정 */
            box-sizing: border-box; /* 패딩 및 보더 포함 너비 계산 */
        }

        /* 검색 버튼 스타일 */
        .btn_blue_l a {
            display: inline-block;
            padding: 8px 16px;
            font-size: 14px;
            color: #fff;
            background-color: #1A90D8;
            border-radius: 4px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        /* 검색 버튼 호버 스타일 */
        .btn_blue_l a:hover {
            background-color: #1374c3;
        }

        /* 로그아웃 버튼 스타일 */
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
            background-color: #d9534f; /* 로그아웃 버튼 색상 */
            border-radius: 4px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        #logoutButton a:hover {
            background-color: #c9302c; /* 로그아웃 버튼 호버 색상 */
        }
</style>
</head>
<body>
    <div id="border">
        <h1>게시물 작성</h1>

        <form id="memBoardForm" method="post" action="/board/memBoardSave.do" enctype="multipart/form-data">
            <sec:csrfInput />
            <div class="form-group">
                <label for="memBoardTitle">제목</label>
                <input type="text" id="memBoardTitle" name="memBoardTitle">
            </div>
            <div class="form-group">
                <label for="memBoardWriter">작성자</label>
                <input type="text" id="memBoardWriter" name="memBoardWriter" value="${memVO.memId }" readonly="readonly">
            </div>
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="memBoardContent" name="memBoardContent" rows="20" cols="100"></textarea>
            </div>
            <div class="form-group">
                <label for="memBoardFile">파일 업로드</label>
                <input type="file" id="memBoardFile" name="memBoardFile" multiple>
            </div>
            <button id="submitBtn" type="button" class="btn btn-primary" style="float:right;">작성하기</button>
        </form>

        <div id="logoutButton">
            <a href="logout.jsp">로그아웃</a>
        </div>
    </div>

    <script>
        $(document).ready(function() {
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