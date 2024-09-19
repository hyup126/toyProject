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
  <style>
    body {
      min-height: 100vh;
      background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
    }

    .input-form {
      max-width: 680px;
      margin-top: 80px;
      padding: 32px;
      background: #fff;
      border-radius: 10px;
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }

    .form-row {
      display: flex;
      justify-content: space-between;
    }

    .form-group {
      width: 100%;
    }

    .btn-check-duplicate {
      margin-left: 10px;
      height: 38px;
    }

    .input-container {
      display: flex;
      align-items: center;
    }
  </style>
</head>

<body>
  <div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">회원가입</h4>
        <form name="joinFrm" class="validation-form" novalidate method="post" action="/joinSave.do">
        <sec:csrfInput />
        <div class="row">
            <div class="col-md-6 mb-3">
              <label for="memId">아이디</label>
              <div class="input-container">
                <input type="text" class="form-control" id="memId" name="memId" placeholder="아이디를 입력하세요" value="" required>
                <button type="button" id="btnIdCheck" class="btn btn-primary btn-check-duplicate" style="font-size:10px;">중복 체크</button>
              </div>
              <div class="invalid-feedback">
                아이디를 입력해주세요.
              </div>
            </div>
            <div class="col-md-6 mb-3">
              <label for="memPass">비밀번호</label>
              <input type="password" class="form-control" name="memPass" placeholder="비밀번호를 입력하세요" value="" required>
              <div class="invalid-feedback">
                비밀번호를 입력해주세요.
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="memName">이름</label>
              <input type="text" class="form-control" name="memName" placeholder="이름을 입력하세요" value="" required>
              <div class="invalid-feedback">
                이름을 입력해주세요.
              </div>
            </div>
            <div class="col-md-6 mb-3">
              <label for="memEmail">이메일</label>
              <input type="text" class="form-control" name="memEmail" placeholder="이메일을 입력하세요" value="" required>
              <div class="invalid-feedback">
                이메일을 입력해주세요.
              </div>
            </div>
          </div>
          
		<div class="row">
          <div class="col-md-6 mb-3">
            <label for="memTel">연락처</label>
            <input type="text" class="form-control" name="memTel" placeholder="" required>
            <div class="invalid-feedback">
              연락처를 입력해주세요.
            </div>
          </div>
          
          <div class="col-md-6 mb-3">
            <label for="memBirth">생년월일</label>
            <input type="date" class="form-control" name="memBirth" required>
            <div class="invalid-feedback">
            </div>
          </div>
		</div>
		<!-- <div class="row">
          <div class="col-md-6 mb-3">
            <label for="taBirthDate">생년월일</label>
            <input type="date" class="form-control" id="taBirthDate" required>
            <div class="invalid-feedback">
            </div>
          </div>
          <div class="col-md-6 mb-3">
            <label for="taHireDate">입사일</label>
            <input type="date" class="form-control" id="taHireDate" required>
          </div>
         </div> -->


         <!-- <div class="row">
            <div class="col-md-6 mb-3">
              <label for="memAddr">주소</label>
              <input type="text" class="custom-select d-block w-100" name="memAddr" id="sample4_postcode" placeholder="우편번호">
              <div class="invalid-feedback">
                주소를 선택해주세요.
              </div>
            </div>
            <div class="col-md-6 mb-3">
              <label for="memAddr2">상세주소</label>
              <input type="text" class="form-control" name="memAddr2" placeholder="상세주소 입력" required>
            </div>
          </div> -->
          
           <div class="row">
            <div class="col-md-12 mb-3 address-inputs">
              <label for="sample4_postcode">주소 검색</label>
              <input type="text" id="sample4_postcode" name="memAddr" placeholder="우편번호" class="form-control" readonly>
              <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="btn btn-primary mt-2">
              <input type="text" id="sample4_roadAddress" name="memAddr" placeholder="도로명주소" class="form-control mt-2" readonly>
              <input type="text" id="sample4_jibunAddress" name="memAddr" placeholder="지번주소" class="form-control mt-2" readonly>
              <input type="text" id="sample4_detailAddress" name="memAddr2" placeholder="상세주소" class="form-control mt-2">
              <span id="guide" style="color:#999;display:none"></span>
            </div>
          </div>
          <hr class="mb-4">
          <!-- <div class="custom-control custom-checkbox">
            <input type="checkbox" class="custom-control-input" id="aggrement" required>
            <label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
          </div> -->
          <div class="mb-4"></div>
          <button class="btn btn-primary btn-lg btn-block" type="submit">등록 완료</button>
        </form>
      </div>
    </div>
    <footer class="my-3 text-center text-small">
      <p class="mb-1">&copy; 2024 TS</p>
    </footer>
  </div>
  <script>
    window.addEventListener('load', () => {
      const forms = document.getElementsByClassName('validation-form');

      Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
          }

          form.classList.add('was-validated');
        }, false);
      });
    }, false);
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
	            if(roadAddr !== ''){
	                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
	            } else {
	                document.getElementById("sample4_extraAddress").value = '';
	            }
	
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
	$("#btnIdCheck").click(function(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var memId = $.trim($("#memId").val());
		var data = {
				"memId" : memId
		}
		if(memId == "") {
			alert("아이디를 입력해주세요.")
			$("#memId").focus();
			return false;
		}
		// idCheck.do로 데이터 전송 - 비동기 전송 방식
		$.ajax({
			type: "POST",
			contentType: "application/json",
			url: "idCheck.do",
			data: JSON.stringify(data),
			beforeSend: function(xhr) {
                // 데이터를 전송하기 전에 헤더에 CSRF 값을 설정한다.
                xhr.setRequestHeader(header, token);
            },
			async: true, // 동기, 비동기 여부
			cache: false, // 캐시 여부
			dataType: "json",
			success: function(result) {
				if(result.trim() == "ok") {
					alert("사용 가능한 ID입니다.");
				} else {
					alert("이미 사용중인 ID입니다.")
				}
			}, error: function() {	// 장애발생
				alert("오류 발생");
			}
		});
		
	});
})
</script>
</html>