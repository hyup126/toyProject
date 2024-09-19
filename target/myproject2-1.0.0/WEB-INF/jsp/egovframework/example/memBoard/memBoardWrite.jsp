<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 작성</title>
    <link rel="stylesheet" type="text/css" href="css/egovframework/boardList.css"> <!-- CSS 파일 링크 -->
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
        <h1>게시물 작성</h1>

        <form name="memBoardForm" action="/board/memBoardSave.do" method="post">
        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <table class="listTable">
                <tr>
                    <th colspan="2">게시물 정보 입력</th>
                </tr>
                <tr>
                    <td class="listCenter">제목:</td>
                    <td><input type="text" name="memBoardTitle" required></td>
                </tr>
                <tr>
                    <td class="listCenter">작성자:</td>
                    <td><input type="text" name="memBoardWriter" value="a001" readonly="readonly"></td>
                </tr>
                <tr>
                    <td class="listCenter">내용:</td>
                    <td><textarea name="memBoardContent" rows="10" cols="50" required></textarea></td>
                </tr>
            </table>

            <div style="text-align: center; margin-top: 20px;">
                <button type="submit" class="btn btn-primary">저장</button>
            </div>
        </form>

        <div id="logoutButton">
            <a href="logout.jsp">로그아웃</a>
        </div>
    </div>
</body>
</html>