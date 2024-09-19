<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 리스트</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script
    src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous">
    </script>
    <link rel="stylesheet" href="css/egovframework/boardList.css">
</head>
<script type="text/javascript">
	/* 글 목록 화면 function */
	function fn_egov_selectList() {
		document.listForm.action = "<c:url value='/boardList.do'/>";
	   	document.listForm.submit();
	}
</script>
<body>
<form id="listForm" name="listForm" method="get" action="boardList.do">
    <div id="border">
        <h2>사원 리스트</h2>
        <input type="hidden" name="memId" />
        <input type="hidden" name="pageIndex" value="1" />
        
        <!-- 로그아웃 버튼 -->
        <div id="logoutButton">
            <a href="<c:url value='/logout.do'/>">로그아웃</a>
        </div>
	         <div id="search">
	            <label for="searchCondition">검색 조건</label>
	            <select name="searchCondition" id="searchCondition" class="use">
	                <option value="0">회원아이디</option>
	                <option value="1">회원이름</option>
	            </select>
	            <label for="searchKeyword">검색어</label>
	            <input type="text" name="searchKeyword" id="searchKeyword" class="txt"/>
	            <span class="btn_blue_l">
	                <a href="javascript:fn_egov_selectList();">검색</a>
	            </span>
	        </div>
        <div id="content_pop">
        	<!-- 타이틀 -->
        	<!-- // 타이틀 -->
            </div>
            <table class="listTable">
                <thead>
                    <tr>
                        <th class="listCenter">회원아이디</th>
                        <th class="listCenter">회원이름</th>
                        <th class="listCenter">비밀번호</th>
                        <th class="listCenter">이메일</th>
                        <th class="listCenter">연락처</th>
                        <th class="listCenter">생년월일</th>
                        <th class="listCenter">주소</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="memBoard" items="${memBoardList}" varStatus="status">
                        <tr>
                            <td class="listCenter">${memBoard.memId}</td>
                            <td class="listRight">${memBoard.memName}</td>
                            <td class="listCenter">${memBoard.memPass}</td>
                            <td class="listCenter">${memBoard.memEmail}</td>
                            <td class="listCenter">${memBoard.memTel}</td>
                            <td class="listCenter">${memBoard.memBirth}</td>
                            <td class="listCenter">${memBoard.memAddr}</td>
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