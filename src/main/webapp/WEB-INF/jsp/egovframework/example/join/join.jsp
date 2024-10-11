<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="_csrf" content="${_csrf.token}"/>
  <meta name="_csrf_header" content="${_csrf.headerName}"/>
  <title>사원 등록</title>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  <script
  src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous">
  </script>
  <link rel="stylesheet" href="/css/egovframework/join.css">
</head>

<body>
	<div class="container">
        <div class="form-container">
            <h4 class="title">회원가입</h4>
            <form id="joinFrm" class="validation-form" method="post" action="/joinSave.do">
            <sec:csrfInput />
                <div class="form-group">
				    <label for="memId">아이디</label>
				    <div style="display: flex; align-items: center;">
				        <input type="text" id="memId" name="memId" placeholder="아이디를 입력하세요" required style="width: 200px; margin-right: 5px;">
				        <button type="button" id="btnIdCheck" class="btn btn-primary">중복체크</button>
				    </div>
				    <div id="idErr" class="error-message" style="color: red; display: none;" style="height: 38px;">아이디를 입력해주세요.</div>
				</div>
                <div class="form-group">
                    <label for="memPass">비밀번호</label>
                    <input type="password" id="memPass" name="memPass" placeholder="비밀번호를 입력하세요" required style="width: 200px; margin-right: 5px;">
                    <div id="passErr" class="error-message">비밀번호를 입력해주세요.</div>
                </div>
                <div class="form-group">
                    <label for="memName">이름</label>
                    <input type="text" id="memName" name="memName" placeholder="이름을 입력하세요" required style="width: 200px; margin-right: 5px;">
                    <div id="nmErr" class="error-message">이름을 입력해주세요.</div>
                </div>
                <div class="form-group">
				    <label for="memEmail">이메일</label>
				    <div class="email-container">
				        <input type="text" id="memEmail1" name="memEmail" placeholder="이메일 " required style="width: 48%; margin-right: 2%;">
				        <span style="display: inline-block; width: 4%; text-align: center;">@</span>
				        <input type="text" id="memEmail2" name="memEmail" placeholder="도메인" required style="width: 48%; margin-left: 2%;">
				    </div>
				    <div>
				        <div id="emailErr1" class="error-message">이메일을 입력해주세요.</div>
					    <div id="emailErr2" class="error-message">도메인을 입력해주세요.</div>
				    </div>
				</div>
                <div class="form-group">
				    <label for="memTel">연락처</label>
				    <div class="tel-container" style="display: flex; align-items: center;">
				        <input type="text" id="memTel1" name="memTel" placeholder="010" required style="width: 20%; margin-right: 5px;">&nbsp;-&nbsp;
				        
				        <input type="text" id="memTel2" name="memTel" placeholder="1234" required style="width: 25%; margin-right: 5px;">&nbsp;-&nbsp;
				        
				        <input type="text" id="memTel3" name="memTel" placeholder="5678" required style="width: 25%; margin-right: 5px;">
				    </div>
				        <div class="error-message" id="telErr2" style="color: red; display: none;">두번째 자리 입력해주세요.</div>
				        <div class="error-message" id="telErr3" style="color: red; display: none;">세번째 자리 입력해주세요.</div>
				</div>
                <div class="form-group">
                    <label for="memBirth">생년월일</label>
                    <input type="date" id="memBirth" name="memBirth" required>
                    <div class="error-message">생년월일을 입력해주세요.</div>
                </div>
                <div class="form-group">
                    <label for="sample4_postcode">주소 검색</label>
              		<input type="text" id="sample4_postcode" name="memAddr" placeholder="우편번호" class="form-control" readonly>
              		<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="btn btn-primary mt-2">
              		<input type="text" id="sample4_roadAddress" name="memAddr" placeholder="도로명주소" class="form-control mt-2" readonly>
              		<input type="text" id="sample4_jibunAddress" name="memAddr" placeholder="지번주소" class="form-control mt-2" readonly>
              		<input type="text" id="sample4_detailAddress" name="memAddr2" placeholder="상세주소" class="form-control mt-2">
              		<span id="guide" style="color:#999;display:none"></span>
                    <div class="error-message">주소를 입력해주세요.</div>
                </div>
                <span class="submit-button" id="submitBtn">등록 완료</span>
                <span class="submit-button" id="autoBtn">ㅈㄷㅇㅅ</span>
            </form>
        </div>
    </div>
  
  <script>
  window.addEventListener('load', () => {
	    const forms = document.getElementsByClassName('validation-form');

	    Array.prototype.filter.call(forms, (form) => {
	        form.addEventListener('submit', function (event) {
	            let valid = true;

	            // 필드 유효성 검사
	            const inputs = form.querySelectorAll('input[required]');
	            inputs.forEach(input => {
	                if (!input.value) {
	                    valid = false;
	                    input.nextElementSibling.style.display = 'block'; // 에러 메시지 표시
	                } else {
	                    input.nextElementSibling.style.display = 'none'; // 에러 메시지 숨김
	                }
	            });

	            if (!valid) {
	                event.preventDefault();
	                event.stopPropagation();
	            }
	            form.classList.add('was-validated');
	        }, false);
	    });
	});
  </script>
