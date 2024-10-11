<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>게시글 수정</title>
    <link rel="stylesheet" type="text/css" href="/css/egovframework/boardList.css"> <!-- CSS 파일 링크 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<style>
body {
    background-color: #f4f4f4; /* 배경색 변경 */
    font-family: "Arial", sans-serif;
}

#border {
    max-width: 800px;
    margin: 40px auto;
    padding: 20px;
    border: 1px solid #dee2e6; /* 테두리 색 변경 */
    border-radius: 10px; /* 테두리 둥글게 */
    background-color: #ffffff;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
}

h1 {
    text-align: center;
    margin-bottom: 20px;
    color: #343a40; /* 제목 색 변경 */
}

.form-group {
    margin-bottom: 20px; /* 여백 증가 */
}

label {
    font-weight: bold;
    color: #495057; /* 레이블 색 변경 */
}

textarea {
    width: 100%;
    height: 150px;
    padding: 12px; /* 패딩 증가 */
    border: 1px solid #ced4da;
    border-radius: 4px;
    resize: vertical; /* 세로로 크기 조절 가능 */
}

input[type="text"], input[type="file"] {
    width: 100%;
    padding: 12px; /* 패딩 증가 */
    border: 1px solid #ced4da;
    border-radius: 4px;
    box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1); /* 내부 그림자 추가 */
}

img {
    display: block;
    margin: 10px auto;
    max-width: 150px; /* 이미지 크기 조정 */
    max-height: 100px; /* 이미지 크기 조정 */
    border: 1px solid #ddd;
    border-radius: 4px;
}

#submitBtn, #updateBtn, #plusBtn {
    display: block;
    margin: 20px auto;
    padding: 12px 20px; /* 패딩 증가 */
    font-size: 16px;
    color: #fff;
    background-color: #007bff; /* 버튼 색 변경 */
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s;
}

#submitBtn:hover, #updateBtn:hover, #plusBtn:hover {
    background-color: #0056b3; /* 호버 시 색 변경 */
}

#logoutButton {
    position: absolute;
    top: 20px;
    right: 20px;
}

#logoutButton a {
    display: inline-block;
    padding: 10px 16px; /* 패딩 증가 */
    font-size: 14px;
    color: #fff;
    background-color: #dc3545; /* 색 변경 */
    border-radius: 4px;
    text-decoration: none;
    cursor: pointer;
    transition: background-color 0.3s;
}

#logoutButton a:hover {
    background-color: #c82333; /* 호버 시 색 변경 */
}

input[type="text"], input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }

.uploaded-file {
    display: flex;
    justify-content: space-between; /* 파일 이름과 버튼 사이 여백 조정 */
    align-items: center; /* 중앙 정렬 */
    padding: 8px; /* 패딩 추가 */
    border: 1px solid #ced4da; /* 테두리 추가 */
    border-radius: 4px; /* 테두리 둥글게 */
    margin-top: 5px; /* 파일 항목 간의 간격 */
}

.uploaded-file button {
    background-color: #dc3545; /* 삭제 버튼 색 */
    color: white; /* 텍스트 색 */
    border: none;
    padding: 5px 10px; /* 패딩 */
    border-radius: 4px; /* 테두리 둥글게 */
    cursor: pointer; /* 커서 포인터 */
    transition: background-color 0.3s; /* 호버 효과 */
}

.uploaded-file button:hover {
    background-color: #c82333; /* 호버 시 색 변경 */
}
.preview {
            margin-bottom: 10px;
        }
.mailbox-attachment-name {
    display: inline-block;
    margin-right: 10px; /* 링크와 버튼 간의 간격 */
    color: #007bff; /* 링크 색상 */
    text-decoration: none; /* 밑줄 제거 */
    transition: color 0.3s; /* 색상 변화 효과 */
}

.mailbox-attachment-name:hover {
    color: #0056b3; /* 호버 시 색상 변화 */
}

.mailbox-attachment-size {
    display: inline-block; /* 버튼을 링크와 나란히 표시 */
}

.down_btn {
    background-color: #dc3545; /* 삭제 버튼 색 */
    color: white; /* 텍스트 색 */
    border: none;
    padding: 5px 10px; /* 패딩 */
    border-radius: 4px; /* 테두리 둥글게 */
    cursor: pointer; /* 커서 포인터 */
    transition: background-color 0.3s; /* 호버 효과 */
}

.down_btn:hover {
    background-color: #c82333; /* 호버 시 색 변경 */
}

.down_btn:focus {
    outline: none; /* 포커스 시 외곽선 제거 */
}
#orinm {
    display: inline-block; /* 블록으로 만들어 간격 조정 가능 */
    color: #007bff; /* 링크 색상 */
    text-decoration: none; /* 기본 밑줄 제거 */
    padding: 5px 10px; /* 패딩 추가 */
    border-radius: 4px; /* 테두리 둥글게 */
    transition: background-color 0.3s, color 0.3s; /* 효과 전환 */
}

#orinm:hover {
    background-color: #f0f0f0; /* 호버 시 배경 색상 */
    color: #0056b3; /* 호버 시 링크 색상 변화 */
}

