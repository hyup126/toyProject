<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>게시물 상세보기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" 
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/css/egovframework/boardList.css"> <!-- CSS 파일 링크 -->
    <script
    src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous">
    </script>
    <style>
        body {
            background-color: #ffffff;
        }
        div#border {
            width: 1250px; /* 너비를 1250px로 설정 */
            margin: 0 auto; /* 중앙 정렬 */
            padding: 20px;
        }
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
        .card {
            margin-bottom: 20px; /* 카드 사이 간격 */
            border: 1px solid #ddd; /* 카드 경계선 */
            border-radius: 5px; /* 카드 모서리 둥글게 */
        }
        .card-header {
            background-color: #E4EAF8; /* 카드 헤더 배경 색 */
        }
        .card-body {
            padding: 15px; /* 카드 본문 패딩 */
        }
        textarea {
            width: 100%;
            height: 80px;
            white-space: pre;
            margin-bottom: 10px; /* 입력창과 버튼 간격 */
        }
    </style>
</head>
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
                <td><pre>${memBoard.memBoardContent}</pre></td>
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

        <!-- 댓글 목록 시작 -->
        <div class="card">
            <div class="card-header">
                <h5 class="card-title">댓글 목록</h5>
            </div>
            <div class="card-body" id="rpBody">
            	<c:if test="${empty replyList }">
            		<c:out value="없음"/>
            	</c:if>
            	<c:if test="${not empty replyList }">
                <c:forEach var="reply" items="${replyList }">
                    <div class="card" data-reply-no="${reply.replyNo }" data-memboard-no="${reply.memBoardNo }">
                        <div class="card-header pt-2">
                            <div class="d-flex justify-content-between align-items-center">
                                <span id="repWriter">${reply.replyWriter }</span>
                                <small class="text-body-secondary"> 
                                    <button class="btn btn-sm btn-primary replyUpdateBtn" id="replyUdt">수정</button>
                                    <button type="button" class="btn btn-sm btn-danger" id="delRplBtn">삭제</button>
                                </small>
                                
                            </div>
                        </div>
                        <div class="card-body"> 
                            <pre id="replyContent"><c:out value="${reply.replyContent }" escapeXml="true"/></pre>
                        </div>    
                    </div>
                    <br/>
                </c:forEach>
            	</c:if>
            </div>
        </div>
        <!-- 댓글 목록 끝 -->

        <!-- 댓글 입력 폼 시작 -->
        <div class="card">
            <div class="card-header">
                <h5 class="card-title">댓글 작성</h5>
            </div>
            <div class="card-body">
                <form action="/board/insertReply.do" method="POST">
                	<sec:csrfInput />
                    <input type="hidden" name="memBoardNo" id="memBoardNo" value="${memBoard.memBoardNo }"/>
                    <textarea name="replyContent" placeholder="내용을 입력해주세요."></textarea>
                    <input type="submit" class="btn btn-outline-primary" value="등록" /> 
                </form>
            </div>
        </div>

        <br>
        <button type="button" class="btn btn-outline-info" id="udtBtn" onclick="javascript:location.href='/board/memBoardModify.do?memBoardNo=${memBoard.memBoardNo }'" style="float: right;">수정</button>
        <button type="button" class="btn btn-outline-danger" id="delBtn" onclick="javascript:location.href='/board/memBoardDelete.do?memBoardNo=${memBoard.memBoardNo}'" style="float: right;">삭제</button>
        <button type="button" class="btn btn-outline-info" id="listBtn" onclick="javascript:location.href='/board/memBoardList.do'" style="float: right;">목록</button>
        <br><br>
    </div>
</body>
<script type="text/javascript">
	
	
	var replyList = "${replyList }";
	console.log(replyList)
	
	var memId = "${memVO.memId}";
	console.log(memId);
	var memBoardWriter = "${memBoard.memBoardWriter}";
	console.log(memBoardWriter);
	var replyWriter = "${reply.replyWriter }";
	console.log(replyWriter);
	
	
$(function(){
	var rpBody = $("#rpBody");
	console.log(rpBody);
	var delRplBtn = $("#delRplBtn");
	
	var replyUdt = $("#replyUdt");
	
	delRplBtn.click(function(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var rpCard = $(this).closest(".card");
		var rpNo = rpCard.data("reply-no");
        var memBoardNo = rpCard.data("memboard-no");
        
        console.log("rpCard: ", rpCard);
        console.log("rpNo: " + rpNo);
        console.log("memBoardNo: " + memBoardNo)
		
        $.ajax({
        	type: "post",
        	url: "/board/deleteReply.do",
        	data: {
        		replyNo: rpNo,
        		memBoardNo: memBoardNo
        	},
        	beforeSend: function(xhr) {
                // 데이터를 전송하기 전에 헤더에 CSRF 값을 설정한다.
                xhr.setRequestHeader(header, token);
            },
            success: function(response) {
            	console.log(response);
            	if(response.status == "success") {
            		alert(response.message);
            		location.href = reponse.redirectUrl;
            	}
            }
        })
        
	});
	
	/* 댓글 삭제 끝 */
	/* 댓글 수정 */
	rpBody.on("click", "#replyUdt", function(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var replyContent = $("#replyContent").val();
		
		var rpCard = $(this).closest(".card");
		var rpNo = rpCard.data("reply-no");
        var memBoardNo = rpCard.data("memboard-no");
        
        console.log("rpCard: ", rpCard);
        console.log("rpNo: " + rpNo);
        console.log("memBoardNo: " + memBoardNo);
        
		var body = $(this).parents(".card").find("#replyContent");
		console.log("body", body);
		console.log("body", body[0].innerText);
		
		var html = "<textarea cols='70' rows='2' style='width:100%;' id='rvtInCn'>"+body[0].innerText+"</textarea><br>";
		html += "<button class='btn btn-sm btn-primary' id='rvInUdtBtn'>수정</button><button class='btn btn-sm btn-danger' id='rvtInCancelBtn'>취소</button>";
		console.log("body", body[0].innerText);
		body[0].innerHTML = html;
	});
	
	rpBody.on("click", "#rvInUdtBtn", function(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var rpCard = $(this).closest(".card");
		var rpNo = rpCard.data("reply-no");
        var memBoardNo = rpCard.data("memboard-no");
        
        console.log("rpCard: ", rpCard);
        console.log("rpNo: " + rpNo);
        console.log("memBoardNo: " + memBoardNo);
		
		var rp = $(this).parents("#replyContent").find("#rvtInCn").val();
		console.log("rp: " + rp);
		
		$.ajax({
        	type: "post",
        	url: "/board/updateReply.do",
        	data: {
        		replyNo: rpNo,
        		replyContent: rp,
        		memBoardNo: memBoardNo
        	},
        	beforeSend: function(xhr) {
                // 데이터를 전송하기 전에 헤더에 CSRF 값을 설정한다.
                xhr.setRequestHeader(header, token);
            },
            success: function(response) {
            	console.log(response);
            	if(response.status == "success") {
            		alert(response.message);
            		location.href = reponse.redirectUrl;
            	}
            }
        })
	})
	
	rpBody.on("click", "#rvtInCancelBtn", function(){
		var rp = $(this).parents("#replyContent").find("#rvtInCn").text();
		var body = $(this).parents("#replyContent");
		body[0].innerHTML = rp;
	});
	
	
})
	
</script>

</html>