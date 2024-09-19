<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="css\egovframework\boardList.css">
<body>
<h3>새 글 작성</h3>
<form action="createPost.jsp" method="post">
    <table class="generalTable" width="100%">
        <tr>
            <th>제목</th>
            <td><input type="text" name="title" size="60"></td>
        </tr>
        <tr>
            <th>작성자</th>
            <td><input type="text" name="author" size="30"></td>
        </tr>
        <tr>
            <th>내용</th>
            <td><textarea name="content" rows="10" cols="60"></textarea></td>
        </tr>
        <tr>
            <td colspan="2" class="emphasisCenter">
                <input type="submit" value="글 작성">
            </td>
        </tr>
    </table>
</form>
</body>
</html>