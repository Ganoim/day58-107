<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>MemberJoin</h1>
	<h2>메인페이지</h2>
	<a href="${pageContext.request.contextPath}/boardWriteForm">글쓰기</a>

	
	
	
	<hr>
	<!-- MemberController >> /memberJoin -->
	<form action="${pageContext.request.contextPath}/memberJoin" method="get">
		<input type="text" name="mid" placeholder="아이디">
		<br>
		<input type="text" name="mpw" placeholder="비밀번호">
		<br>
		<input type="text" name="mname" placeholder="이름">
		<br>
		<input type="date" name="mbirth">
		<br>
		<input type="text" name="maddr" placeholder="주소">
		<br>
		<input type="submit" value="회원가입">
	</form>
	<hr>
	
	<a href="${pageContext.request.contextPath}/memberList">회원목록</a>
	
</body>
</html>