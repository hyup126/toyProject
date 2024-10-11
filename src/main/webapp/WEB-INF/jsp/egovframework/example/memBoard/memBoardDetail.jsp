<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		    font-family: Arial, sans-serif;
		    background-color: #f4f4f4;
		    margin: 0;
		    padding: 20px;
		}
		
		.post-container {
		    background: white;
		    border-radius: 8px;
		    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
		    padding: 20px;
		    max-width: 1600px;
		    margin: auto;
		}
		
		.post-title {
		    font-size: 24px;
		    margin: 0;
		}
		
		.post-meta {
		    font-size: 14px;
		    color: #555;
		    margin: 10px 0;
		}
		
		.post-views {
		    margin-left: 15px;
		}
		
		.post-content {
		    font-size: 16px;
		    line-height: 1.6;
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
        .down_btn button{
		    background: #222;
		    font-size: 12px;
		    color: #fff;
		    cursor: pointer;
		    padding: 2px 16px;
		    line-height: 20px;
		    border-radius:30px;
		    border:none;
		    letter-spacing:-1px;
		}
		.down_btn button:hover{
		   box-shadow:1px 1px 4px rgba(0,0,0,0.4);
		
		}
		/* 로그아웃 버튼 스타일 */
        #logoutButton {
            position: absolute;
            top: 20px;
            right: 20px;
        }
    </style>
</head>
<body>
	<div id="logoutButton">
        <a href="<c:url value='/logout.do'/>">로그아웃</a>
        <sec:csrfInput/>
    </div>
    <div id="border">
        <h1>게시물 상세보기</h1>

        <!-- 게시물 상세보기 영역 -->
        <div class="post-container">
	        <h1 class="post-title">${memBoard.memBoardTitle}</h1>
	        <div class="post-meta">
	            <span class="post-author">${memBoard.memBoardWriter}</span>
	            <input type="hidden" name="memBoardNo" value="${memBoard.memBoardNo }"/>
	            <fmt:formatDate value="${memBoard.regDate}" var="regDate" pattern="yyyy-MM-dd"/>
	            <span class="post-date">${regDate}</span>
	            <span class="post-views">${memBoard.memBoardHit}</span>
	        </div>
	        <div class="post-content">
	            <p>${memBoard.memBoardContent}</p>
	            <br><br>
	        	<c:set value="${memBoard.memBoardFileList}" var="memBoardFile" />
                        <c:if test="${not empty memBoardFile}">
                            <div class="row">
                                <c:forEach items="${memBoardFile}" var="memFile">
                                  <c:choose>
								        <c:when test="${not empty memFile.streFileNm}">
								        	<%-- 이미지 미리보기 --%>
                        					<img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath }/upload/${memFile.streFileNm}" alt="${memFile.orignlFileNm}" style="max-width: 70%; height: auto;">
								        	<a href="${pageContext.request.contextPath}/board/download.do?streFileNm=${memFile.streFileNm}&orignlFileNm=${memFile.orignlFileNm}">
								        	${memFile.orignlFileNm}</a>
								            <%-- <img src="<c:url value='/board/showImg.do' />?fileName=${fn:escapeXml(memFile.streFileNm)}&filePath=${fn:escapeXml(memFile.fileStreCours)}" style="width: 14rem;" alt="img-blur-shadow"> --%>
								        </c:when>
								    </c:choose>
						          </c:forEach>
                            </div>
                        </c:if>
	        </div>
	    </div>

        <!-- 댓글 목록 시작 -->
        <div class="card">
            <div class="card-header">
                <h5 class="card-title">댓글 목록 [${replyCnt }]</h5>
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
                                <span id="repWriter" >${reply.replyWriter }</span>
                                <small class="text-body-secondary"> 
                                    <button class="btn btn-sm btn-primary replyUdt" type="button" id="replyUdt">수정</button>
                                    <button type="button" class="btn btn-sm btn-danger" id="delRplBtn">삭제</button>
                                </small>
                                
                            </div>
                        </div>
                        <div class="card-body"> 
				            <div class="replyContent" data-original-content="${reply.replyContent}">
				                <pre><c:out value="${reply.replyContent }" escapeXml="true"/></pre>
				            </div>
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
                <form id="replyFrm" action="/board/insertReply.do" method="POST">
                	<sec:csrfInput />
                    <input type="hidden" name="memBoardNo" id="memBoardNo" value="${memBoard.memBoardNo }"/>
                    <textarea id="replyContent" name="replyContent" placeholder="내용을 입력해주세요."></textarea>
                    <input type="button" id="replyInsertBtn" class="btn btn-outline-primary" value="등록" /> 
                </form>
            </div>
        </div>

		<form id="detailFrm" action="" method="post">
			<sec:csrfInput/>
			<input type="hidden" name="memBoardNo" id="memBoardNo" value="${memBoard.memBoardNo }"/>
			<input type="hidden" id="searchCondition" name="searchCondition" value="${searchCondition }"/>
            <input type="hidden" id="searchKeyword" name="searchKeyword" value="${searchKeyword }"/>
		</form>
        <br>
        <button type="button" class="btn btn-outline-info" id="udtBtn" style="float: right;">수정</button>
        <button type="button" class="btn btn-outline-danger" id="delBtn" style="float: right;">삭제</button>
        <button type="button" class="btn btn-outline-info" id="listBtn" onclick="javascript:location.href='/board/memBoardList.do?searchCondition=${searchCondition}&searchKeyword=${searchKeyword}'" style="float: right;" style="float: right;">목록</button>
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
	
	var downBtn = $(".downBtn");
	downBtn.on('click', function(){
		var fileId = $(this).data("file-id");
		console.log("fileId" + fileId);
		location.href = "/board/download.do?fileId=" + fileId;
	})
	
	