#orinm:focus {
    outline: none; /* 포커스 시 외곽선 제거 */
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
<body>
    <div id="border">
        <h1>게시글 수정</h1>

        <!-- 게시글 수정 폼 -->
        <form id="modifyForm" action="/board/memBoardUpdate.do" method="post" enctype="multipart/form-data">
            <sec:csrfInput/>
            <input type="hidden" name="memBoardNo" value="${memBoard.memBoardNo}" />
            <input type="hidden" name="searchCondition" value="${searchCondition }"/>
            <input type="hidden" name="searchKeyword" value="${searchKeyword }"/>
            <div class="form-group">
                <label for="memBoardTitle">제목:</label>
                <input type="text" id="memBoardTitle" name="memBoardTitle" class="form-control" value="${memBoard.memBoardTitle}" required />
            </div>
            <div class="form-group">
                <label for="memBoardWriter">작성자:</label>
                <input type="text" id="memBoardWriter" name="memBoardWriter" class="form-control" value="${memVO.memId }" readonly />
            </div>
            <div class="form-group">
                <label for="memBoardContent">내용:</label>
                <textarea id="memBoardContent" name="memBoardContent" class="form-control" rows="10" required>${memBoard.memBoardContent}</textarea>
            </div>
            <div id="fileUploadContainer">
                <div class="form-group" id="fileGroup1">
                	<button id="plusBtn" type="button">파일 추가</button>
                    <img src="" id="preview1" class="preview" alt=""/><br>
                    <label for="memBoardFile1">파일 업로드</label>
                    <input type="file" class="files" name="memBoardFile" id="memBoardFile1" onchange="previewImage(this)">
                </div>
            </div>
            <div class="card-footer bg-white">
                <ul class="mailbox-attachments d-flex align-items-stretch clearfix">
                	<c:set value="${memBoard.memBoardFileList}" var="memBoardFile" />
                        <c:if test="${not empty memBoardFile}">
                                <c:forEach items="${memBoardFile}" var="memFile">
                            <div class="row" id="div_${memFile.atchFileId}">
                                  <c:choose>
								        <c:when test="${not empty memFile.streFileNm}">
								            <%-- <img src="<c:url value='/board/showImg.do' />?fileName=${fn:escapeXml(memFile.streFileNm)}&filePath=${fn:escapeXml(memFile.fileStreCours)}" style="width: 14rem;" alt="img-blur-shadow"> --%>
								        	<%-- 이미지 미리보기 --%>
                        					<img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath }/upload/${memFile.streFileNm}" alt="${memFile.orignlFileNm}" id="imgSrc" style="max-width: 100%; height: auto;">
								        	<a href="${pageContext.request.contextPath}/board/download.do?streFileNm=${memFile.streFileNm}&orignlFileNm=${memFile.orignlFileNm}" name="orinm">
								        	${memFile.orignlFileNm}</a>
                        					<span class="mailbox-attachment-size clearfix mt-1">
                                        		<button class="down_btn attachmentFileDel" id="span_${memFile.atchFileId}" data-file-no="${memFile.atchFileId}">delete</button>
                                    		</span>
								        </c:when>
								    </c:choose>
                            </div>
						          </c:forEach>
                        </c:if>
                </ul>
            </div>
            <div class="form-group">
                <button type="button" id="updateBtn" class="btn_blue_l">수정 완료</button>
                
                <a href="/board/memBoardList.do?searchCondition=${searchCondition}&searchKeyword=${searchKeyword}" class="btn_red_l">취소</a>
            </div>
        </form>
    </div>
</body>
<script type="text/javascript">
    $(function(){
    	console.log("searchKeyword : " + "${searchKeyword}");
    	console.log("searchCondition : " + "${searchCondition}");
    	
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
    	
    	$(".attachmentFileDel").on("click", function(event){
    	    event.preventDefault(); // 기본 동작 방지

    	    var fileNo = $(this).data("file-no");
    	    console.log("fileNo : " + fileNo);
    	    var confirmation = confirm("정말로 이 파일을 삭제하시겠습니까?");
    	    if (!confirmation) {
    	        return; // 사용자가 취소하면 종료
    	    }

    	    $.ajax({
    	        url: '/board/memBoardFileDelete.do',
    	        type: 'POST',
    	        data: { 
    	        	atchFileId : fileNo,  // PK로 사용할 파일 ID
    	        },
    	        headers: {
    	            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
    	        },
    	        success: function(data) {
    	            alert(data.message);
    	            // 파일 항목을 제거
    	            $("#div_" + fileNo).remove();
    	        },
    	        error: function(xhr) {
    	            alert('오류 발생: ' + xhr.statusText);
    	        }
    	    });
    	});
        $('#updateBtn').click(function() {
        	console.log("searchKeyword : " + "${searchKeyword}");
        	console.log("searchCondition : " + "${searchCondition}");
            var formData = new FormData($('#modifyForm')[0]);
            $.ajax({
                url: '/board/memBoardUpdate.do',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
                },
                success: function(data) {
                    alert('수정 완료: ' + data.message);
                    $("#modifyForm").attr("action", "/board/memBoardList.do");
                    $("#modifyForm").submit();
                },
                error: function(xhr) {
                    alert('오류 발생: ' + xhr.statusText);
                }
            });
        });

    });
</script>
</html>