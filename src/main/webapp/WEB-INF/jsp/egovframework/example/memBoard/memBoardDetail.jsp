<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 상세보기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" 
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/css/egovframework/boardList.css"> <!-- CSS 파일 링크 -->
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
        <h1>게시물 상세보기</h1>

        <!-- 게시물 상세보기 영역 -->
        <table class="listTable">
            <tr>
                <th colspan="2">게시물 정보</th>
            </tr>
            <tr>
                <td class="listCenter">제목:</td>
                <td>${memBoard.memBoardTitle}</td>
            </tr>
            <tr>
                <td class="listCenter">작성자:</td>
                <td>${memBoard.memBoardWriter}</td>
            </tr>
            <tr>
                <td class="listCenter">내용:</td>
                <td>${memBoard.memBoardContent}</td>
            </tr>
            <tr>
                <td class="listCenter">등록일:</td>
                <td>${memBoard.regDate}</td>
            </tr>
            <tr>
                <td class="listCenter">조회수:</td>
                <td>${memBoard.memBoardHit}</td>
            </tr>
        </table>

        <div style="text-align: center; margin-top: 20px;">
            <a href="/board/memBoardModify.do?memBoardNo=${memBoard.memBoardNo }" class="btn_blue_l">수정</a>
            <a href="/board/memBoardDelete.do?memBoardNo=${memBoard.memBoardNo}" class="btn_blue_l">삭제</a>
            <a href="listPosts.jsp" class="btn_blue_l">목록으로</a>
        </div>
        
        <!-- 댓글 목록 시작 -->
        <div class="col-md-12 pt-5">
			<div class="card">
				<div class="card-header">
					<h5 class="card-title">댓글 목록</h5>
				</div>
				<div class="card-body" id="rvBody">
					<c:if test="${not empty replyList }">
						<c:forEach items="${replyList }" var="reply">
							<div class="card" data-reply-no="${reply.replyNo }" data-memboard-no="${reply.memBoardNo }">
								<div class="card-header pt-2">
									<div class="d-flex justify-content-between align-items-center">
						                <div class="btn-group" id="btnGroup">
						                	<span id="repWriter">${reply.replyWriter }</span>
						                </div>
						                <small class="text-body-secondary">
						                	<i class="bi-pencil-fill" id="replyUdt"></i>
						                	<i class="bi-trash-fill" id="replyDel"></i>
						                </small>
						              </div>
								</div>
								<div class="card-body"> 
									<pre><c:out value="${reply.replyContent }" escapeXml="true"/></pre>
								</div>	
							</div>
							<br/>
						</c:forEach>
					</c:if>
				</div>
			</div>
        <!-- 댓글 목록 끝 -->

        <!-- 댓글 입력 폼 시작 -->
        <h2>댓글 작성</h2>
        <form action="" method="post">
            <input type="hidden" name="memBoardNo" value="${memBoard.memBoardNo}">
            <div>
                <label for="replyWriter">작성자:</label>
                <input type="text" id="replyWriter" name="replyWriter" required>
            </div>
            <div>
                <label for="replyContent">내용:</label>
                <textarea id="replyContent" name="replyContent" rows="4" cols="50" required></textarea>
            </div>
            <div style="margin-top: 10px;">
                <button type="submit" class="btn_blue_l">댓글 등록</button>
            </div>
        </form>
        <!-- 댓글 입력 폼 끝 -->
    </div>
</body>
</html>