</body>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	function sample4_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var roadAddr = data.roadAddress; // 도로명 주소 변수
	            var extraRoadAddr = ''; // 참고 항목 변수
	
	            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	            // 건물명이 있고, 공동주택일 경우 추가한다.
	            if(data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	            if(extraRoadAddr !== ''){
	                extraRoadAddr = ' (' + extraRoadAddr + ')';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('sample4_postcode').value = data.zonecode;
	            document.getElementById("sample4_roadAddress").value = roadAddr;
	            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
	            
	            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	            /* if(roadAddr !== ''){
	                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
	            } else {
	                document.getElementById("sample4_extraAddress").value = '';
	            } */
	
	            var guideTextBox = document.getElementById("guide");
	            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	            if(data.autoRoadAddress) {
	                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                guideTextBox.style.display = 'block';
	
	            } else if(data.autoJibunAddress) {
	                var expJibunAddr = data.autoJibunAddress;
	                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                guideTextBox.style.display = 'block';
	            } else {
	                guideTextBox.innerHTML = '';
	                guideTextBox.style.display = 'none';
	            }
	        }
	    }).open();
	}
	
</script>
<script type="text/javascript">

$(function() {
	// 아이디는 영문 소문자와 숫자 6~12자리까지
	var regExpId = /^[a-z0-9]{6,12}$/;
	
	// 이름은 한글 2~7자리
	var regExpNm = /^[가-힣]{2,7}$/;
	
	// 비밀번호는 영문소문자, 숫자, 특수문자 조합 8~15자리
	var regExpPw = /^(?=.*[a-z0-9])(?=.*\d)(?=.*[!@#$%^&*()_+={}\[\]?/~-]).{6,12}$/;
	
	// 이메일 정규식 @ 뒤에 2자리 이상의 도메인이 있어야 함
	/* var regExpEmail = /^[a-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/; */
	
	// 이메일 정규식
	var regExpEmail = /^[a-z0-9._%+-]{6,12}$/;
	
	// 도메인 정규식
	var regExpDomain = /^[a-z0-9.-]+\.[a-z]{2,}$/;
	
	// 연락처 시작 010~019까지 앞3글자 사용 뒤에 8글자까지 11자리
	var regExpTel1 = /^(010|011|016|017|019)$/; // 첫 번째 부분: 010, 011 등
    var regExpTel2 = /^[0-9]{3,4}$/; // 두 번째 부분: 3~4자리 숫자
    var regExpTel3 = /^[0-9]{4}$/; // 세 번째 부분: 4자리 숫자
	
	var joinFrm = $("#joinFrm");
	var memId = $("#memId");
	var memName = $("#memName");
	var memPass = $("#memPass");
	var memEmail1 = $("#memEmail1");
    var memEmail2 = $("#memEmail2");
    var tel1 = $("#memTel1");
    var tel2 = $("#memTel2");
    var tel3 = $("#memTel3");
	var memAddr = $("#memAddr");
	var memBirth = $("#memBirth");
	
	
	var memIdFlag = false;
	memId.on("focusout", function() {
	    var idErr = $("#idErr");
	    if (!regExpId.test(memId.val())) {
	        idErr.text("아이디는 영문 소문자와 숫자 6~12자리까지 허용됩니다.");
	        idErr.css("color", "red");
	        idErr.css("display", "block");
	        memIdFlag = false;
	    } else {
	    	idErr.text("정상적으로 입력되었습니다.");
			idErr.css("color", "green");
	        idErr.css("display", "block");
	        memIdFlag = true;
	    }
	    console.log("memIdFlag : " + memIdFlag);
	});
	
	var memPassFlag = false;
	memPass.on("focusout", function(){
		var passErr = $("#passErr");
		if(!regExpPw.test(memPass.val())) {
			passErr.text("비밀번호는 영문소문자, 숫자, 특수문자 조합 8~15자리까지 허용됩니다.");
			passErr.css("color", "red");
			passErr.css("display", "block");
			memPassFlag = false;
		} else {
			passErr.text("정상적으로 입력되었습니다.");
			passErr.css("color", "green");
			passErr.css("display", "block");
			memPassFlag = true;
		}
		console.log("memPassFlag : " + memPassFlag);
	});
	
	var memNmFlag = false;
	memName.on("focusout", function(){
		var nmErr = $("#nmErr");
		if(!regExpNm.test(memName.val())) {
			nmErr.text("이름은 한글 2~7자리까지 허용됩니다.");
			nmErr.css("color", "red");
			nmErr.css("display", "block");
			memNmFlag = false;
		} else {
			nmErr.text("정상적으로 입력되었습니다.");
			nmErr.css("color", "green");
			nmErr.css("display", "block");
			memNmFlag = true;
		}
		console.log("memNmFlag : " + memNmFlag);
	});
	
	var memEmail1Flag = false;
	memEmail1.on("focusout", function(){
		var emailErr1 = $("#emailErr1");
		if(!regExpEmail.test(memEmail1.val())) {
			emailErr1.text("이메일을 입력해주세요");
			emailErr1.css("color", "red");
			emailErr1.css("display", "block");
			memEmail1Flag = false;
		} else {
			emailErr1.text("정상적으로 입력되었습니다.");
			emailErr1.css("color", "green");
			emailErr1.css("display", "block");
			memEmail1Flag = true;
		}
		console.log("memEmail1Flag : " + memEmail1Flag);
	});
	
	var memEmail2Flag = false;
	memEmail2.on("focusout", function(){
		var emailErr2 = $("#emailErr2");
		if(!regExpDomain.test(memEmail2.val())) {
			emailErr2.text("도메인을 입력해주세요");
			emailErr2.css("color", "red");
			emailErr2.css("display", "block");
			memEmail2Flag = false;
		} else {
			emailErr2.text("정상적으로 입력되었습니다.");
			emailErr2.css("color", "green");
			emailErr2.css("display", "block");
			memEmail2Flag = true;
		}
		console.log("memEmail2Flag : " + memEmail2Flag);
	});
	
	var telFlag2 = false;
	tel2.on("focusout", function(){
		var telErr2 = $("#telErr2");
		if(!regExpTel2.test(tel2.val())) {
			telErr2.text("두번째 번호 4자리 입력해주세요");
			telErr2.css("color", "red");
			telErr2.css("display", "block");
			telFlag2 = false;
		} else {
			telErr2.css("display", "none");
			telFlag2 = true;
		}
	});
	
	var telFlag3 = false;
	tel3.on("focusout", function(){
		var telErr3 = $("#telErr3");
		if(!regExpTel3.test(tel3.val())) {
			telErr3.text("세번째 번호 4자리 입력해주세요");
			telErr3.css("color", "red");
			telErr3.css("display", "block");
			telFlag3 = false;
		} else {
			telErr3.css("display", "none");
			telFlag3 = true;
		}
	});
	var idCheckFlag = false;
	$("#btnIdCheck").click(function(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var memId = $.trim($("#memId").val());
		console.log("memId : " + memId);
		if(memId == "") {
			alert("아이디를 입력해주세요.")
			$("#memId").focus();
			return false;
		}
		// idCheck.do로 데이터 전송 - 비동기 전송 방식
		$.ajax({
			type: "POST",
			url: "/idCheck.do",
			data: {
				memId: memId
			},
			beforeSend: function(xhr) {
                // 데이터를 전송하기 전에 헤더에 CSRF 값을 설정한다.
                xhr.setRequestHeader(header, token);
            },
			success: function(data) {
				console.log(data);
				if(data == "ok") {
					alert("사용 가능한 ID입니다.");
					idCheckFlag = true;
				} else if(data == "fail") {
					$("#idErr").text("사용중인 아이디입니다.")
					$("#idErr").css("display", "block");
					$("#idErr").css("color", "red");
					idCheckFlag = false;
					alert("이미 사용중인 ID입니다.");
				}
			}
		});
		
	});
	
	$("#submitBtn").on("click", function(event) {
	    // 기본 동작 방지
	    event.preventDefault();

	    let valid = true; // 모든 필드가 유효한지 확인하는 플래그

	    // 각 필드 검사
	    const inputs = $("input[required]");
	    inputs.each(function() {
	        if (!$(this).val()) {
	            valid = false;
	            $(this).next(".error-message").show(); // 에러 메시지 표시
	        } else {
	            $(this).next(".error-message").hide(); // 에러 메시지 숨김
	        }
	    });
	    console.log("valid : " + valid);
		console.log("idCheckFlagidCheckFlag : " + idCheckFlag);
	    // 추가적으로 아이디 중복 체크 확인
	   /*  if (!idCheckFlag) {
	        alert("아이디 중복체크 해주세요");
	        valid = false; // 아이디 중복 체크가 실패하면 valid를 false로 설정
	        console.log("idCheckFlag :" + idCheckFlag);
	    } else {
	    	idCheckFlag = true;
	    } */

	    // 모든 필드가 유효하면 폼 제출
	    if (valid) {
	    	console.log("야이자식아 :" + valid);
	        $("#joinFrm").submit(); // 폼 제출
	    }
	});
	
	$("#autoBtn").on("click", function() {
		$("#memId").val("pcpm11");
		$("#memPass").val("523523asd~!");
		$("#memName").val("박상협");
		$("#memEmail1").val("pcpm13");
		$("#memEmail2").val("naver.com");
		$("#memTel1").val("010");
		$("#memTel2").val("6462");
		$("#memTel3").val("0603");
	});
	
	
})
</script>
</html>