<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout Form</title>
</head>
<body>
	<h2>Logout Form</h2>
	
	<form action="" method="post">
		<input type="submit" value="로그아웃"/>
		<sec:csrfInput/>
	</form>
</body>
</html>