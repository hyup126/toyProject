<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>회원 리스트</title>
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
<script type="text/javascript">
	/* 글 목록 화면 function */
	function fn_egov_selectList() {
		document.listForm.action = "<c:url value='/board/memBoardList.do'/>";
	   	document.listForm.submit();
	}
</script>
<body>
<form id="listForm" name="listForm" method="get" action="/board/memBoardList.do">
	<sec:csrfInput />
    <div id="border">
        <h2>자유게시판</h2>
        <input type="hidden" name="memId" />
        <input type="hidden" name="pageIndex" value="1" />
        
        <!-- 로그아웃 버튼 -->
        <div id="logoutButton">
            <a href="<c:url value='/logout'/>">로그아웃</a>
        </div>
	         <div id="search">
	            <label for="searchCondition">검색 조건</label>
	            <select name="searchCondition" id="searchCondition" class="use">
	                <option value="0">제목</option>
	                <option value="1">작성자</option>
	            </select>
	            <label for="searchKeyword">검색어</label>
	            <input type="text" name="searchKeyword" id="searchKeyword" class="txt"/>
	            <span class="btn_blue_l">
	                <a href="javascript:fn_egov_selectList();">검색</a>
	            </span>
	        </div>
	        
	        <!-- 게시물 등록 버튼 -->
	        <div id="registerButton" style="margin-top: 10px;">
	            <span class="btn_blue_l">
	                <a href="<c:url value='/board/memBoardWrite.do'/>">게시물 등록</a>
	            </span>
	        </div>
	        <br>
        <div id="content_pop">
        	<!-- 타이틀 -->
        	<!-- // 타이틀 -->
            </div>
            <table class="listTable">
                <thead>
                    <tr>
                        <th class="listCenter">게시글 번호</th>
                        <th class="listCenter">제목</th>
                        <th class="listCenter">작성자</th>
                        <th class="listCenter">등록일</th>
                        <th class="listCenter">조회수</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="memBoard" items="${memBoardList}" varStatus="status">
                        <tr>
                            <td class="listCenter">${memBoard.memBoardNo}</td>
                            <td class="listCenter"><a href="/board/memBoardDetail.do?memBoardNo=${memBoard.memBoardNo}">${memBoard.memBoardTitle}</a></td>
                            <td class="listCenter">${memBoard.memBoardWriter}</td>
                            <td class="listCenter">${memBoard.regDate}</td>
                            <td class="listCenter">${memBoard.memBoardHit}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
         	<div class="pagination">
			    <c:if test="${paginationInfo.currentPageNo > 1}">
			        <a href="boardList.do?pageIndex=${paginationInfo.currentPageNo - 1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">이전</a>
			    </c:if>
			
			    <c:forEach var="i" begin="1" end="${paginationInfo.pageSize}" step="1">
			        <c:choose>
			            <c:when test="${i == paginationInfo.currentPageNo}">
			                <span class="active">${i}</span>
			            </c:when>
			            <c:otherwise>
			                <a href="boardList.do?pageIndex=${i}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">${i}</a>
			            </c:otherwise>
			        </c:choose>
			    </c:forEach>
			
			    <c:if test="${hasNext}">
			        <a href="boardList.do?pageIndex=${paginationInfo.currentPageNo + 1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">다음</a>
			    </c:if>
			</div>
        </div>
</form>
</body>
</html>