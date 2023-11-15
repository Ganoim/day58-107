<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>board/boardWriteForm.jsp</h1>
	<h2>글작성 페이지</h2>
	<form action="${pageContext.request.contextPath}/boardWrite" method="get">
		<input type="text" name="bno" placeholder="글번호">
		<br>
		<input type="text" name="bwriter" placeholder="작성자">
		<br>
		<input type="text" name="btitle" placeholder="제목">
		<br>
		<textarea type="text" name="bcontents" placeholder="글내용"></textarea>
		<br>
		<input type="submit" value="글등록">
	</form>
	
	
	
</body>
</html>