$(function(){
	
	console.log("searchKeyword : " + "${searchKeyword}");
	console.log("searchCondition : " + "${searchCondition}");
	
	$("#udtBtn").on("click", function(){
		var detailFrm = $("#detailFrm");
		$("#searchKeyword",detailFrm).val("${searchKeyword}");
		$("#searchCondition",detailFrm).val("${searchCondition}");
		console.log("searchKeyword : " + "${searchKeyword}");
		console.log("searchCondition : " + "${searchCondition}");
		detailFrm.attr("action", "/board/memBoardModify.do").submit();
		
	});
	
	var replyInsertBtn = $("#replyInsertBtn");
	replyInsertBtn.on("click", function() {
		console.log($("#replyContent").val());
		if($("#replyContent").val() == null || $("#replyContent").val() == '') {
			alert("댓글 내용 입력");
			return false;
		}
		
		replyFrm.submit();
	});
	
	$('input[name="memBoardFile"]').each(function(index) {
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
    }
	
	// 삭제 버튼 클릭 이벤트
    $('#delBtn').on('click', function() {
        console.log("memBoardNo: " + memBoardNo);
        memBoardNo = Number(memBoardNo); // 숫자로 변환
        var confirmation = confirm("정말로 이 게시물을 삭제하시겠습니까?");
        if (!confirmation) return;

        // Ajax 요청
        $.ajax({
            type: 'POST',
            url: '/board/memBoardDelete.do',
            data: {
                memBoardNo: memBoardNo, // 서버에 보낼 게시물 번호
            },
            headers: {
                'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content') // CSRF 토큰 설정
            },
            success: function(data) {
                console.log(data.message);
                if (data.message === "삭제 성공") {
                    alert("게시물이 성공적으로 삭제되었습니다.");
                    location.href = "/board/memBoardList.do"; // 삭제 성공 후 목록 페이지로 이동
                }
            },
            error: function(xhr) {
                alert('오류 발생: ' + xhr.statusText);
            }
        });
    });
	
	var memBoardNo = "${memBoard.memBoardNo}";
	console.log("memBoard : " + memBoardNo);
	memBoardNo = Number(memBoardNo);
    console.log(typeof(memBoardNo));
	
	var rpBody = $("#rpBody");
	console.log(rpBody);
	var delRplBtn = $("#delRplBtn");
	
	var replyUdt = $("#replyUdt");
	
	rpBody.on("click", "#delRplBtn" ,function(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var rpCard = $(this).closest(".card");
		var rpNo = rpCard.data("reply-no");
        var memBoardNo = rpCard.data("memboard-no");
        
        console.log("rpCard: ", rpCard);
        console.log("rpNo: " + rpNo);
        console.log("memBoardNo: " + memBoardNo)
		
        var data = {
        	replyNo: rpNo,
    		memBoardNo: memBoardNo
        }
        
        $.ajax({
        	type: "post",
        	url: "/board/deleteReply.do",
        	data: JSON.stringify(data),
        	dataType:'json',
  		    contentType : "application/json", 
        	beforeSend: function(xhr) {
                // 데이터를 전송하기 전에 헤더에 CSRF 값을 설정한다.
                xhr.setRequestHeader(header, token);
            },
            success: function(res) {
            	console.log("333333 : " + res);
            	if(res.result == "success") {
            		alert("삭제 성공");
            		location.reload();
            	} else if(res.result == "fail") {
            		alert(res.msg);
            		return;
            	}
            },
            error:function(xhr){
            	console.log(xhr.status);
            }
        })
        
	});
	
	/* 댓글 삭제 끝 */
	/* 댓글 수정 */
	rpBody.on("click", "#replyUdt", function() {
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");

    // 클릭된 버튼이 속한 카드 요소를 찾음
    var rpCard = $(this).closest(".card");
    var rpNo = rpCard.data("reply-no");
    var memBoardNo = rpCard.data("memboard-no");

    console.log("rpCard: ", rpCard);
    console.log("rpNo: " + rpNo);
    console.log("memBoardNo: " + memBoardNo);

    // 댓글 내용을 표시하는 부분을 찾음
    var body = rpCard.find(".replyContent"); // 클래스 선택자로 변경
    console.log("body", body);
    console.log("body", body[0].innerText);

    // textarea를 추가할 위치
    if (rpNo == rpCard.data("reply-no")) {
        var html = "<textarea cols='70' rows='2' style='width:100%;' id='rvtInCn'>" + body[0].innerText + "</textarea><br>";
        html += "<button class='btn btn-sm btn-primary' id='rvInUdtBtn'>수정</button><button class='btn btn-sm btn-danger' id='rvtInCancelBtn'>취소</button>";
        
        // body의 내용을 새 HTML로 변경
        body[0].innerHTML = html;
    }
});
	
	rpBody.on("click", "#rvInUdtBtn", function(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var rpCard = $(this).closest(".card");
		var rpNo = rpCard.data("reply-no");
        var memBoardNo = rpCard.data("memboard-no");
        
        /* console.log("rpCard: ", rpCard);
        console.log("rpNo: " + rpNo);
        console.log("memBoardNo: " + memBoardNo); */
		
        var rp = $(this).closest(".card").find("#rvtInCn").val();
		/* console.log("rp: " + rp); */
		
		var data = {replyNo: rpNo, replyContent: rp, memBoardNo: memBoardNo}
		
		$.ajax({
        	type: "POST",
        	url: "/board/updateReply.do",
        	data: JSON.stringify(data),
        	dataType:'json',
		    contentType : "application/json;", 
		  /* cache : false, */
        	beforeSend: function(xhr) {
                // 데이터를 전송하기 전에 헤더에 CSRF 값을 설정한다.
                xhr.setRequestHeader(header, token);
//                 xhr.setRequestHeader("Content-type","application/json");
            },
            success : function(res) {
            	console.log("222222222: " + res);
            	if(res.result == "success") {
            		alert("수정 완료");
            		location.reload();
            	} else if(res.result == "fail") {
            		alert(res.msg);
            		return;
            	}
            },
            error:function(xhr){
            	console.log(xhr.status);
            }
        })
	})
	
	rpBody.on("click", "#rvtInCancelBtn", function() {
	    // 수정 버튼이 속한 카드 요소를 찾음
	    var rpCard = $(this).closest(".card");

	    // 원래 댓글 내용을 찾음
	    var body = rpCard.find(".replyContent"); // 클래스로 찾기
	    var originalContent = body.data("original-content"); // 저장된 원래 내용 가져오기

	    // 댓글 내용을 원래대로 되돌리기
	    body[0].innerHTML = originalContent;
	});
	
})
	
</script>

</html>