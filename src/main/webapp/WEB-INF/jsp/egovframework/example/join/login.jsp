<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <!-- 나의 스타일 추가 -->

  </head>
  <style>
  	html, body {
  height: 100%;
  background: #ffffff;
}

#container {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  height: 100%;
}

#loginBox {
  width: 300px;
  text-align: center;
  background-color: #ffffff;
}
.input-form-box {
  border: 0px solid #ff0000;
  display: flex;
  margin-bottom: 5px;
}
.input-form-box > span {
  display: block;
  text-align: left;
  padding-top: 5px;
  min-width: 65px;
}
.button-login-box {
  margin: 10px 0;
}
#loginBoxTitle {
  color:#000000;
  font-weight: bold;
  font-size: 32px;
  text-transform: uppercase;
  padding: 5px;
  margin-bottom: 20px;
  background: linear-gradient(to right, #270a09, #8ca6ce);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
#inputBox {
  margin: 10px;
}

#inputBox button {
  padding: 3px 5px;
}
  </style>
  <body class="text-center">
    <form name="frm" method="post" action="/loginSave.do">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <!--  html 전체 영역을 지정하는 container -->
    <div id="container">
      <!--  login 폼 영역을 : loginBox -->
      <div id="loginBox">
      
        <!-- 로그인 페이지 타이틀 -->
        <div id="loginBoxTitle">Login</div>
        <!-- 아이디, 비번, 버튼 박스 -->
        <div id="inputBox" class="row">
        	<sec:csrfInput/>
          <div class="input-form-box"><span>아이디</span><input type="text" name="username" class="form-control"></div><br>
          <div class="input-form-box"><span>비밀번호</span><input type="password" name="password" class="form-control"></div>
          <div class="button-login-box" >
            <button type="submit" class="btn btn-primary btn-xs" style="width:40%">로그인</button>
            <button type="button" onClick="location.href='/join.do'" class="btn btn-primary btn-xs" style="width:35%">회원가입</button>
          </div>
        </div>
        
      </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <sec:csrfInput/>
    </form>
    <!-- Bootstrap Bundle with Popper -->

</body>
</html>

<script>
	var name = document.getElementsByName("username");
	console.log("name" + name);
	var password = document.getElementsByName("password");
	console.log("password" + password);
</script>