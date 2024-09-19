<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>게시글 수정</title>
    <link rel="stylesheet" type="text/css" href="/css/egovframework/boardList.css"> <!-- CSS 파일 링크 -->
    <script
    src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous">
    </script>
</head>
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
<body>
    <div id="border">
        <h1>게시글 수정</h1>

        <!-- 게시글 수정 폼 -->
        <form id="modifyForm" action="/board/memBoardUpdate.do" method="post" class="form-horizontal">
            <input type="hidden" name="memBoardNo" value="${memBoard.memBoardNo}" />
        	<sec:csrfInput/>
            <div class="form-group">
                <label for="memBoardTitle">제목:</label>
                <input type="text" id="memBoardTitle" name="memBoardTitle" class="form-control" value="${memBoard.memBoardTitle}" required />
            </div>
            <div class="form-group">
                <label for="memBoardWriter">작성자:</label>
                <input type="text" id="memBoardWriter" name="memBoardWriter" class="form-control" value="${memBoard.memBoardWriter}" required />
            </div>
            <div class="form-group">
                <label for="memBoardContent">내용:</label>
                <textarea id="memBoardContent" name="memBoardContent" class="form-control" rows="10" required>${memBoard.memBoardContent}</textarea>
            </div>
            <div class="form-group">
                <label for="regDate">등록일:</label>
                <input type="text" id="regDate" name="regDate" class="form-control" value="${memBoard.regDate}" readonly />
            </div>
            <div class="form-group">
                <button type="button" id="updateBtn" class="btn_blue_l">수정 완료</button>
                <a href="#" class="btn_blue_l">취소</a>
            </div>
        </form>
    </div>
</body>
<script type="text/javascript">
	$(function(){
		$("#updateBtn").click(function(){
			var modifyForm = $("#modifyForm");
			var memBoardTitle = $("#memBoardTitle").val();
			var memBoardContent = $("#memBoardContent").val();
			if(memBoardTitle == null || memBoardTitle == "") {
				alert("제목을 입력해주세요");
				$("#memBoardTitle").focus();
				return false;
			}
			
			if(memBoardContent == null || memBoardContent == "") {
				alert("내용을 입력해주세요");
				$("#memBoardContent").focus();
				return false;
			}
			
			alert("수정이 완료되었습니다.");
			$("#modifyForm").submit();
		})
	})
</script>
</html>